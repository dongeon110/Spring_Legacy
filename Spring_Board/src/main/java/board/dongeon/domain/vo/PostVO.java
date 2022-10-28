package board.dongeon.domain.vo;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.Date;

import lombok.Data;

@Data
public class PostVO {

    private int rowNum;
    private int postNo;
    private String postSubject;
    private String postText;
    private String posterName;
    private Timestamp postCreatedDate;
    private Timestamp postUpdateDate;
    private int postViews;

    private int regroup;
    private int redepth;
    private int reorder;
    private boolean enabled;

    private int cntReply;
    private int cntRepost;
}
