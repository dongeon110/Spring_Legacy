package board.dongeon.service;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.dto.ReplyPageDTO;
import board.dongeon.domain.vo.ReplyVO;

import java.util.List;

public interface ReplyService {

    public ReplyPageDTO getListPage(SearchInfo searchInfo, int pno);

    public List<ReplyVO> getList(SearchInfo searchInfo, int pno);

    public ReplyVO get(int rno);

    public int register(ReplyVO replyVO);

    public int modify(ReplyVO replyVO);

    public int remove(int rno);

}
