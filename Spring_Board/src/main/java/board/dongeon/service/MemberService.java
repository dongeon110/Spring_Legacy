package board.dongeon.service;

import board.dongeon.domain.vo.MemberVO;

public interface MemberService {

    public void getMember(String userid);

    public void memberCreate(MemberVO memberVO);

    public void memberUpdate(MemberVO memberVO);

    public void memberDelete(MemberVO memberVO);
}
