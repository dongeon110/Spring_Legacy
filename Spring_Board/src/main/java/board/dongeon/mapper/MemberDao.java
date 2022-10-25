package board.dongeon.mapper;

import board.dongeon.domain.vo.MemberVO;

public interface MemberDao {
    public MemberVO read(String userid);
}