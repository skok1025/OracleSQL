-- ex22_hierarchicalQuery.sql


/*
계층형 쿼리, HierarchicalQuery
- 오라클에서만 지원 
- 답변형 게시판, 카테고리 관리, BOM(자재 명세서) 등...
- 부모와 자식으로 구성된 트리 구조의 데이터를 처리하는 질의

컴퓨터
    - 본체
        -메인보드
        -그래픽카드
        -랜카드
        -메모리
    - 모니터
        -보호필름
    - 프린터
        -잉크 카트리지
        -A4 용지

*/
create table tblComputer
(
    seq number primary key,
    name varchar2(100) not null,
    qty number not null,
    pseq number references tblComputer(seq) -- 부모 부품 (FK)
);


insert into tblComputer values(1,'컴퓨터',1,null); -- 루트 노드

insert into tblComputer values(2,'본체',1,1);
insert into tblComputer values(3,'모니터',1,1);
insert into tblComputer values(4,'프린터',1,1);

insert into tblComputer values(5,'메인보드',1,2);
insert into tblComputer values(6,'그래픽카드',1,2);
insert into tblComputer values(7,'랜카드',1,2);
insert into tblComputer values(8,'메모리',2,2);

insert into tblComputer values(9,'보호필름',1,3);

insert into tblComputer values(10,'잉크 카트리지',1,4);
insert into tblComputer values(11,'A4용지',100,4);



select * from tblComputer;


-- 1. 셀프조인
-- : inner join or outer join > 동일한 테이블을 가지고 실행 > 상황

select c1.name as 부모부품, c2.name as 자식부품 From 
                                tblComputer c1 inner join tblComputer c2
                                                          on c1.seq = c2.pseq; -- c1(부모), c2(자식)


-- 2. 계층형 쿼리
-- : start with 절 connect by 절
select * from tblComputer
    start with seq = 1 -- 루트노드 지정
        connect by prior seq = pseq; -- 부모 자식을 연결 고리

-- 계층형 쿼리의 의사컬럼
select lpad(' ',(level-1)*5)||name,level from tblComputer
    start with seq = 1 
        connect by prior seq = pseq; 

-- prior : 계층형 쿼리 의사 컬럼 > 부모 레코드 참조
select lpad(' ',(level-1)*5)||name,level,prior name from tblComputer
    start with seq = 1 
        connect by prior seq = pseq; 


-- start with
select lpad(' ',(level-1)*5)||name,level,prior name from tblComputer
    --start with seq = 2
    --start with seq = (select seq from tblComputer where name = '컴퓨터')
    start with pseq is null -- root node
        connect by 
                    prior seq = pseq; 


drop table tblComment;
drop table tblBoard;


-- 계층형 게시판
create table tblBoard
(
    seq number primary key,
    subject varchar2(1000) not null,
    pseq number null -- 부모 글번호
);


-- 카테고리 테이블
create table tblCategory
(
    seq number primary key,
    name varchar2(100) not null,
    pseq number null -- 부모 카테고리
);

INSERT INTO tblboard VALUES (1, '1번 글입니다.', NULL);
INSERT INTO tblboard VALUES (2, '2번 글입니다.', NULL);
INSERT INTO tblboard VALUES (3, '3번 글입니다.', NULL);

INSERT INTO tblboard VALUES (4, '1번의 첫번째 답변글입니다.', 1);
INSERT INTO tblboard VALUES (5, '1번의 두번째 답변글입니다.', 1);
INSERT INTO tblboard VALUES (6, '1번의 세번째 답변글입니다.', 1);

INSERT INTO tblboard VALUES (7, '2번의 첫번째 답변글입니다.', 2);
INSERT INTO tblboard VALUES (8, '2번의 두번째 답변글입니다.', 2);

INSERT INTO tblboard VALUES (9, '3번의 첫번째 답변글입니다.', 3);
INSERT INTO tblboard VALUES (10, '3번의 두번째 답변글입니다.', 3);
INSERT INTO tblboard VALUES (11, '3번의 세번째 답변글입니다.', 3);

INSERT INTO tblboard VALUES (12, '1번의 첫번째 답변의 첫번째 답변글입니다.', 4);
INSERT INTO tblboard VALUES (13, '1번의 첫번째 답변의 두번째 답변글입니다.', 4);

INSERT INTO tblboard VALUES (14, '2번의 첫번째 답변의 첫번째 답변글입니다.', 7);
INSERT INTO tblboard VALUES (15, '3번의 두번째 답변의 첫번째 답변글입니다.', 10);


INSERT INTO tblcategory VALUES (1, '패션의류/잡화', NULL);
INSERT INTO tblcategory VALUES (2, '뷰티', NULL);
INSERT INTO tblcategory VALUES (3, '주방용품', NULL);
INSERT INTO tblcategory VALUES (4, '남성패션', 1);
INSERT INTO tblcategory VALUES (5, '여성패션', 1);
INSERT INTO tblcategory VALUES (6, '베이비패션', 1);
INSERT INTO tblcategory VALUES (7, '티셔츠', 4);
INSERT INTO tblcategory VALUES (8, '셔츠', 4);
INSERT INTO tblcategory VALUES (9, '블라우스', 5);
INSERT INTO tblcategory VALUES (10, '원피스', 5);
INSERT INTO tblcategory VALUES (11, '스커트', 5);
INSERT INTO tblcategory VALUES (12, '베이비 여아', 6);
INSERT INTO tblcategory VALUES (13, '베이비 남아', 6);
INSERT INTO tblcategory VALUES (14, '베이비 공용', 6);
INSERT INTO tblcategory VALUES (15, '스킨케어', 2);
INSERT INTO tblcategory VALUES (16, '향수', 2);
INSERT INTO tblcategory VALUES (17, '기초 화장품', 15);
INSERT INTO tblcategory VALUES (18, '클렌징', 15);
INSERT INTO tblcategory VALUES (19, '마스크', 15);
INSERT INTO tblcategory VALUES (20, '여성 향수', 16);
INSERT INTO tblcategory VALUES (21, '남성 향수', 16);
INSERT INTO tblcategory VALUES (22, '그릇', 3);
INSERT INTO tblcategory VALUES (23, '컵', 3);
INSERT INTO tblcategory VALUES (24, '일회용품', 3);
INSERT INTO tblcategory VALUES (25, '식기', 22);
INSERT INTO tblcategory VALUES (26, '유아식기', 22);
INSERT INTO tblcategory VALUES (27, '머그', 23);
INSERT INTO tblcategory VALUES (28, '와인잔', 23);
INSERT INTO tblcategory VALUES (29, '텀블러', 23);
INSERT INTO tblcategory VALUES (30, '위생백', 24);


commit;

select * from tblBoard;
select * from tblCategory;


-- 계층형 쿼리
select lpad(' ',(level-1)*5) || subject as subject from tblBoard
    -- where 절
    start with pseq is null
        connect by prior seq = pseq
            -- order by 절
            order siblings by seq desc;


-- 카테고리
select lpad(' ',(level-1)*5) || name from tblCategory
    start with pseq is null
        connect by prior seq = pseq
            order siblings by name asc;



-- 나머지...
select 
lpad(' ',(level-1)*5) || name as "현재 카테고리",
prior name as "부모 카테고리",
connect_by_root name as "루트 카테고리",
connect_by_isleaf,
sys_connect_by_path(name,'▷') as "경로"
    from tblCategory
    start with pseq is null
        connect by prior seq = pseq
            order siblings by name asc;










































