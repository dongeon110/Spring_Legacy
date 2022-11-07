package board.dongeon.service;

import board.dongeon.domain.vo.MemberVO;

public interface MemberService {

    public void getMember(String userid); // 회원 정보 가져오기

    public void memberCreate(MemberVO memberVO); // 회원가입

    public void memberUpdate(MemberVO memberVO); // 회원 정보 수정

    public void memberDelete(MemberVO memberVO); // 회원 탈퇴
    
    public boolean isDuplicated(String userid); // 회원 id 중복확인
}
