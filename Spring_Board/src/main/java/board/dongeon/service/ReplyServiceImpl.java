package board.dongeon.service;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.dto.ReplyPageDTO;
import board.dongeon.domain.vo.ReplyVO;
import board.dongeon.mapper.ReplyDao;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

    @Setter(onMethod_ = @Autowired)
    private ReplyDao replyDao;

    public ReplyPageDTO getListPage(SearchInfo searchInfo, int pno) {
        return new ReplyPageDTO(
                replyDao.getCountByPno(pno),
                replyDao.getListWithPaging(searchInfo, pno));
    }

    public List<ReplyVO> getList(SearchInfo searchInfo, int pno) {
        return replyDao.getListWithPaging(searchInfo, pno);
    }

    public ReplyVO get(int rno) {
        return replyDao.read(rno);
    }

    public int register(ReplyVO replyVO) {
        return replyDao.insert(replyVO);
    }

    public int modify(ReplyVO replyVO) {
        return replyDao.update(replyVO);
    }

    public int remove(int rno) {
        return replyDao.delete(rno);
    }
}
