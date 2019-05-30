--ex19_index.sql
/*
인덱스, index
- 색인
- 검색을 빠른 속도로 하기 위해서 사용하는 도구
- 오라클은 테이블 생성 시 인덱스를 따로 생성하지 않아도 자동으로 생성된다. -> pk, unique 컬럼 자동으로 색인 생성 
    -> num 컬럼 검색속도 (PK > Index 생성) >>>>> name 컬럼 검색 속도

*/

select * from tblinsa where num = 1001;
select * from tblinsa where name = '홍길동';


select count(*) from tblAddressBook;

create table tblIndex
as
select * from tblAddressBook;

select count(*) from tblIndex;

insert into tblIndex
    select * from tblInd은ex;
    
commit;    
    
select * from tblIndex where rownum<10;

select * from tblindex where name = '정소은';

-- name 컬럼에 인덱스 생성하기
create index idxIndexName
    on tblIndex(name);

select * from tblindex where name = '정소은';








/*
인덱스 장,단점
- 검색 처리 속도를 향상 시킨다.
- 비용이 비싸다.

인덱스 사용해야 하는 경우
1. 테이블 행의 갯수가 많은 경우
2. 인덱스를 적용한 컬럼이 where 절에 많이 사용되는 경우 (****)
3. join할 때 사용하는 컬럼 (on 부모테이블.PK = 자식테이블.FK) (****)
4. 검색 결과가 원본 테이블 데이터 2~4%에 해당하는 경우 (****)
5. 해당 컬럼이 NULL 을 포함하는 경우 (색인에 NULL 제외)

인덱스 사용하면 안 좋은 경우
1.테이블의 행의 갯수가 적은 경우
2. 검색결과가 원본 테이블 많은 비중을 차지하는 경우
3. 원본 테이블의 삽입,수정,삭제가 빈번한 경우 (****)

*/

select * from tbladdressbook;

-- 비고유 인덱스
-- 인덱스가 걸린 컬럼 > job > 중복값 존재
CREATE INDEX idxIndexJob 
    on tblIndex(job);

-- 고유 인덱스
-- 인덱스 걸린 컬럼 > seq > PK, Unique
create index idxIndexSeq
    on tblIndex(seq);
    
-- 단일 인덱스
-- 인덱션 걸 컬럼이 1개일때...
create index idxIndexEmail
    on tblIndex(email)

select * from tbindex where email = 'without_carry@live.com'; -- idxIndexEmail 동작 O
select * from tbindex where email = 'without_carry@live.com' and age =16; -- idxIndexEmail 동작 X
select * from tblindex where substr(name,1,1) ='김'; -- idxIndexName 동작 X , idxIndexLastName 동작 O

create index idxIndexLastName
    on tblIndex(substr(name,1,1));

select * from tblindex where name = '김길동'; -- idxIndexName 동작 O 
    
select * from tblindex where (height+weight)>200;

create index idxIndexBMI
    on tblIndex((height+weight))

-- 결합(다중) 인덱스
create index idxIndexEmailAge
    on tblIndex(email,age);

-- 하나의 테이블 : 여러개의 인덱스




-- 오라클은 키워드의 대/소문자를 구분하지 않는다. (SQL 특징)

select * from tblname;
SELECT * FROM tblname;







































