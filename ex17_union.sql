-- ex17_union.sql

/*
union
-테이블을 합치는 기술
- 종

join
-테이블을 합치는 기술
- 횡

*/

create table 과장
as
select * from tblinsa where jikwi = '과장';

create table 부장
as
select * from tblinsa where jikwi = '부장'; 


select * from 과장; --8
select * from 부장; --5

-- union:구조가 같은 2개 이상 테이블을 하나로 합친다
select * from 과장
union
select * from 부장; -- 8+5

select name,ssn from 과장
union
select name,basicpay from 부장;

-- 구조가 동일하다고 해도 union을 하면 안된다. (***) > 구조와 의미가 모두 같아야 가능!!!
select name,sudang from 과장
union
select name,basicpay from 부장;

-- 두 셋의 컬럼 수도 동일해야 한다.
select name,basicpay,ssn from 과장
union
select name,basicpay,null from 부장;


-- 여러 테이블을 1개의 테이블로 취합(***)하는 용도
select name from tblCustomer
union
select name from tblMember
union
select last||first as name from tblname
union
select name from tblStaff;


-- 회사(부서별 게시판)
-- 1. 게시판 테이블 1개만 구성
--    :게시물의 부서를 구분하는 컬럼 생성 & 사용 
--    : 업무중 모든 게시물을 접근하는 업무가 빈번할 때

-- 2. 게시판 테이블 부서별 구성
--    : 부서별로 별도의 테이블 생성
--    : 쪼개서 볼 업무가 많고, 합쳐서 볼 업무가 적을 때

-- 영업부, 총무부, 기획부 게시판

create table tblBoard1
(
    seq number primary key,
    subject varchar2(1000) not null
);

create table tblBoard2
(
    seq number primary key,
    subject varchar2(1000) not null
);

create table tblBoard3
(
    seq number primary key,
    subject varchar2(1000) not null
);

delete from tblBoard1;
delete from tblBoard2;
delete from tblBoard3;

-- 게시물
insert into tblBoard1 values (1,'영업부 게시판입니다');
insert into tblBoard1 values (2,'영업부 회식입니다');
insert into tblBoard1 values (3,'영업부 공지입니다');

insert into tblBoard2 values (1,'총무부 게시판입니다');
insert into tblBoard2 values (2,'ㅊㅇ무부 게시판입니다');

insert into tblBoard3 values (1,' 기획 게시판입니다');
insert into tblBoard3 values (2,'기획 게시판입니다');
insert into tblBoard3 values (3,'기획 게시판입니다');
insert into tblBoard3 values (4,'ㅊㅁㄴ부 게시판입니다');


------------------------------------------------------------

-- 일련번호 + 겹치지 않는 숫자 > sequence 객체
create sequence boardSeq;
insert into tblBoard1 values (boardSeq.nextval,'영업부 게시판입니다');
insert into tblBoard1 values (boardSeq.nextval,'영업부 회식입니다');
insert into tblBoard1 values (boardSeq.nextval,'영업부 공지입니다');

insert into tblBoard2 values (boardSeq.nextval,'총무부 게시판입니다');
insert into tblBoard2 values (boardSeq.nextval,'ㅊㅇ무부 게시판입니다');

insert into tblBoard3 values (boardSeq.nextval,' 기획 게시판입니다');
insert into tblBoard3 values (boardSeq.nextval,'기획 게시판입니다');
insert into tblBoard3 values (boardSeq.nextval,'기획 게시판입니다');
insert into tblBoard3 values (boardSeq.nextval,'ㅊㅁㄴ부 게시판입니다');




select * from tblBoard1;
select * from tblBoard2;
select * from tblBoard3;

-- 사장님 -> 모든 게시물을 한번에 보게 해달라..

select * from
    (select * from tblBoard1
    union
    select * from tblBoard2
    union
    select * from tblBoard3)
    order by seq desc;




-- 싸이월드
-- 방명록 : 게시물 5년치 > 올해 6년차
-- 1. 1개 테이블 사용
-- : 일괄검색, 통합관리 편함.
-- : 데이터가 많아질수록 검색에 시간이 오래걸림
-- 2. 여러개 테이블 사용
-- : 테이블 개당 레코드를 줄여서 검색 속도를 줄이자
-- : 통합 관리 > union 등의 기술을 사용해서 (통합,비용발생)


 
create table tblUnionA
(
    name varchar2(50) NOT NULL
);
 
create table tblUnionB
(
    name varchar2(50) NOT NULL
);

INSERT INTO tblUnionA values('사과');
INSERT INTO tblUnionA values('귤');
INSERT INTO tblUnionA values('파인애플');
INSERT INTO tblUnionA values('바나나');
INSERT INTO tblUnionA values('포도');


INSERT INTO tblUnionB values('키위');
INSERT INTO tblUnionB values('바나나');
INSERT INTO tblUnionB values('오렌지');
INSERT INTO tblUnionB values('포도');
INSERT INTO tblUnionB values('복숭아');

SELECT * from tblUnionA;
SELECT * from tblUnionB;

SELECT name,count(*) from
(SELECT * from tblUnionA
UNION -- 중복값은 제거
SELECT * from tblUnionB) group by name;

SELECT * from tblUnionA
UNION all-- 중복값도 표현
SELECT * from tblUnionB;

SELECT name,count(*) from
(SELECT * from tblUnionA
UNION ALL -- 중복값은 표현
SELECT * from tblUnionB) group by name having count(*)>1;


select * from tblinsa where buseo = '기획부'
UNION
select * from tblinsa where jikwi = '대리';


SELECT * FROM tblUnionA
intersect -- 교집합
SELECT * FROM tblUnionB;

select * from tblUnionA
minus -- A-B -> A에만 있는 것만
select * from tblUnionB;

select * from tblUnionB
minus -- B-A -> B에만 있는 것만
select * from tblUnionA;
