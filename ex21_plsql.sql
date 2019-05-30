--ex21_plsql.sql


create table tblFullname
(
    seq number primary key,
    fullname varchar2(45) not null,
    employee_id number(6) not null references employees(employee_id)
);

create sequence fullnameSeq;

select * from employees;

-- 프로시저 : id > full name 반환

create or replace procedure procGetFullname
(
pid in number,
pfullname out varchar2
)
is
    
begin
    select first_name||' '|| last_name into pfullname from employees
        where employee_id = pid;
    
end;

declare
    vfullname varchar2(45); -- out 파라미터에 대응할 실인자 변수
begin
    procGetFullname(101,vfullname);
    dbms_output.put_line(vfullname);
    procAddFullname(100,'Steven King');
end;


select * from tblFullname;

-- 프로시저 : fullname insert
create or replace procedure procAddFullname
(
    pid number,
    pfullname varchar2
)
is
begin
    insert into tblFullname(seq,fullname,employee_id) values (fullnameSeq.nextval,pfullname,pid);
end;



-- 위의 2개의 프로시저를 하나로 통합
create or replace procedure procInsertName
(
    pid in number
)
is 
    vfullname varchar2(45);
begin
    -- 1.
    procGetFullname(pid,vfullname); -- 반환값
    -- 2.
    procAddFullname(pid,vfullname);
end;


begin
    procInsertName(105);
    procInsertName(110);
    procInsertName(123);
end;

-- 프로시저 흔한 패턴 : CRUD
select * from tabs;


create table tblAddress
(
    seq number primary key, -- PK
    name varchar2(30) not null, -- 이름
    age number(3) not null,
    tel varchar2(15) not null,
    address varchar2(500) not null,
    regdate date default sysdate not null -- 등록시간
);

create sequence addressSeq;

-- C : 주소록 추가하기
create or replace procedure procAddAddress
(
    pname in varchar2,
    page in number,
    ptel in varchar2,
    paddress in varchar2,
    presult out number -- 추가 업무 성공 유무 (1: 성공, 0: 실패)
)
is 
begin
    insert into tblAddress(seq,name,age,tel,address,regdate)
                  values (addressSeq.nextval, pname, page, ptel, paddress, default);
    presult := 1;
    commit;
exception
    when others then 
        presult := 0;
    rollback;
end;



declare
    vresult number;
begin
    procAddAddress('홍길동',20,'010-1234-5678','서울시 강남구 역삼동',vresult);

    if vresult = 1 then 
        dbms_output.put_line('입력 성공');
    else
        dbms_output.put_line('입력 실패');
    end if;
end;

select * from tblAddress;

select * from tblAddressBook;


-- R : 읽기
-- 1명의 seq > 모든 정보 반환
create or replace procedure procReadAddress
(
    pseq in number, -- 알고싶은 주소록 번호
    pname out varchar2,
    page out number,
    ptel out varchar2,
    paddress out varchar2,
    pregdate out date,
    presult out number -- 성공 유무
)
is
    vcnt number;

begin

    select count(*) into vcnt from tblAddress where seq = pseq;

    if vcnt = 1 then
        select name,age,tel,address,regdate 
            into pname,page,ptel,paddress,pregdate
                from tblAddress
                    where seq = pseq;
                    
        presult := 1;
    else
        presult := 2;
    end if;
exception
    when others then
        presult := 0;
end procReadAddress;

declare
    vname tblAddress.name%type;
    vage tblAddress.age%type;
    vtel tblAddress.tel%type;
    vaddress tblAddress.address%type;
    vregdate tblAddress.regdate%type;
    vresult number;
begin
    procReadAddress(1,vname,vage,vtel,vaddress,vregdate,vresult);
    
    if vresult = 1 then 
        dbms_output.put_line(vname || '-' || vage);
    elsif vresult = 2 then 
        dbms_output.put_line('존재하지 않거나 이미 삭제된 번호를 입력했습니다.');
    else
        dbms_output.put_line('오라클 오류. 관리자에게 연락하세요.');
    end if;
end;



-- U : 주소록 중 1건(레코드) 수정하기
-- 번호(PK)
-- 이름,나이,전화,주소,등록일

procUpdateAddress(seq,'홍길돈');
procUpdateAddress(seq,'서울시 강동구 천호동');
procUpdateAddress(seq,'홍길돈',19);
procUpdateAddress(seq,'010-6866-9202','서울시 강남구 대치동');
--
--update tblAddress set
--    name = 새이름
--        where seq = 번호
--
--update tblAddress set
--    address = 새주소
--        where seq = 번호


procUpdateAddress(1,'홍길돈',20,'010-1234-5678','서울시 강남구 역삼동');




create or replace procedure procUpdateAddress
(
    pseq number,
    pname varchar2,
    page number,
    ptel varchar2,
    paddress varchar2,
    presult out number
)
is 
    vcnt number;
begin
    select count(*) into vcnt from tblAddress where seq = pseq;
    
    if vcnt = 1 then 
        update tblAddress set
            name = pname, age = page, tel = ptel, address = paddress
                where seq = pseq;
        presult := 1;
        commit;
    else 
        presult := 2;
    end if;
exception
    when others then
        presult := 0;
        rollback;   
end;


declare
    vresult number;
begin
    procUpdateAddress(5,'홍길동','스무살','010-1234-5678','서울시 강남구 역삼동',vresult);
    
    if vresult = 1 then 
        dbms_output.put_line('수정 완료');
    elsif vresult = 2 then 
        dbms_output.put_line('존재하지 않거나 이미 삭제된 정보입니다.');
    else
        dbms_output.put_line('오라클 오류');
    end if;
end;

select * from tblAddress;


-- D : 주소록 레코드 삭제
create or replace procedure procDeleteAddress
(
    pseq number,
    presult out number
)
is
    vcnt number;
begin
    
    select count(*) into vcnt from tblAddress where seq = pseq;
    
    if vcnt = 1 then
        delete from tblAddress where seq = pseq;
        presult := 1;
        commit;
    else
        presult := 2;
    end if;
    
exception 
    when others then
        presult :=0;
        rollback;
end;




declare
    vresult number;
begin
    procDeleteAddress(1,vresult);
    dbms_output.put_line(vresult);
end;

----------------------------------

-- 부모테이블 (pk) <-> 자식테이블 (fk + 일반컬럼) : 비식별 관계
-- 부모테이블 (pk) <-> 자식테이블 (fk + PK 컬럼) : 식별 관계

-- 회원 가입 > 회원 정보(주요 정보 + 보조 정보)

create table tblMain
(
    id varchar2(30) primary key,
    pw varchar2(30) not null,
    name varchar2(30) not null
);

create table tblSub
(
    id varchar2(30) primary key,
    age number null,
    tel varchar2(15) null,
    address varchar2(300) null,
    constraint tblSub_id_fk foreign key(id) references tblMain(id)
);


-- 회원 가입 프로시저
create or replace procedure procRegister
(
    pid varchar2,
    ppw varchar2,
    pname varchar2,
    page number,
    ptel varchar2,
    paddress varchar2
)
is
begin
    -- 1.
    insert into tblMain(id,pw,name) values (pid,ppw,pname);
    -- 2.
    insert into tblSub(age,tel,address,id) values (page,ptel,paddress,pid);

    commit;
    
exception
    when others then 
        rollback;
end;


begin
    --procRegister('hong','1234','홍길동',20,'010-2525-8223','서울시');
    procRegister('hong','1234','홍길동',20,'010-2525-82232314325423234343423','서울시');
end;

select * from tblMain;
select * from tblSub;


-- 저장 프로그램
-- 1. 저장 프로시저
-- : PL/SQL 내에서 사용가능

-- 2. 저장 함수
-- : PL/SQL or 표준 SQL 내에서 모두 사용가능
-- : ******* 표준 SQL 구문의 일부로 사용가능 (select, insert, update, delete)
-- : return 1개

-- 함수, Function
-- : 인자 (1개 이상) -> 반환값(1개) 프로시저
-- : out 파라미터 사용 금지 > return 문 사용

-- 프로시저
create or replace procedure procAAA
(
    pnum1 in number,
    pnum2 in number,
    presult out number
)
is 
begin
    presult := pnum1 + pnum2;
end;


declare
    vresult number;
    vheight number;
    vweight number;
begin
    procAAA(10,20,vresult);
    dbms_output.put_line(vresult);

    select height,weight into vheight,vweight from tblName where first = '재석';

    procAAA(vheight,vweight,vresult);
    dbms_output.put_line(vresult);
    


end;




-- 함수 선언
create or replace function fnBBB
(
    pnum1 number,
    pnum2 number
) return number
is
begin
    return pnum1+pnum2;
end;




declare
    vresult number;
    vheight number;
    vweight number;
begin
    dbms_output.put_line(fnBBB(20,30));
    vresult := fnBBB(50,60);
    dbms_output.put_line(vresult);
    
   
    
    vresult := fnBBB(vheight,vweight);
    dbms_output.put_line(vresult);
    
    -- 함수의 사용 목적
    select fnBBB(height,weight) into vresult from tblName where first = '재석';
    dbms_output.put_line(vresult);
     
end;


select fnBBB(height,weight)  from tblName where first = '재석';
select fnBBB(basicpay,sudang) from tblinsa;
select procAAA(basicpay,sudang) from tblinsa;






/*

프로시저 vs 함수
1. 매개변수
    a. 프로시저 : 0~ 마음대로
    b. 함수 : 1개~마음대로

2. 반환값
    a. 프로시저 : 0~마음대로 + out 파라미터
    b. 함수 : 1개 + return 문
3. 사용위치
    a. 프로시저 : PL/SQL 내
    B. 함수 : 표준 SQL 내
*/

select name,ssn from tblinsa;
select name,fnGender(ssn) from tblinsa;


-- ssn > 성별

create or replace function fnGender
(
    pssn varchar2
) return varchar2
is
begin
    case
        when substr(pssn,8,1) = '1' then return '남자';
        when substr(pssn,8,1) = '2' then return '여자';
        else return null;
    end case;
end;



/*
트리거,Trigger
- 프로시저의 일종
- 특정 사건이 발생하면 자동으로 실행되는 프로시저
- 개발자 실행(호출) X, DBMS 실행(호출) O
- 특정 사건 : 특정 테이블을 대상으로 오라클이 실시간 감시 (테이블 조작: insert, update, delete) -> 발생
            -> 미리 준비해놓은 프로시저를 자동으로 호출한다.
            
- 실시간 감시 : 비용 발생 > 최소한 필요한 업무만...

트리거 구문
create or replace trigger 트리거명
    -- 트리거 동작 옵션
    before|after -- 사건 발생전 | 후
    insert|update|delete -- 사건 종류
    on 테이블명 -- 사건 대상 테이블
    [for each row]
declare
    선언부;
begin
    실행부;
exception
    예외부;
end;
*/

drop trigger trgDeleteName;

-- 특정 요일(수) 에는 tblName의 데이터를 삭제할 수 없다 !!
create or replace trigger trgDeleteName
    before
    delete 
    on tblName
        
begin
    dbms_output.put_line('trgDeleteName 실행되었습니다.');

    if to_char(sysdate,'d') = 4 then
        -- 강제로 예외 발생
        -- 숫자(에러코드번호) : -20000 ~ 29990
        raise_application_error(-20000,'수요일에는 tblName을 삭제할 수 없습니다.');
    end if;

end;


select * from tblName;
delete from tblName where first = '재석';

drop trigger trgDeleteName;

COMMIT;
rollback;


select * from tblName; -- 12명
select * from tblLog; -- 2건
-- 로그 트리거
-- : tblName 에 변화가 생기면 나중에 관리자가 보기 위한 로그를 기록
select * from tblLog;

create or replace trigger trgName
    after
    delete or insert or update
    on tblName
    for each row
declare 
    vcode varchar2(10);
    vmessage varchar2(100);
begin
    --dbms_output.put_line(inserting);
    --dbms_output.put_line(updating);
    --dbms_output.put_line(deleting);
    
    if inserting then
        vcode := 'AAA0001';
        vmessage := 'tblName 테이블에 새로운 레코드가 추가되었습니다.';
    elsif updating then
        vcode := 'BBB001';
        vmessage := 'tblName 테이블에 레코드가 수정되었습니다.';
    elsif deleting then
        vcode := 'CCC001';
        vmessage := 'tblName 테이블에 레코드가 삭제되었습니다.';
    end if;
    
    insert into tblLog(seq,code,message,regdate) values ( logSeq.nextval,vcode,vmessage,default);
    
end;


insert into tblName values('하하','하','m',170,60,'별명');
update tblName set first = '호호' where first = '하하' and last = '하';
delete from tblName where first = '호호';


select * from tblLog;


/*
[for each row]

1. 생략
- 문장 단위 트리거
- 1회
- DML 에 의해 적용된 행의 갯수와 상관없이 DML 1회당 트리거 1회 호출

2. 사용
- 행 단위 트리거
- 반복
- DML 에 의해 적용된 행의 갯수만큼 트리거가 호출
- 상관 관계 변수 지원
    A. :old
    B. :new

2.1 insert 작업 발생
    - 트리거내에서 방금 insert 된 행의 컬럼값을 접근 가능하다.
    - :new <- 방금 추가된 행을 참조하는 변수
    - :new.컬럼명 <- 방금 추가된 행의 특정 컬럼값 참조
    - :old 사용 불가능
    - after 트리거에서만 사용이 가능함 (before 트리거에서는 사용 불가능)
    
2.2 update 작업 발생
    - 트리거 내에서 방금 수정된 행의 수정되기 전의 값과 수정된 후의 값을 접근 가능하다.
    - :new <- 방금 수정된 후의 행을 참조하는 변수
    - :old <- 방금 수정된 전의 행을 참조하는 변수
    
2.3 delete 작업 발생
    - 트리거 내에서 방금 삭제된 행의 값을 접근 가능
    - :old <- 방금 삭제된 행을 참조하는 변수
    - :new <- 사용불가  
*/

select * from tbltodo;

create or replace trigger trgInsertTodo 
    after
    insert
    on tblTodo
    for each row
begin
    dbms_output.put_line(:new.title); -- vrow
end;

insert into tblTodo values (20,'새로운 할일',sysdate,null);


create or replace trigger trgUpdateTodo 
    after
    update
    on tblTodo
    for each row
begin
    dbms_output.put_line(:old.title); -- vrow
    dbms_output.put_line(:new.title); -- vrow

end;

update tblTodo set title = '새할일 계획하기' where seq = 20;


create or replace trigger trgDeleteTodo 
    before
    update
    on tblTodo
    for each row
begin
    dbms_output.put_line(:old.title); -- vrow
end;

delete from tblTodo where seq = 22;

select * from tblTodo;

-- tblTodo : 할일이 등록되면 최소한 3일동안은 삭제가 불가능하다.


create table tblBoard
(
    seq number primary key, -- 글번호
    subject varchar2(1000) not null, -- 글제목
    regdate date default sysdate not null -- 글쓴날짜
);

create table tblComment
(
    seq number primary key, -- 댓글번호 (PK)
    subject varchar2(1000) not null, -- 글제목
    regdate date default sysdate not null, -- 글쓴날짜
    bseq number not null references tblBoard(seq) -- 부모글번호(FK)
);

create sequence boardSeq;
create sequence commentSeq;



-- 게시판 테이블 > 삭제 트리거 > 삭제할 행의 번호 > 댓글 삭제 실행
create or replace trigger trgDeleteBoard
    before
    delete
    on tblBoard
    for each row
begin
    
    delete from tblComment where bseq = :old.seq;
    
end;




select * from tblBoard; -- 게시판
select * from tblComment; -- 댓글


insert into tblBoard values(1,'게시판 테스트입니다.',default);
insert into tblBoard values(2,'안녕하세요~.',default);

insert into tblComment values (1,'댓글입니다',default,1);
insert into tblComment values (2,'댓글입니다',default,1);
insert into tblComment values (3,'댓글입니다',default,1);

insert into tblComment values (4,'네 안녕하세요.',default,2);
insert into tblComment values (5,'반갑습니다.~',default,2);


-- 첫번쨰 게시물 삭제하기
delete from tblComment where bseq = 1;
delete from tblBoard where seq = 1;

delete from tblBoard where seq = 2;




drop table tblMemo;

create table tblMemo
(
    seq number primary key,
    content varchar2(1000) not null,
    regdate date default sysdate not null,
    id varchar2(30) not null references tblUser(id)
);

create table tblUser
(
    id varchar2(30) primary key,
    name varchar2(30) not null,
    point number default 100 not null
);

insert into tblUser values('hong','홍길동',default);

select * from tblUser;

drop table tblUser;
insert into tblMemo values (1,'메모 테스트',default,'hong');
insert into tblMemo values (2,'메모 테스트',default,'hong');
delete from tblMemo where seq = 2;
insert into tblMemo values (3,'메모 테스트',default,'hong');
delete from tblMemo where seq  =3;
delete from tblMemo where seq  =4;
insert into tblMemo values (4,'메모 테스트',default,'hong');


rollback;
-- 트리거 만들기 : 메모 쓰기 (+10), 메모 삭제 (-5)
-- 1.insert 1개 , delete 1개
-- 2. insert or delete 

create or replace trigger trgUpdateMemo
    after
    insert 
    on tblMemo
    for each row
    
begin
    update tblUser set point = point+10 where id = :new.id;
end;

create or replace trigger trgDeleteMemo
    before
    delete 
    on tblMemo
    for each row
    
begin
    update tblUser set point = point-5  where id = :old.id;
end;











