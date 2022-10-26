-- 자동 로그인 정보 테이블
CREATE TABLE persistent_logins (
    username varchar(100) not null,
    series varchar(100) primary key,
    token varchar(100) not null,
    last_used timestamp not null
);