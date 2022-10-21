package board.dongeon.domain.vo;

import java.util.Date;

import lombok.Data;

@Data
public class User {

    private int userNo;
    private String userID;
    private String userPassword;
    private String userName;
    private Date createdDate;
    private Date updateDate;
    private int grade;
}
