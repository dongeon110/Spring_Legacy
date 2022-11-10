package board.dongeon.mapper;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.vo.MemberVO;

import java.util.List;

public interface MemberDao {
    public MemberVO read(String userid);

    public List<MemberVO> getMemberList(SearchInfo searchInfo);

    public void memberInsert(MemberVO memberVO); // 회원가입 기능

    public void memberUpdate(MemberVO memberVO); // 회원정보 수정

    public void memberDelete(String userid); // 회원탈퇴

    public int isDuplicated(String userid); // 회원 중복 확인

    public int getTotal(SearchInfo searchInfo); // 총 멤버 수
}