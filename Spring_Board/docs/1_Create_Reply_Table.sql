CREATE TABLE reply (
    rno serial PRIMARY KEY,
    pno int REFERENCES board (pno) NOT NULL,
    reply varchar(1000) NOT NULL,
    replyer varchar(50) NOT NULL,
    replyDate timestamp default NOW(),
    updateDate timestamp default NOW()
);
