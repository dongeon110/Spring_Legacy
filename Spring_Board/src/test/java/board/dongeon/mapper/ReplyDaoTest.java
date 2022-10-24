package board.dongeon.mapper;


import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.vo.ReplyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.stream.IntStream;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyDaoTest {

    @Setter(onMethod_ = @Autowired)
    private ReplyDao dao;

    private int[] pnoArr = {130, 119};

    @Test
    public void testCreate() {
        IntStream.rangeClosed(1, 10).forEach(i -> {
            ReplyVO replyVO = new ReplyVO();

            replyVO.setPno(pnoArr[i % 2]);
            replyVO.setReply("댓글 테스트" + i);
            replyVO.setReplyer("테스터" + i);

            dao.insert(replyVO);
        });
    }

    @Test
    public void testRead() {
        int targetRno = 10;
        ReplyVO vo = dao.read(targetRno);
        log.info(vo);
    }

    @Test
    public void testReadList() {
        int targetPno = 130;
        SearchInfo searchInfo = new SearchInfo();
        searchInfo.setType("P");
        searchInfo.setKeyword("123");
        dao.getListWithPaging(searchInfo, targetPno).forEach(postVO -> log.info(postVO));
    }


    @Test
    public void testMapper() {
        log.info(dao);
    }
}
