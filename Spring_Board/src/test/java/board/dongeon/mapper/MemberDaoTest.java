package board.dongeon.mapper;

import board.dongeon.domain.vo.MemberVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class MemberDaoTest {

    @Setter(onMethod_ = @Autowired)
    private MemberDao dao;

    @Test
    public void testRead() {
        MemberVO vo = dao.read("admin90");
        log.info(vo);

        vo.getAuthList().forEach(authVO -> log.info(authVO));
    }
}
