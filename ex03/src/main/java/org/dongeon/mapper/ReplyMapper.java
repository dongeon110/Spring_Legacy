package org.dongeon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.dongeon.domain.Criteria;
import org.dongeon.domain.ReplyVO;

public interface ReplyMapper {

    public int insert(ReplyVO vo);
    
    public ReplyVO read(long rno); // 특정 댓글 읽기

    public int delete(Long rno);

    public int update(ReplyVO reply);

    // @Param -> MyBatis에 두개 이상의 파라미터를 전달하기 위한 방법 중 하나
    public List<ReplyVO> getListWithPaging(
            @Param("cri") Criteria cri,
            @Param("bno") Long bno);
}
