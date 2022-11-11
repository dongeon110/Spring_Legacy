package board.dongeon.service;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.dto.UpdateAuthDTO;
import board.dongeon.domain.vo.MemberVO;

import java.util.List;

public interface MemberService {

    public List<MemberVO> getMemberList(SearchInfo searchInfo); // 회원 리스트

    public MemberVO getMember(String userid); // 회원 정보 가져오기

    public void memberCreate(MemberVO memberVO); // 회원가입

    public void memberUpdate(MemberVO memberVO); // 회원 정보 수정

    public void memberDelete(MemberVO memberVO); // 회원 탈퇴
    
    public boolean isDuplicated(String userid); // 회원 id 중복확인

    public int getTotal(SearchInfo searchInfo); // 전체 회원 수 (for Paging)

    public void addAuth(UpdateAuthDTO updateAuthDTO); // 회원 신규 권한 부여
    
    public void deleteAuth(UpdateAuthDTO updateAuthDTO); // 회원 기존 권한 삭제
}
