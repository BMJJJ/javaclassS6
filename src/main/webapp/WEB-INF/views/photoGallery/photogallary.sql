show tables;

create table photoGallery(
	idx int not null auto_increment,
	mid varchar(20) not null,
	nickName varchar(20) not null,
	title varchar(20) not null,
	content text not null,
	readNum int default 0,
	pDate datetime default now(),
	thumbnail	varchar(50) not null,			/* 포토갤러리에 올린 사진 이름 */
	good int default 0,
	part varchar(20) not null,
	photoCount 	int not null,
	primary key(idx),
	foreign key(mid) references member(mid)
);

drop table photoGallery;
select pg.*,(select fSName from photoStorage where photoIdx=pg.idx limit 1) as fSName from photoGallery pg order by pg.idx desc;
select pg.*,(select fSName from photoStorage where photoIdx=pg.idx limit 1) as fSName, (select count(*) as replyCnt from photoReply where photoIdx=pg.idx) from photoGallery pg order by pg.idx desc;

create table photoReply (
  idx  int not null auto_increment,
  mid   varchar(20) not null,				/* 포토갤러리에 댓글 올린이 아이디 */
  photoIdx int not null,						/* 포토갤러리 고유번호 */
  content  text not null,						/* 포토갤러리 댓글 내용 */
  prDate   datetime default now(),	/* 댓글 입력일자 */
  primary key(idx),
  foreign key(photoIdx) references photoGallery(idx),
  foreign key(mid) references member(mid)
);
drop table photoReply;
select * from photoReply;

create table photoSingle (
  photo  varchar(50) not null
);
