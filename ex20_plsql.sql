-- ex20_plsql.sql
/*
PL/SQL
-- Procedural Language Extensions to SQL (+절차, 제어)
-- 표준 SQL : 비 절차성 언어 (명령어들간의 순서가 없다. 명령어들끼리 연속적이지 않다.)
-- 표준 SQL + 절차적 기능 추가 -> 오라클 추가 SQL -> PL/SQL
-- 추가된 부분 : 자바의 프로그래밍 기능 추가 (변수,제어문,메소드...)
-- 오라클 전용 SQL

- 표준 SQL <> PL/SQL : 표준 SQL 자료형의 거의 통일 시켰다.
- 표준 SQL : 문장 종결자 필수 X
- PL/SQL : 문장 종결자 필수 O


SQL 처리 과정 & 순서
1. 표준 SQL
    : 클라이언트 구문 작성 (SELECT 문) > 실행(CTRL + Enter) > 네트워크를 통해 SQL(문자열) 이 DBMS 서버에 전달 
        > DBMS 전달 받음 > 구문 분석 (파싱) > 컴파일 (인터프리팅) > 기계어(명령어) > 실제 실행 (CPU) > 결과처리 > 반환
    : 위에서 한번 실행했던 질의를 다시 실행 (똑같은 sql을 다시 실행) > 위의 과정을 처음부터 끝까지 완전히 동일하게 반복(****)

2. PL/SQL
    : 클라이언트 구문 작성 (SELECT 문) > 실행(CTRL + Enter) > 네트워크를 통해 SQL(문자열) 이 DBMS 서버에 전달 
        > DBMS 전달 받음 > 구문 분석 (파싱) > 컴파일 (인터프리팅) > 기계어(명령어) > 실제 실행 (CPU) > 결과처리 > 반환
    : 위에서 한번 실행했던 질의를 다시 실행 (똑같은 sql을 다시 실행) > 클라이언트 구문 작성 (SELECT 문) 
        > 실행(CTRL + Enter) > 네트워크를 통해 SQL(문자열) 이 DBMS 서버에 전달 
        > DBMS 전달 받음 > X > X > X > 위의 컴파일 결과를 로드 > 실제 실행 (CPU) > 결과처리 > 반환

프로시저, Procedure
- 함수, 메소드, 서브루틴 등...
- 특정 목적을 가지고 모인 순서대로 실행하는 명령어의 집합
1. 익명 프로시져 : 이름이 없음 > 재사용을 목적으로 하지 않는다. 동작방식 ( 표준 sql과 동일) > 확장 기능 때문에 사용
2. 실명 프로시져 : 이름이 있음 > 재사용을 목적으로 한다. > 동작방식 ( PL/SQL 동일. 재사용) > 비용 절감 + 확장 기능

*/

SELECT * FROM tblInsa;

set serveroutput on;
-- 프로시져 영역 ( 코드 블럭 ) 
begin -- {
    -- 각종 명령어 : 표준 SQL + PL/SQL
    dbms_output.put_line('Hello');
end; -- }



/*

PL/SQL 블럭 구조

1. 4개 키워드로 구성
a. [declare]
b. begin
c. [exception]
d. end;

2. declare
- 선언부, declare section
- 프로그램에서 사용되는 변수, 객체 등을 선언하는 영역
- 생략 가능

3. begin
- 실행부, 구현부, executable section
- begin ~ end
- 프로그램에서 실제 구현 내용들을 선언하는 영역
- 표준 SQL + PL/SQL( 연산,제어 등...)
- 생략 불가능

4. exception
- 예외 처리부, exception section
- catch 절 역할
- 예외처리 코드를 선언하는 영역
- 생략 가능

5. end;
- 블럭의 종료
- 생략 불가능

6. PL/SQL 블럭 = 선언부 + 실행부 + 예외처리부

오라클
begin
    begin
    
    end;
end;


declare
    변수, 자원 선언
begin
    구현부
exception
    예외처리부
end;

자료형 & 변수

자료형
- 표준 SQL 과 동일( 거의 유사+ 확장 ) 

변수 선언하기
- 변수명 자료형 [not null][default 값]
- 표준 sql에서 컬럼 정의하는 것과 유사
- 변수의 역할 : 질의의 결과(select 문)나 인자값을 저장하는 용도

연산자
- 표준 sql 동일

표준 sql 대입 연산자
    - 컬럼명 = 값; // update tblInsa set buseo = '영업부';
    - 용도 : 컬럼값 대입
    
PL/SQL 대입 연산자
    - 변수 := 값;
    - 용도 : 변수값 대입

*/

declare
    num number; -- number  :PL/SQL 자료형
    name varchar2(30); -- varchar2 : PL/SQL 자료형
    today date; -- date : PL/SQL 자료형
begin

    num := 10; -- 정수형 리터럴 ( 표준 sql 동일)
    dbms_output.put_line(num);

    name := '홍길동';
    DBMS_OUTPUT.PUT_LINE(name);
    
    today := sysdate;
    DBMS_OUTPUT.PUT_LINE(today);
    DBMS_OUTPUT.PUT_LINE(to_char(today,'yyyy-mm-dd'));
    
    today := '2018-09-04';
    DBMS_OUTPUT.PUT_LINE(today);
    
    -- ORA-06502: PL/SQL: numeric or value error: character string buffer too small
    name := '홍길동입니다안녕하세요';
    DBMS_OUTPUT.PUT_LINE(name);
    
end;



declare
    num1 number;
    -- num2 number not null; -- 사용 유무와 상관없이 end; 전까지 반드시 값을 가져야 한다.
    num3 number default 100;
    num4 number not null default 300;
    num5 number := 500; -- 비권장 ( 초기화는 BEGIN 블럭에서 주로 한다.)
    today date := sysdate; -- 비권장 ( 초기화는 BEGIN 블럭에서 주로 한다.)
begin
    -- 변수 초기화 X
    -- 바로 사용 : 초기화하지 않은 변수도 사용이 가능하다. ( null 값인채로 사용 가능) 
    DBMS_OUTPUT.PUT_LINE(num1); -- null 출력
 
    -- PLS-00218: a variable declared NOT NULL must have an initialization assignment
    --DBMS_OUTPUT.PUT_LINE(num2); 
    
    --num3 := 200;
    DBMS_OUTPUT.PUT_LINE(num3);
    --num4 := 400;
    DBMS_OUTPUT.PUT_LINE(num4); 
    DBMS_OUTPUT.PUT_LINE(num5); 
    
end;


/*
테이블에서 조회한 데이터를 변수에 담기
*/
declare
    vbuseo  varchar2(15);
begin
    -- vbuseo := (select buseo from tblinsa where name = '홍길동');
    
    -- select 의 결과 컬럼값을 변수에 대입 > into
    select buseo into vbuseo from tblinsa where name = '홍길동';
    DBMS_OUTPUT.PUT_LINE(vbuseo);
end;


desc tblInsa;

declare 
    cnt number;
begin
    select count(*) into cnt from tblAddressBook where address like '서울특별시%';
    DBMS_OUTPUT.put_line('서울특별시 인원수:'||to_char(cnt,'9,999')||'명');
end;



declare
    vbuseo  number;
begin
    -- vbuseo := (select buseo from tblinsa where name = '홍길동');
    
    -- select 의 결과 컬럼값을 변수에 대입 > into
    select buseo into vbuseo from tblinsa where name = '홍길동';
    DBMS_OUTPUT.PUT_LINE(vbuseo);
end;




declare 
    cnt varchar2(50); -- 형변환이 가능한 상황이면 암시적으로 해준다.
begin
    select count(*) into cnt from tblAddressBook where address like '서울특별시%';
    DBMS_OUTPUT.put_line('서울특별시 인원수:'||to_char(cnt,'9,999')||'명');
end;





declare
    vbuseo  varchar2(100); -- 길이가 더 큰건 상관없다. (overflow x)
begin
    -- vbuseo := (select buseo from tblinsa where name = '홍길동');
    
    -- select 의 결과 컬럼값을 변수에 대입 > into
    select buseo into vbuseo from tblinsa where name = '홍길동';
    DBMS_OUTPUT.PUT_LINE(vbuseo);
end;



declare
    vbuseo  varchar2(6); -- 결과값보다 크기가 작으면 에러 발생
begin
    -- vbuseo := (select buseo from tblinsa where name = '홍길동');
    -- select 의 결과 컬럼값을 변수에 대입 > into
    select buseo into vbuseo from tblinsa where name = '홍길동';
    DBMS_OUTPUT.PUT_LINE(vbuseo);
end;



declare
    vpop  number; -- 결과값보다 크기가 작으면 에러 발생
begin
    -- vbuseo := (select buseo from tblinsa where name = '홍길동');
    -- select 의 결과 컬럼값을 변수에 대입 > into
    select population into vpop from tblCountry where name = '대한민국';
    DBMS_OUTPUT.PUT_LINE(vpop);
end;




declare
    --vpop  number; -- 결과값보다 크기가 작으면 에러 발생
    --vpop  number not null;
    vpop number default 0;
begin
    -- vpop := null
    select 
     nvl(population,0) into vpop 
    from tblCountry where name = '케냐';
    DBMS_OUTPUT.PUT_LINE(vpop);
end;

-- 위의 쿼리
-- 질의의 결과가 단일값이어야 한다.
-- : 단일 컬럼 + 단일 행 
-- : PK 조건 + 단일 컬럼 : select 결과셋
-- : 집계함수의 결과셋



-- 반환되는 컬럼의 갯수를 여러개
-- : N 개의 반환값 > 

declare
    vbuseo varchar2(15);
    vjikwi varchar2(15);
    vbasicpay number(10);
    vtotal number(11);
    vcount number(2);
begin
    select 
        buseo,
        jikwi,
        basicpay,
        (basicpay+sudang),
        (select count(*) from tblinsa where buseo = i.buseo and jikwi <> '부장')
    into 
        vbuseo,
        vjikwi,
        vbasicpay,
        vtotal,
        vcount
    from tblinsa i where name = '홍길동';
    
    DBMS_OUTPUT.put_line('부서: '|| vbuseo ||', 직위:'||vjikwi || ', 급여:'||vbasicpay);
    DBMS_OUTPUT.PUT_LINE('총급여:'|| vtotal);
    DBMS_OUTPUT.PUT_LINE(vbuseo||'의 부하직원수:'|| vcount);
end;


desc tblInsa;


/*
참조형
- 원본(컬럼)의 자료형을 참조해서 변수의 자료형으로 사용할 수 있다.
- 원본(컬럼)의 자료형을 몰라도 된다.
- 유지보수 유리

1.%type
- 대상 컬럼의 자료형과 길이를 참조해서 해당 변수에 적용하겠습니다.
- 복사되는 항목
    a. 자료형
    b. 길이
    c. not null
    
2. %rowtype
- 테이블 레코드 구조를 참조해서 해당 변수에 적용하겠습니다.
- %type 의 집합

*/

declare
  vname tblInsa.name%type; -- vname varchar2(20) not null  
  vbuseo tblinsa.buseo%type;
  vbasicpay tblinsa.basicpay%type;
begin
select name,buseo,basicpay into vname,vbuseo, vbasicpay from tblinsa 
    where (basicpay+sudang) = (select min(basicpay+sudang) from tblinsa); -- 심심해
    DBMS_OUTPUT.put_line(vname||'-'||vbuseo||'-'||vbasicpay);
end;

declare 
    vfirst tblname.first%type;
    vlast tblname.last%type;
    vheight tblname.height%type;
    vweight tblname.weight%type;
begin
    select first,last,height into vfirst,vlast,vheight from tblname
        where height =(select max(height) from tblname);
    dbms_output.put_line('가장 키 큰 사람:'||vlast||vfirst||'-'||vheight);
    
    select first,last,height into vfirst,vlast,vheight from tblname
        where height =(select min(height) from tblname);
    dbms_output.put_line('가장 키 작은 사람:'||vlast||vfirst||'-'||vheight);
    
    select first,last,weight into vfirst,vlast,vweight from tblname
        where weight =(select max(weight) from tblname);
    dbms_output.put_line('가장 뚱뚱한 사람:'||vlast||vfirst||'-'||vweight);
    
    select first,last,weight into vfirst,vlast,vweight from tblname
        where weight =(select min(weight) from tblname);
    dbms_output.put_line('가장 마른 사람:'||vlast||vfirst||'-'||vweight);
    
end;



declare
begin
    -- 홍길동의 여자친구 > 바람 > 하하하
    --select * from tblMen;
    --select * from tblWomen;
    
    -- 1.
    select couple from tblMen where name = '홍길동';
    -- 2.
    update tblWomen set couple = '하하하' where name = '장도연';
    -- 3.
    update tblMen set couple = '장도연' where name = '하하하';
     --4.
    update tblMen set couple = null where name =oldMan;
    
    dbms_output.put_line('완료');
    
end;


commit; --업무끝
ROLLBACK; --예외처리

select * from tblWomen;
select * from tblMen;

--tblInsa. 직원 중 일부에게만 보너스 지급. 지급 내역을 별도로 저장
create table tblBonus
(
    seq number primary key, --일련 번호(PK)
    iseq number references tblInsa(num) not null, --직원 번호(FK)
    bonus number not null
);

create sequence bonusSeq;


declare
    vnum tblInsa.num%type;
    vsudang tblinsa.sudang%type;
begin

    --1.
    select num,sudang into vnum,vsudang from tblInsa 
        where city = '서울' and jikwi = '부장' and to_char(ibsadate,'yyyy') <= 1995;

    --dbms_output.put_line(vnum);
    --dbms_output.put_line(vsudang);

    --2.
    insert into tblBonus (seq,iseq,bonus) values (bonusSeq.nextval,vnum,vsudang * 3);
end;


select b.*,
    (select name from tblinsa where num = b.iseq), -- 김인수
    (select city from tblinsa where num = b.iseq),
    (select jikwi from tblinsa where num = b.iseq),
    (select to_char(ibsadate,'yyyy') from tblinsa where num = b.iseq),
    (select sudang from tblinsa where num = b.iseq)
from tblBonus b;


-- tblTodo. 가장 질질 끌던 완료못한 일을 목록에서 제거하기
select * from tblTodo;

-- 서브쿼리
-- rownum

select seq from 
(select seq from tblTodo where completedate is null order by adddate asc) a 
where rownum = 1;


select seq from tblTodo 
        where completedate is null 
            and adddate = (select min(adddate) from tblTodo where completedate is null);


declare
    vseq tblTodo.seq%type;
    
begin
    --1.
    select seq into vseq from 
    (select seq from tblTodo where completedate is null order by adddate asc) a 
    where rownum = 1;

    dbms_output.put_line(vseq);
    --2.
    delete from tblTodo where seq = vseq;
end;


select * from tblTodo;

-- PL/SQL 블럭 구조
-- 자료형 + 변수 생성
-- 변수의 자료형 > 테이블 + 컬럼 참조형
-- SELECT 결과 > 단일값 가져오기
-- SELECT 결과 > 단일레코드 + 다중 컬럼값 가져오기
-- 변수값을 SELECT, UPDATE, DELETE, INSERT 등에 사용하기


declare
    -- 자료형을 참조(good) + 컬럼 갯수가 많다. (bad)
--    vfirst tblname.first%type;
--    vlast tblname.last%type;
--    vgender tblname.gender%type;
--    vheight tblname.height%type;
--    vweight tblname.weight%type;
--    vnick tblname.nick%type;
      vrow tblname%rowtype; -- 컬럼의 집합
begin
--    select first,last,gender,height,weight,nick into
--            vfirst,vlast,vgender,vheight,vweight,vnick 
--            from tblname where last = '유' and first = '재석';
--    select * into
--            vfirst,vlast,vgender,vheight,vweight,vnick 
--            from tblname where last = '유' and first = '재석';
    select * into
            vrow 
            from tblname where last = '유' and first = '재석';

--    dbms_output.put_line(vfirst);
--    dbms_output.put_line(vlast);
--    dbms_output.put_line(vgender);
--    dbms_output.put_line(vheight);
--    dbms_output.put_line(vweight);
--    dbms_output.put_line(vnick);

    --dbms_output.put_line(vrow);
    dbms_output.put_line(vrow.first);
    dbms_output.put_line(vrow.last);
    dbms_output.put_line(vrow.gender);
    dbms_output.put_line(vrow.height);
    dbms_output.put_line(vrow.weight);
    dbms_output.put_line(vrow.nick);
end;



declare
    vrow tblInsa%rowtype;--10개의 컬럼을 가진 레코드 구조 변수(부분 컬럼 선택 불가능)
    vnum tblInsa.num%type; -- 컬럼 변수
begin
    vnum :=1010;
    
    --select 10개 컬럼 into 10개 변수 from tblInsa where num = vnum;
    --select * into vrow from tblInsa where num =vnum;
    select name,buseo,city into vrow from tblInsa where num =vnum;
    
    dbms_output.put_line(vrow.name);
    dbms_output.put_line(vrow.buseo);
    dbms_output.put_line(vrow.city);
end;


commit;
rollback;
-- tblMen -> 1명(무명씨) -> tblWomen : 옮기기
select * from tblMen;
select * from tblWomen;

declare
    vrow tblMen%rowtype;
begin
    
    -- 1.'무명씨'의 모든 정보 가져오기 (select)
    select * into vrow from tblMen where name = '무명씨';
    
    --dbms_output.put_line(vrow.name);
    -- 2. 1번의 모든 정보를 tblWomen 에 추가하기 (insert)
    insert into tblWomen(name,age,height,weight,couple)
        values (vrow.name,vrow.height,vrow.weight,vrow.couple);
    
    -- 3. tblMen 에서 '무명씨' 정보 삭제하기(delete)
    delete from tblMen where name = '무명씨';
    
end;


commit;
rollback;




/*
PL/SQL 상수
- 리터럴
- 자바 : public static final double PI = 3.14;
- 변수명 자료형 [not null][default]
- 상수명 constant 자료형 [not null][default]
*/

declare
    num1 number := 100;
    NUM2 constant number := 200; -- ***
    --NUM3 constant number; -- PLS-00322: declaration of a constant 'NUM3' must contain an initialization assignment
    NUM4 constant number default 400; -- default 값을 상수의 초기값으로 사용
    --NUM5 constant number not null; -- ?
begin
    --NUM3 := 300;
    dbms_output.put_line(num1);
    dbms_output.put_line(NUM2);
    --dbms_output.put_line(NUM3);
    dbms_output.put_line(NUM4);
    
    num1 := num1 * 2;
   -- NUM2 := NUM2 * 2; -- PLS-00363: expression 'NUM2' cannot be used as an assignment target
    
    dbms_output.put_line(num1);
    dbms_output.put_line(NUM2);

end;


-- 제어문
-- 조건문 : if 문

set serveroutput on;

declare
    vnum number;
begin
    vnum := -10;
    
    if vnum > 0 then -- {
        dbms_output.put_line('양수');
    end if; -- }
    
    if vnum > 0 then 
        dbms_output.put_line('양수');
    else
        dbms_output.put_line('양수아님');
    end if;

    if vnum > 0 then
        dbms_output.put_line('양수');
    elsif vnum < 0 then
        dbms_output.put_line('음수');
    else
        dbms_output.put_line('zero');
    end if;
    
end;


-- 커플 선택 -> 둘의 나이가 가장 많은 커플 -> 남자 연상? 여자 연상?
select * from tblMen;
select * from tblWomen;

-- 둘의 나이가 가장 많은 커플
select 
    case 
        when m.age - w.age>0 then '남자 연상'
        when w.age - m.age>0 then '여자 연상'
    else '동갑'
    end as result
from tblMen m
    inner join tblWomen w
        on m.name = w.couple
            where (m.age + w.age) = (select max(m.age + w.age) from tblMen m
                                                             inner join tblWomen w
                                                                on m.name = w.couple);
                                                                
                                                                



declare
    mage number;
    wage tblWomen.age%type;
begin
    
    select 
        m.age,w.age into mage,wage
    from tblMen m
        inner join tblWomen w
            on m.name = w.couple
                where (m.age + w.age) = (select min(m.age + w.age) from tblMen m
                                                                 inner join tblWomen w
                                                                    on m.name = w.couple);
    
    if mage> wage then 
        dbms_output.put_line('남자가 연상입니다.');
    elsif wage > mage then
        dbms_output.put_line('여자가 연상입니다.');
    else
        dbms_output.put_line('동갑내기 입니다.');
    
    end if;

end;


-- 현재 시각이 홀수 초이면 유재석의 몸무게 +1kg 증가, 짝수 초이면 김숙의 몸무게를 +1kg 증가

begin

    if mod(to_char(sysdate,'ss'),2) = 0 then
         dbms_output.put_line('짝수');
         update tblWomen set weight = weight + 1 where name = '박나래';
    else
         dbms_output.put_line('홀수');
         update tblMen set weight = weight + 1 where name = '홍길동';
    end if;

end;


select * from tblMen;
select * from tblWomen;


select * from tblBonus;

-- 직원 번호 -> 부장,과장(수당 3배), 대리,사원(수당 2배)

declare
    vnum tblinsa.num%type;
    vjikwi tblinsa.jikwi%type;
    vsudang tblinsa.sudang%type;
begin
    vnum := 1055;
    
    -- 1.
    select jikwi,sudang into vjikwi,vsudang from tblinsa where num = vnum;
    dbms_output.put_line(vjikwi);
    
    -- 2.
    if vjikwi in ('부장','과장') then 
        dbms_output.put_line('수당 3배 지급');
        --insert into tblBonus (seq,iseq,bonus,sudang) values (bonusSeq,nextval,vnum,vsudang*3);
        vsudang := vsudang * 3;
    else
        dbms_output.put_line('수당 2배 지급');
        --insert into tblBonus (seq,iseq,bonus,sudang) values (bonusSeq,nextval,vnum,vsudang*2);
        vsudang := vsudang * 2;
    end if;

    insert into tblBonus (seq,iseq,bonus) values (bonusSeq.nextval,vnum,vsudang);
    
end;

select * from tblBonus;


-- case 문
-- 자바 : switch case 문
-- 표준 SQL 의 case와 같음

declare
    vcontinent tblcountry.continent%type;
    vresult varchar2(30);
begin

    -- 대한민국이 어느 대륙에 속하는지?
    select continent into vcontinent from tblCountry where name = '대한민국';
    
    if vcontinent = 'AS' then
        vresult := '아시아';
    elsif vcontinent = 'EU' then
        vresult := '유럽';
    elsif vcontinent = 'AF' then
        vresult := '아프리카';
    end if;
    
    dbms_output.put_line(vresult);
    
    case 
        when vcontinent = 'AS' then vresult := '아시아';
        when vcontinent = 'EU' then vresult := '유럽';
        when vcontinent = 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;

    dbms_output.put_line(vresult);

end;




/*
반복문

1. loop
- 조건 반복

2. for loop
- 지정 횟수 반복 (자바 for 문 유사)

3. while loop
- 조건 반복(자바 while문 유사)

*/

-- loop

-- 무한 루프 & 다른 루프의 기본 골격

begin

    loop
        dbms_output.put_line('현재 시간:'||sysdate);
        --exit;
        --exit when 조건;
        exit when to_char(sysdate,'ss')>30;
    end loop;

end;

-- 사원 번호 1001 ~ 1060 : 10 만원 지급
select * from tblBonus;




declare
    vloop number;
begin

    vloop := 1003;

    loop
    
        insert into tblBonus (seq,iseq,bonus) values (bonusSeq.nextval,vloop,100000);
        vloop := vloop + 1;
        exit when vloop > 1060;
        
    end loop;
    
end;


select * from tblInsa;


drop table tblinsa;



-- 2. for loop
-- : 정식으로 루프 변수를 제공한다.

begin
    -- 루프변수를 따로 선언하지 않는다.
    -- i: 루프변수
    -- 변수 in 집합
    -- 1  : 초깃값
    -- .. : 순차 증가
    -- 10 : 최댓값
    -- reverse : 역순 키워드
    for i in reverse 1..10 loop
        dbms_output.put_line(i);
    end loop;

end;


begin
    for i in 5.1..5.9 loop
        dbms_output.put_line(i);
    end loop;
end;


-- 3. while loop
declare
    vloop number;
begin
    vloop := 1;
    
    while vloop <=10 loop
    
        dbms_output.put_line(vloop);
        vloop := vloop+1;
    end loop;
end


-- 구구단 테이블
create table tblGugudan
(
    --seq number primary key
    dan number not null,-- primary key, -- 2,2...
    num number not null,-- primary key, -- 1,2...
    result number not null, -- 2,4...
    
    -- 복합키
    -- : 2개이상의 컬럼이 모여서 기본키 역할
    -- : 컬럼 수준으로 선언이 불가능, 테이블 수준으로 선언 가능
    constraint tblgugudan_dan_num_pk primary key(dan,num)
);

insert into tblGugudan values (1,1,1);
insert into tblGugudan values (1,2,1);
insert into tblGugudan values (2,1,1);
insert into tblGugudan values (2,1,3);


rollback;

select * from tblGugudan;



-- for loop 
-- while loop
begin 
    for dan in 2..9 loop
        for num in 1..9 loop
            insert into tblGugudan values (dan,num, dan * num);
        end loop;
    end loop;
end;

begin
    for dan in 2..9 loop
        for num in 1..9 loop
            insert into tblGugudan values (dan,num,dan*num);
        end loop;
    end loop;
end;



truncate table tblGugudan; -- commit 포함

declare 
    vdan number;
    vnum number;
begin

    vdan := 2;
    
    while vdan <= 19 loop
        
        vnum := 1;
        
        while vnum <=19 loop
            insert into tblGugudan values (vdan,vnum, vdan * vnum);
            vnum := vnum + 1;
        end loop;
        
        vdan := vdan + 1;
    end loop;

end;


select * from tblGugudan;


/*
select 문을 통해서 가져온 데이터를 PL/SQL 변수에 넣는 방법

1. select into 사용
    - 결과셋의 레코드 1개일때만 가능하다.
2. 커서(cursor) 사용
    - 결과셋의 레코드가 1개 이상일 때 가능하다.
    
커서 구문

declare
    변수선언;
    커서선언;
begin
    커서열기;
    loop
        커서를 사용해서 데이터 접근;
    end loop;
    커서닫기;
end;
*/

-- select 데이터 가져오기
-- 1. select into
--  a. 단일컬럼 + 단일행
--  b. 다중컬럼 + 단일행

-- 2. cursor
--  a. 단일컬럼 + 다중행
--  b. 다중컬럼 + 다중행



-- tblinsa. 직원명 x 60개
declare
    vname tblinsa.name%type; -- 한명한명의 이름을 저장할 변수
    cursor vcursor
    is 
    select name from tblInsa order by name asc; -- 아직 select 문 실행 전 (선언 O, 실행x)
begin

    open vcursor; -- 커서 열기 (select 문 실행)
        loop
            
            -- 순차적으로 레코드 하나하나를 커서를 사용해서 접근
            fetch vcursor into vname;
            
            -- 커서 내장 속성
            exit when vcursor%notfound; -- 다음 레코드가 존재하면 false 존재하지 않으면 true
            
            dbms_output.put_line(vname);            
    
    
        end loop;
    
    close vcursor; -- 커서 닫기

end;


select * from tblBonus;

truncate table tblBonus;

delete from tblinsa where city = '서울';





declare
    vnum tblinsa.num%type;
    cursor vcursor
    is
    select num from tblinsa;
begin

    open vcursor;
        loop
            fetch vcursor into vnum;
            exit when vcursor%notfound;
            insert into tblBonus values (bonusSeq.nextval,vnum,200000);
        end loop;
    close vcursor;
end;


select * from tblBonus;


rollback;
select * from tblInsa;

-- 다중 컬럼 + 다중 레코드
declare
    vname tblinsa.name%type;
    vbuseo tblinsa.buseo%type;
    vjikwi tblinsa.jikwi%type;
    cursor vcursor is
        select name, buseo, jikwi from tblinsa;
begin
    open vcursor;
    loop
        fetch vcursor into vname, vbuseo, vjikwi;
        exit when vcursor%notfound;
        
        -- 업무
        dbms_output.put_line(vname || ',' || vbuseo || ',' || vjikwi);
        
    end loop;
    close vcursor;
end;



declare
    vrow tblinsa%rowtype;
    cursor vcursor is
        select * from tblinsa;
begin
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        -- 업무
        dbms_output.put_line(vrow.name || ',' || vrow.buseo || ',' || vrow.city);
        
    end loop;
    close vcursor;
end;


/*
cursor 사용법 (FM)
- 커서  + loop
: 커서 객체 생성 (select 문) > 커서열기(select 실행) > 루프 > 데이터 접근(fetch) +사용(변수) > 커서 닫기

cursor 사용법 (편함)
- 커서 + for loop
:커서 처리가 단순해짐

*/


declare 
    --vrow : 생성 안함 > 루프 변수가 대신함
    cursor vcursor is
        select * from tblinsa;
begin
    --open vcursor; : 생략
    for vrow in vcursor loop  -- loop + fetch into
        dbms_output.put_line(vrow.name);
    end loop;
    --close vcursor; : 생략
end;


-- 커서 ≒ 뷰(실명부, 인라인뷰)
begin
    for vrow in (select * from tblinsa) loop
        dbms_output.put_line(vrow.name||' - '||vrow.ssn);
    end loop;
end;

-- PLS-00456: item 'VWINSA' is not a cursor
begin
    for vrow in vwinsa loop
        dbms_output.put_line(vrow.name||' - '||vrow.ssn);
    end loop;
end;



select * from vwinsa;


/*
exception
- 예외처리부
*/
declare
    vname number;
begin
    dbms_output.put_line('시작');
    select name into vname from tblinsa where num = 1001;
    dbms_output.put_line('끝');
    
exception
    when others then -- catch(Exception e)
        dbms_output.put_line('예외 처리');
end;


-- 예외 발생 기록(로그 테이블)
create table tblLog
(
    seq number primary key, -- PK
    code varchar2(20) check (code in('AAA0001','BBB001','CCC001')) not null, -- 예외 업무 식별자
    message varchar2(1000) null, -- 상태메세지
    regdate date default sysdate not null -- 발생시각
);

create sequence logSeq;


delete from tblName;
rollback;

declare
    vnum number;
    vname tblinsa.name%type;
begin
    --1.
    select 1000000/count(*) into vnum from tblName;
    dbms_output.put_line(vnum);
    
    --2.
    select name into vname from tblInsa;-- where num = 1001;
    dbms_output.put_line(vname);
    
exception
    when zero_divide then 
        dbms_output.put_line('tblName 테이블에 데이터가 없습니다.');
        insert into tblLog values (LOGSEQ.nextval,'AAA0001','김대리 담당',default);
    
    when too_many_rows then 
        dbms_output.put_line('가져온 직원이 너무 많습니다.');
        insert into tblLog values (LOGSEQ.nextval,'BBB001',NULL,default);

    when others then 
        dbms_output.put_line('오류 발생');
        insert into tblLog values (LOGSEQ.nextval,'CCC001',NULL,default);

end;

select * from tblLog;

-- PL/SQL 내의 트랜잭션 처리
-- : 일반적으로 PL/SQL은 블럭 자체가 하나의 트랜잭션 단위
-- : 일반적으로 실명 PL/SQL 블럭 생성 시 주로 트랜잭션 처리가 들어간다.

select  * from tblMen; -- 홍길동 : 장도연
select * from tblWomen; -- 장도연 : 홍길동

commit;
rollback;

begin
    --1.
    update tblMen set couple = null where name = '홍길동'; -- 성공
    --2.
    update tblWomen set couple = '가가가가가가가가가가가' where name = '장도연'; -- 실패
    
    commit;
exception
    when other then
            rollback;
end;



/*
PL/SQL 블럭 > 이름 붙이기 > 블럭이 오라클 서버에 저장(객체) > 저장 블럭 > 저장 프로그램 > Stored Procedure

저장 프로시저
- 이름을 붙인 PL/SQL 블럭
- 팀원 중 1명이 저장 프로시저 생성 > 오라클 서버 저장 > 나머지 팀원도 재사용 가능 ( 접근권한이 있을 경우 )
- 성능 향상(구문 분석 ~ 컴파일 과정 생략)
- 네트워크 트래픽 감소 (코드 전체 전송 -> 프로그램 이름만 전송)
- 여러 계정이 동일한 코드를 사용 가능 + 권한 부여 제어

저장 프로그램 종류
1. 저장 프로시저. Stored Procedure
    - 모든 SQL 사용 용도
    - 매개변수 선택
    - 반환값 선택
    - 자바 : 메소드
    - 표준 SQL에서 사용이 불가능하다.
    
2. 저장 함수. Stored Function
    - 주로 SELECT 용도
    - 반드시 매개변수를 가진다.
    - 반드시 반환값을 가진다.(반환값이 단일값) : 자바 메소드 return문
    - 표준 SQL 에서 사용이 가능하다. (***)


저장 프로시저 구문

create [or replace] procedure 프로시저명
is[as]
    [선언부;]
begin
    실행부;
[exception
    예외처리부;]
end [프로시저명];

*/

-- 프로시저 생성
create or replace procedure procTest
is -- 익명 블럭의 declare 역할
    vnum number;
begin
    vnum := 100;
    dbms_output.put_line(vnum);
end procTest;

-- 프로시저 호출
-- 1. PL/SQL 블럭 내에서 호출 (******)
-- 프로그래밍 방식
-- 익명 블럭 or 다른 프로시저 호출
-- 주로 사용되는 방식

-- 2. 스크립트 환경에서 호출 (ANSI-SQL 환경)
-- 관리자, 담당자
-- execute, call 명령어 사용

-- 2번환경 (ANSI SQL)

begin -- 1번환경
    --procTest;
    procTest();
end;

create or replace procedure procHello
is
begin
    procTest;
end;



begin
    procHello;
end;

----------------------------------------------------

exec procTest;
execute procTest;
call procTest();


-- 매개변수가 있는 프로시저
create or replace procedure procTest(pnum number)
is 
    vresult number;
begin
    vresult := pnum * 2;
    dbms_output.put_line(vresult);
end;


begin
    procTest(100);
end;








create or replace procedure procTest
(
    pwidth number,
    pheight number
)
is 
    vresult number;
begin
    vresult := pwidth * pheight;
    dbms_output.put_line(vresult);
end;


begin
    procTest('사각형A',100,200);
end;






create or replace procedure procTest
(   pname varchar2, -- 매개변수는 길이 명시 X
    pwidth number,
    pheight number
)
is 
    vresult number;
begin
    vresult := pwidth * pheight;
    dbms_output.put_line(pname||'-'||vresult);
end;







create or replace procedure procTest
(   pname varchar2, 
    pwidth number default 10,
    pheight number default 20
)
is 
    vresult number;
begin
    vresult := pwidth * pheight;
    dbms_output.put_line(pname||'-'||vresult);
end;

begin
    procTest('사각형A',100,200);
    procTest('사각형A',100);
    procTest('사각형A');
    --procTest('사각형A',null,100); -- 실패 null
    --procTest('사각형A',default,100); -- 실패
end;



/*
매개변수의 작동(동작) 모드
- 매개변수를 전달하는 방법

1. in 모드 : 기본
2. out 모드 
3. in out 모드 : 사용 x

*/

create or replace procedure procSum
(
    pnum1 in number, -- in 파라미터
    pnum2 in number
)
is
    vresult number;
begin
    vresult := pnum1 + pnum2;
    dbms_output.put_line(vresult);
end;



create or replace procedure procSum
(
    pnum1 in number, -- in 파라미터
    pnum2 in number,
    presult out number, -- out 파라미터, 반환값 역할
    presult2 out number, -- out 파라미터
    presult3 out varchar2
)
is
begin
    presult := pnum1 + pnum2;
    presult2 := pnum1 - pnum2;
    if pnum1 > pnum2 then
        presult3 := '크다';
    else
        presult3 := '작다';
    end if;
    
end;





declare
    vresult number;
    vresult2 number;
    vresult3 varchar2(20);
begin
    --변수 = procSum(10,20); // 이 방법 사용불가 (평범한 메소드의 반환값과는 다르다.)
    procSum(10,20,vresult,vresult2,vresult3);
    dbms_output.put_line(vresult);
    dbms_output.put_line(vresult2);
    dbms_output.put_line(vresult3);
end;



-- 검색, 추가, 삭제 등...

-- 직원 퇴사하기
-- 1. 직원 번호 > 퇴사
-- 2. 직원명(유일) > 퇴사
create or replace procedure procDelInsa
(
    pnum in number                           
)
is 
begin
    delete from tblInsa where num = pnum;
    insert into tblLog(seq, code, message, regdate) values (logSeq.nextval,'AAA0001','홍길동 퇴사',default);
    commit;
exception
    when others then
        rollback;
end;


begin
    procDelInsa(1001);
end;

select * from tblinsa;

rollback;


-- 할 일 추가하기 프로시저
select * from tbltodo;

create or replace procedure procAddTodo
(
    ptitle varchar2
)
is
    vseq number;
begin
    --1.
    select max(seq)+1 into vseq from tbltodo;
    
    --2. 
    insert into tblTodo (seq,title,adddate,completedate)
        values (vseq, ptitle, sysdate, null);
end;

begin
    procAddTodo('오라클 프로시져 정리하기');
end;

select * from tblTodo;


select * from tblname;

create or replace procedure procAddName
(
    pname varchar2,
    pgender varchar2,
    pheight number,
    pweight number,
    pnick varchar2
)
is 
begin
    insert into tblName (first,last,gender,height,weight,nick)
        values (substr(pname,2),substr(pname,1,1),pgender,pheight,pweight,pnick);
end;

begin
    procAddName('이광수','m',190,70,'기린');
end;


select * from tblName;

rollback;












