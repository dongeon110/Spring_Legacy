CREATE TABLE tbl_reply (
    rno serial PRIMARY KEY,
    bno int REFERENCES tbl_board (bno) NOT NULL,
    reply varchar(1000) NOT NULL,
    replyer varchar(50) NOT NULL,
    replyDate date default NOW(),
    updateDate date default NOW()
);

SELECT * FROM tbl_reply;