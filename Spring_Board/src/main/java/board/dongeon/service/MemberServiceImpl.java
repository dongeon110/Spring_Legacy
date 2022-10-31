package board.dongeon.service;

import board.dongeon.domain.vo.MemberVO;
import board.dongeon.mapper.MemberDao;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl {

    @Setter(onMethod_ = @Autowired)
    private MemberDao memberDao;

    public void memberCreate(MemberVO memberVO) { // 회원가입 기능
        log.info("memberCreate" + memberVO);
    }

    public void memberUpdate(MemberVO memberVO) { // 회원정보 수정
        
    }

    public void memberDelete(MemberVO memberVO) { // 회원탈퇴
        
    }
}
