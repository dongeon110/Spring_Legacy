package board.dongeon.service;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.vo.MemberVO;
import board.dongeon.mapper.MemberDao;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

    @Setter(onMethod_ = @Autowired)
    private MemberDao memberDao;

    @Override
    public List<MemberVO> getMemberList(SearchInfo searchInfo) {
        log.info("getMemberList SearchInfo: " + searchInfo);
        return memberDao.getMemberList(searchInfo);
    }

    @Override
    public MemberVO getMember(String userid) {
        log.info("getMember userid: " + userid);
        return memberDao.read(userid);
    }

    @Override
    public void memberCreate(MemberVO memberVO) { // 회원가입 기능
        log.info("memberCreate: " + memberVO);
        memberDao.memberInsert(memberVO);
    }

    @Override
    public void memberUpdate(MemberVO memberVO) { // 회원정보 수정
        
    }

    @Override
    public void memberDelete(MemberVO memberVO) { // 회원탈퇴
        
    }

    public boolean isDuplicated(String userid) { // 회원 ID 중복 확인
        log.info("isDuplicated id: " + userid);
        return memberDao.isDuplicated(userid) == 1;
    }

    public int getTotal(SearchInfo searchInfo) {
        int total = memberDao.getTotal(searchInfo);
        log.info("getTotal member: " + total);
        return total;
    }
}
