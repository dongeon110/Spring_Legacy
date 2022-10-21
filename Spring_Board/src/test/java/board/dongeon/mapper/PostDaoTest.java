package board.dongeon.mapper;


import board.dongeon.domain.SearchInfo;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PostDaoTest {

    @Setter(onMethod_ = @Autowired)
    private PostDao postDao;

    @Test
    public void testSearchList() {
        SearchInfo searchInfo = new SearchInfo();
        searchInfo.setType("P");
        searchInfo.setKeyword("123");
        postDao.searchList(searchInfo).forEach(postVO -> log.info(postVO));
    }
}
