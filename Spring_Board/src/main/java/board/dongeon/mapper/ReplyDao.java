package board.dongeon.mapper;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.vo.PostVO;
import board.dongeon.domain.vo.ReplyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReplyDao {

    public int insert(ReplyVO replyVO);

    public ReplyVO read(int rno);

    public int delete(int rno);

    public int update(ReplyVO reply);

    public List<ReplyVO> getListWithPaging(
            @Param("searchInfo") SearchInfo searchInfo,
            @Param("pno") int pno);

    public int getCountByPno(int pno);

}
