show tables;

create table kakaoAddress (
	country varchar(50) not null,	/*지역명(서울,경기도,충청북도,충청남도,경상북도,경상남도,전라북도,전라남도,강원도)*/
	address varchar(50) not null,	/* 지점명*/
	latitude double null,					/*위도*/
	longitude double not null			/*경도*/
);

desc kakaoAddress;
drop table kakaoAddress;

select * from kakaoAddress order by address;
