package board.dongeon.mapper;

import board.dongeon.domain.vo.MemberVO;

public interface MemberDao {
    public MemberVO read(String userid);

    public MemberVO getMember(String userid);

    public void memberInsert(MemberVO memberVO); // 회원가입 기능

    public void memberUpdate(MemberVO memberVO); // 회원정보 수정

    public void memberDelete(String userid); // 회원탈퇴

    public int isDuplicated(String userid); // 회원 중복 확인
}