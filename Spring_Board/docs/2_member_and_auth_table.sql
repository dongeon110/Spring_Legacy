-- member : CREATE
CREATE TABLE member(
    userid varchar(100) not null primary key,
    userpw varchar(100) not null,
    username varchar(100) not null,
    regdate date default now(),
    updatedate date default now(),
    enabled boolean default 'T'
);

-- member : COMMENT
COMMENT ON COLUMN member.enabled IS 'T: 활성화, F: 비활성화';

-- member_auth : CREATE
CREATE TABLE member_auth (
    userid varchar(100) not null REFERENCES member(userid),
    auth varchar(50) not null
);
-- member_auth : UNIQUE
CREATE UNIQUE INDEX ix_auth_username ON member_auth (userid, auth);

-- SELECT
SELECT * FROM member;
SELECT * FROM member_auth;

SELECT userid username, userpw password, enabled FROM member;

