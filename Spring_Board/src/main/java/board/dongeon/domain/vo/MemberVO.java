package board.dongeon.domain.vo;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class MemberVO {
    private int rowNum;
    private String userid; // 아이디 pk
    private String userpw; // password
    private String userName; // 이름
    private boolean enabled; // 삭제 flag

    private Date regDate; // 생성일
    private Date updateDate; // 최근 수정일
    private List<AuthVO> authList; // 권한 리스트
}
