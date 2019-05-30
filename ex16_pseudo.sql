--ex16_pseudo.sql
/*
의사 컬럼, Pseudo Column

rownum
- 진짜 컬럼이 아닌데 컬럼처럼 행동하는 요소
- 행번호 의사컬럼(현재 행의 순서를 반환하는 의사 컬럼)
- 오라클 전용
- 서브쿼리를 잘하면 사용하기 쉬움

*/
select * from tblinsa;

select name,buseo,jikwi,basicpay, rownum from tblinsa where rownum<=5;


select name,buseo,jikwi,basicpay, rownum --2
from tblinsa -- 1
order by basicpay desc;--3


-- **** rownum 은 항상 from 절이 실행될 때 새로** 만들어진다. **************
select name,buseo,jikwi,basicpay,rownum,rnum from
--select * from
(select name,buseo,jikwi,basicpay, rownum as rnum
from tblinsa 
order by basicpay desc);

--**** 사용법
select i.*,rownum 
from
(select * from tblinsa order by basicpay desc) i
where rownum<=5;


select name,buseo,jikwi,basicpay,rownum as rnum 
from tblinsa
--where rownum = 1 -- o
--where rownum <= 5; -- o
------------------------ rownum의 결과가 1이 포함되는 조건은 실행 가능
--where rownum = 3; --X
--where rownum>=10 and rownum<=20; --X
--where rownum>5; --X
--where rownum>=1 and rownum<=5; -- O
--where rownum=1 or rownum=2; -- O
----------------------- rownum 은 조건을 사용하려면 반드시 1부터 시작해서 연속적으로 가져와야 한다.
--where rownum=1 or rownum=3; -- X
where rownum=1 or rownum=2 or rownum=4;








-- web : 페이징(paging) 
-- 직원 60명

select name,basicpay,rownum 
    from tblInsa; --  원본


select name,basicpay,rownum 
    from tblInsa
        order by basicpay desc; -- 원하는 정렬 + 행번호(유효X)

select name,basicpay, rownum
from
(select name,basicpay
    from tblInsa
        order by basicpay desc);-- 원하는 정렬 > 다시 행번호 할당 (from 절)


select name,basicpay, rownum
from
(select name,basicpay
    from tblInsa
        order by basicpay desc)
                where rownum between 3 and 7; -- 원하는 정렬 + 행번호조건 > 실패



select  name,basicpay,rownum,rnum 
from
    (select name,basicpay, rownum as rnum
    from
    (select name,basicpay
        from tblInsa
            order by basicpay desc))
            --where rownum =3
            where  rnum between 3 and 7;


create view vwSubSet
as
select name,basicpay, rownum as rnum
    from
    (select name,basicpay
        from tblInsa
            order by basicpay desc);
      
select * from vwsubset;
            
select  name,basicpay,rownum,rnum 
from
    vwsubset
            where  rnum between 3 and 7;
            
            
            
            
-- 인구수가 가장 적은 나라 순서 대로 3개
select * from tblCountry;    
            

select * 
from
    (select a.*,rownum as "인구 적은 순서" from
    (select * from tblCountry 
    where population is not null
    order by population asc) a)
where "인구 적은 순서" between 5 and 10;
        
-- tblInsa. 부서별 인원수 Top 3

select 
b.*,
(select round(avg(basicpay)) from tblinsa where buseo = b.buseo) as 해당부서평균급여
from
    (select a.*,rownum as rank from
    (select buseo,count(*) as cnt from tblInsa 
        group by buseo 
        order by cnt desc) a) b
where rank<=3;


-- 세대별 그룹
select * from
(select 세대,명,rownum as 순위 from
(select floor(age/10) * 10 as 세대 ,count(*) as 명 from tblAddressBook
    group by floor(age/10) order by count(*) desc) a)
    where 순위 between 2 and 3;

        