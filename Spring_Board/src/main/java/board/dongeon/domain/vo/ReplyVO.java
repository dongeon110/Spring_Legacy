package board.dongeon.domain.vo;

import lombok.Data;

import java.sql.Timestamp;
import java.util.Date;

@Data
public class ReplyVO {

    private int rno;
    private int pno;

    private String reply;
    private String replyer;
    private Timestamp replyDate;
    private Timestamp updateDate;
}
