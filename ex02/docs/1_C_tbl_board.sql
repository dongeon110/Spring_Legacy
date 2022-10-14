CREATE TABLE tbl_board (
	bno serial primary key,
	title varchar(200) not null,
	bcontent varchar(2000) not null,
	writer varchar(50) not null,
	regdate date default now(),
	updatedate date default now()
)