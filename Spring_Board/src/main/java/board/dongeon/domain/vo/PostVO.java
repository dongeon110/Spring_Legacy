package board.dongeon.domain.vo;

import java.time.LocalDate;
import java.util.Date;

import lombok.Data;

@Data
public class PostVO {

    private int rowNum;
    private int postNo;
    private String postSubject;
    private String postText;
    private String postPassword;
    private String posterName;
    private Date postCreatedDate;
    private Date postUpdateDate;
    private int repost;
    private int postViews;
    private int postUserNo;
}
