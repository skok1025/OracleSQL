--homework_06_112

--1. tblStaff, tblProject. 현재 재직중인 모든 직원의 이름, 주소, 월급, 담당프로젝트명을 가져오시오.
select * from tblStaff;
select * from tblProject;

select s.name,s.address,s.salary,p.projectname 
    from tblStaff s left outer join tblProject p on s.seq = p.staffseq;

--2. tblVideo, tblRent, tblMember. '뽀뽀할까요' 라는 비디오를 빌려간 회원의 이름은?
select * from tblVideo;
select * from tblRent;
select * from tblMember;

select m.name from tblMember m 
    inner join tblRent r on m.seq = r.member
        inner join tblVideo v on v.seq = r.video
            where v.name = '뽀뽀할까요';
        
--3. tblStaff, tblProejct. '노조협상'을 담당한 직원의 월급은 얼마인가?
select * from tblStaff;
select * from tblProject;

select s.name from tblStaff s inner join tblProject p on s.seq = p.staffseq
    where p.projectname='노조 협상';

--4. tblVideo, tblRent, tblMember. '털미네이터' 비디오를 한번이라도 빌려갔던 회원들의 이름은?
select * from tblVideo;
select * from tblRent;
select * from tblMember;

select m.name from tblMember m left outer join tblRent r on m.seq = r.member
    left join tblVideo v on r.video = v.seq
        where v.name = '털미네이터';
--5. tblStaff, tblProject. 서울시에 사는 직원을 제외한 나머지 직원들의 이름, 월급, 담당프로젝트명을 가져오시오.
select * from tblStaff;
select * from tblProject;

select s.name,s.salary,p.projectname from tblStaff s left outer join tblProject p on s.seq=p.staffseq
    where s.address<>'서울시';

--6. tblCustomer, tblSales. 상품을 2개(단일상품) 이상 구매한 회원의 연락처, 이름, 구매상품명, 수량을 가져오시오.
select * from tblCustomer;
select * from tblSales;

select c.name,c.tel,s.item,s.qty from tblCustomer c inner join tblSales s on c.seq = s.customer
    where s.qty >=2;
--7. tblVideo, tblRent, tblGenre. 모든 비디오 제목, 보유수량, 대여가격을 가져오시오.
select * from tblVideo;
select * from tblRent;
select * from tblGenre;
select distinct v.name,v.qty,g.price from tblVideo v left outer join tblRent r on v.seq=r.video 
    left outer join tblGenre g on g.seq = v.genre;


--8. tblVideo, tblRent, tblMember, tblGenre. 2007년 2월에 대여된 구매내역을 가져오시오. 회원명, 비디오명, 언제, 대여가격
select m.name, v.name, r.rentdate, g.price from tblMember m inner join tblRent r on m.seq = r.member
    inner join tblVideo v on r.video = v.seq 
        inner join tblGenre g on g.seq = v.genre
            where r.rentdate >'2007-02-01' and r.rentdate < '2007-03-01' ;

--9. tblVideo, tblRent, tblMember. 현재 반납을 안한 회원명과 비디오명, 대여날짜를 가져오시오.
select m.name,v.name,to_char(r.rentdate,'yyyy-mm-dd') from tblVideo v left outer join tblRent r on v.seq=r.video
    left outer join tblMember m on r.member = m.seq
        where rentdate is not null and retdate is null;  
--10. tblInsa. 남자 직원 중에서 급여를 3번째로 많이 받는 직원과 9번째로 많이 받는 직원의 급여 차액은 얼마?
select distinct (select 급여 
    from (select i2.*,rownum as num from (select basicpay+sudang as 급여 from tblInsa i order by 급여 desc) i2 ) i3 where num=3) 
    - (select 급여 
    from (select i2.*,rownum as num from (select basicpay+sudang as 급여 from tblInsa i order by 급여 desc) i2 ) i3 where num=9) as 급여차 from tblInsa;


select 급여 
    from (select i2.*,rownum as num from (select basicpay+sudang as 급여 from tblInsa i order by 급여 desc) i2 ) i3 where num=3;

--11. employees, departments. 사원들의 이름, 부서번호, 부서명을 가져오시오.
select * from employees;
select * from departments;

select e.last_name||e.first_name as 이름 , e.department_id as 부서번호, d.department_name as 부서명 from employees e inner join departments d on e.department_id=d.department_id;

--12. employees, jobs. 사원들의 정보와 직위명을 가져오시오.
select * from employees;
select * from jobs;

select e.* ,j.job_title from employees e inner join jobs j on j.job_id =e.job_id;

--13. employees, jobs. 직무(job_id)별 최고급여(max_salary) 받는 사원 정보를 가져오시오.
select * from employees;
select * from jobs;

select e.* from employees e inner join jobs j on e.job_id=j.job_id
    where e.salary = j.max_salary;

--14. departments, locations. 모든 부서와 각 부서가 위치하고 있는 도시의 이름을 가져오시오.
select * from departments;
select * from locations;

select d.department_name,l.city from departments d inner join locations l on d.location_id=l.location_id;

--15. locations, countries. location_id 가 2900인 도시가 속한 국가 이름을 가져오시오.
select * from locations;
select * from countries;

select c.country_name from locations l inner join countries c on l.country_id = c.country_id
    where l.location_id=2900;

--16. employees. 급여를 12000 이상 받는 사원과 같은 부서에서 근무하는 사원들의 이름, 급여, 부서번호를 가져오시오.
select last_name||first_name as name,salary,department_id from
employees where department_id in (select department_id from employees where salary >=12000 group by department_id);

--17. employees, departments. locations.  'Seattle'에서(LOC) 근무하는 사원의 이름, 직위, 부서번호, 부서이름을 가져오시오.
select * from departments;
select * from locations;
select * from employees;

select e.last_name||e.first_name as name , e.job_id,e.department_id,d.department_name from employees e inner join departments d on e.department_id = d.department_id
    inner join locations l on d.location_id = l.location_id
        where l.city='Seattle';

--18. employees, departments. first_name이 'Jonathon'인 직원과 같은 부서에 근무하는 직원들 정보를 가져오시오.
select * from departments;
select * from locations;
select * from employees;

select * from employees where job_id
in (select job_id from departments d inner join locations l on d.location_id = l.location_id 
    inner join employees e on e.department_id = d.department_id
        where e.first_name='Jonathon');
    

--19. employees, departments. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 출력하는데 월급이 3000이상인 사원을 가져오시오.
select e.last_name||e.first_name as name, d.department_name,e.salary from employees e inner join departments d on e.department_id = d.department_id
    where e.salary >=3000;


--20. employees, departments. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름, 월급, 급여등급을 가져오시오.
select e.department_id,d.department_name,e.last_name||e.first_name as name from employees e inner join departments d on e.department_id = d.department_id 
    where e.department_id=10;


--21. employees, departments. 모든 부서의 정보를 가져오되 부서장이 있는 부서는 부서장의 정보도 같이 가져오시오. ****
select * from employees;
select * from departments;

select e.* from employees e inner join departments d on e.department_id = d.department_id
    where d.manager_id=e.employee_id;


--22. departments, job_history. 퇴사한 사원의 입사일, 퇴사일, 근무했던 부서 이름을 가져오시오.
select * from job_history;
select * from departments;

select to_char(h.start_date,'yyyy-mm-dd') as 입사일,
        to_char(h.end_date,'yyyy-mm-dd') as 퇴사일,
        d.department_name
    from job_history h inner join departments d on h.department_id = d.department_id;


--23. employees. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호', '사원이름', '관리자번호', '관리자이름'으로 하여 가져오시오.

select e2.employee_id as 사원번호, e2.last_name||e2.first_name as 사원이름, e2.manager_id as 관리자번호, e1.last_name||e1.first_name as 관리자이름
    from employees e1/*매니저테이블*/ inner join employees e2/*사원*/ on e1.employee_id = e2.manager_id;



--24. employees, jobs. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 가져오시오. 년도를 기준으로 오름차순 정렬.
select * from employees;
select * from jobs;


select to_char(hire_date,'yy-mm-dd') as 입사년도,avg(salary) as 평균급여 from
(select * from employees e inner join jobs j on e.job_id = j.job_id where j.job_title='Sales Manager') group by hire_date order by hire_date asc;


--25. employees, departments. locations. 각 도시(city)에 있는 모든 부서 사원들의 평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 사원수를 가져오시오. 
--단, 도시에 근 무하는 사원이 10명 이상인 곳은 제외하고 가져오시오.

select * from employees;
select * from departments;
select * from locations;

select * 
    from (select city,round(avg(salary)) as 평균급여,count(*) as cnt 
        from (select l.city,e.salary from employees e inner join departments d on e.department_id = d.department_id inner join locations l on d.location_id = l.location_id) t group by city)
            where cnt <10 order by 평균급여 asc;


select city,round(avg(salary)),count(*) as cnt 
    from (select l.city,e.salary from employees e inner join departments d on e.department_id = d.department_id inner join locations l on d.location_id = l.location_id) t group by city;
select l.city,e.salary from employees e inner join departments d on e.department_id = d.department_id inner join locations l on d.location_id = l.location_id;



--26. employees, jobs, job_history. ‘Public  Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 가져오시오. 
--현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 말것.
select * from employees;
select * from jobs;
select * from job_history;

select e.employee_id,e.last_name||e.first_name as name  from employees e inner join job_history h on e.employee_id=h.employee_id inner join jobs j on h.job_id = j.job_id
    where j.job_title = 'Public Accountant';


--27. employees, departments, locations. 커미션을 받는 모든 사람들의 first_name, last_name, 부서명, 지역 id, 도시명을 가져오시오.
select * from employees;
select * from departments;
select * from locations;

select e.first_name,e.last_name,d.department_name,l.country_id, l.city from employees e inner join departments d on e.department_id = d.department_id inner join locations l on d.location_id = l.location_id
    where e.commission_pct is not null;


--28. employees. 자신의 매니저보도 먼저 고용된 사원들의 first_name, last_name, 고용일을 가져오시오.
select * from employees;

--select * from employees e1 inner join employees e2/*매니저정보*/ on e1.employee_id =e2.manager_id;
select 직원성,직원이름,to_char(직원고용일,'yy-mm-dd') from
(select e2.first_name as 직원성,e2.last_name as 직원이름,e2.hire_date as 직원고용일 ,e1.first_name,e1.last_name,e1.hire_date as 매니저고용일 
    from employees e1 /*매니저정보*/ inner join employees e2 on e1.employee_id =e2.manager_id) t where 직원고용일 < 매니저고용일;
        

--29. employees. 매내저로 근무하는 사원이 총 몇명인가?
select count(*) from
    employees where employee_id in (select manager_id from employees  group by manager_id) ;


--30. employees. 자신의 매니저보다 연봉(salary)를 많이 받는 사원들의 성(last_name)과 연봉(salary)를 가져오시오.
select 직원명,직원연봉 from 
    (select e1.last_name as 직원명,e1.salary as 직원연봉,e2.salary as 매니저연봉 
        from employees e1 inner join employees e2/*매니저*/ on e2.employee_id = e1.manager_id) 
            where 직원연봉>매니저연봉;


--31. employees. 총 사원 수 및  2003, 2004, 2005, 2006 년도 별 고용된 사원들의 총 수를 가져오시오. ***
select * from employees order by hire_date asc;
select (select count(*) from employees) as 전체사원수,
    ()
    
    from employees ;
select (select count(*) from employees) as 전체사원수,to_char(hire_date,'yyyy') as 입사년도,count(*) as 사원수 from employees where to_char(hire_date,'yyyy') between 2003 and 2006 group by to_char(hire_date,'yyyy');




--32. employees, departments. 2007년에 입사(hire_date)한 사원들의 사번(employee_id), 이름(first_name), 성(last_name), 부서명(department_name)을 가져오시오. 
--단, 부서에 배치되지 않은 사원은 'Not Assigned'로 가져오시오. ***

select * from employees where to_char(hire_date,'yyyy') =2007;
select * from employees;
select * from departments;
select e.employee_id, e.first_name, e.last_name,d.department_id
--    case
--        when e.department_id is null then 'Not Assigned'
--        when e.department_id is not null then d.department_name
--    end 
    from employees e inner join departments d on e.department_id = d.department_id
        where to_char(hire_date,'yyyy') =2007;

--33. employees. 직업이 'AD_PRESS' 인 사람은 A 등급을, 'ST_MAN' 인 사람은 B 등급을, 'IT_PROG' 인 사람은 C 등급을, 'SA_REP' 인 사람은 D 등급을, 'ST_CLERK' 인 사람은 E 등급을 기타는 0 을 부여하여 가져오시오.
select e.*,
    case
        when job_id = 'AD_PRES' then 'A'
        when job_id = 'ST_MAN' then 'B'
        when job_id = 'IT_PROG' then 'C'
        when job_id = 'SA_REP' then 'D'
        when job_id = 'ST_CLERK' then 'E'
        else '0'
    end as 등급
    
    from employees e;


--34. employees, jobs. 업무명(job_title)이 ‘Sales Representative’인 사원 중에서 연봉(salary)이 9,000이상, 10,000 이하인 사원들의 이름(first_name), 성(last_name)과 연봉(salary)를 가져오시오.
select e.first_name,e.last_name,e.salary from employees e inner join jobs j on e.job_id = j.job_id
    where j.job_title = 'Sales Representative' and salary between 9000 and 10000;


--35. employees, departments. 
--부서별로 가장 적은 급여를 받고 있는 사원의 이름, 부서이름, 급여를 가져오시오. 이름은 last_name만 가져오고, 
--부서이름으로 오름차순 정렬하고, 부서가 같은 경우 이름을 기준 으로 오름차순 정렬하여 가져오시오.  ***

select * from employees;
select * from departments;

select e.last_name,d.department_name,e.salary from employees e inner join departments d
                        on e.department_id = d.department_id
                        where (d.department_id,e.salary) in 
                        (select d2.department_id,min(e2.salary) from employees e2 inner join departments d2
                        on e2.department_id = d2.department_id
                        group by e2.department_id);
                        
select d.department_id,min(e.salary) from employees e inner join departments d
                        on e.department_id = d.department_id
                        group by e.department_id;                        


--36. employees, departments, locations. 사원의 부서가 속한 도시(city)가 
---‘Seattle’인 사원의 이름, 해당 사원의 매니저 이름, 사원 의 부서이름을 가져오시오. 이때 사원의 매니저가 없을 경우 ‘없음’이라고 가져오시오. 
--이름은 last_name만 가져오고, 사원의 이름을 오름차순으로 정렬하시오.
--
select e.last_name,nvl((select last_name from employees where employee_id = e.manager_id),'없음'),d.department_name from employees e inner join departments d 
                    on e.department_id = d.department_id inner join locations l
                        on l.location_id = d.location_id
                        where l.city = 'Seattle';
                        

--37. employees, jobs. 각 업무(job) 별로 연봉(salary)의 총합을 구하고자 한다. 
--    연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 가져오시오. 단 연봉총합이 30,000보다 큰 업무만 가져오시오.
--
select * from employees;
select * from jobs;

--38. employees, departments, locations, jobs. 각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 업무명(job_title), 부서 명(department_name)을 가져오시오. 단 도시명(city)이 ‘Seattle’인 지역(location)의 부서 (department)에 근무하는 사원을 사원번호 오름차순순으로 가져오시오.
--
--39. employees. 2001~20003년사이에 입사한 사원의 이름(first_name), 입사일(hire_date), 관리자사번 (employee_id), 관리자 이름(fist_name)을 가져오시오.
--    단, 관리자가 없는 사원정보도 결과에 포함시켜 가져오시오.
--
select e2.first_name,e2.hire_date,e1.employee_id,e1.first_name from employees e1 left outer join employees e2
                on e2.manager_id = e1.employee_id 
                where e2.hire_date between to_date('2001-01-01') and to_date('2003-12-31') ;
--40. employees, departments. ‘Sales’ 부서에 속한 사원의 이름(first_name), 급여(salary), 부서이름(department_name)을 가져오시오. 
--    단, 급여는 100번 부서의 평균보다 적게 받는 사원 정보만 가져오시오.
--
select first_name,salary,department_name from employees e inner join departments d 
                on e.department_id = d.department_id
                    where department_name = 'Sales' and salary<(select avg(salary) from employees where department_id = 100);

select avg(salary) from employees where department_id = 100;

--41. employees. last_name 에 'u' 가 포함되는 사원들과 동일 부서에 근무하는 사원들의 사번 및 last_name을 가져오시오.
--
select employee_id,last_name from employees 
where
department_id in 
(select distinct department_id from employees where last_name like '%u%');


--42. employees, departments. 부서별 사원들의 최대, 최소, 평균급여를 조회하되, 평균급여가 ‘IT’ 부서의 평균급여보다 많고, ‘Sales’ 부서의 평균보다 적은 부서 정보만 가져오시오. 
--
select * from 
(select (select distinct department_name from departments where department_id = e.department_id) as 부서,avg(salary) as 평균 from employees e inner join departments d
                    on e.department_id = d.department_id
                        group by e.department_id)
                        
                        where 평균 between (select avg(salary) from employees e inner join departments d
                                        on e.department_id = d.department_id
                                            where d.department_name = 'IT') and (select avg(salary) from employees e inner join departments d
                                                                                 on e.department_id = d.department_id
                                                                                       where d.department_name = 'Sales')
                            ;


select avg(salary) from employees e inner join departments d
                    on e.department_id = d.department_id
                        where d.department_name = 'IT';
                        
select avg(salary) from employees e inner join departments d
                    on e.department_id = d.department_id
                        where d.department_name = 'Sales';

--43. employees, departments. 각 부서별로 사원이 한명만 있는 부서만 가져오시오. 
--단, 사원이 없는 부서에 대해서는 ‘신생부서’라는 문자열을 가져오고,  결과는 부서명이 내림차순 으로 정렬되게 하시오.
--

select * from
(select * from departments d left outer join employees e
                    on d.department_id = e.department_id)
minus                    
(select * from departments d inner join employees e
                    on d.department_id = e.department_id);   
       
       
select d.department_name, 
        case
        when e.employee_id is null then '신생부서'
        when e.employee_id is not null then '한명만 있는 부서'
        end as "상태"
from departments d left outer join employees e
                    on d.department_id = e.department_id
                        where d.department_name in 
                        (select department_name from                    
                        (select department_name,count(*) as cnt from departments d left outer join employees e
                         on d.department_id = e.department_id
                             group by department_name)
                                where cnt =1);
       
                    
select department_name from                    
(select department_name,count(*) as cnt from departments d left outer join employees e
                    on d.department_id = e.department_id
                     group by department_name)
where cnt =1;
    

--44. employees, departments. 부서별 입사월별 사원수를 가져오시오. 단, 사원수가 5명 이상인 부서만 가져오고,  결과는 부서이름 순으로 하시오.
--
select * from
(select d.department_name,to_char(hire_date,'mm'),count(*) as cnt from employees e inner join departments d
                on e.department_id = d.department_id
                group by d.department_name,to_char(hire_date,'mm'))
where cnt >=5 order by department_name;
--45. employees, departments, locations, countries. 국가(country_name) 별 도시(city)별 사원수를 가져오시오.  
--    부서정보가 없는 사원은 국가명과 도시명 대신에 ‘부서없음’을 넣어서 가져오시오.
--
--46. employees, departments. 각 부서별 최대 급여자의 아이디(employee_id), 이름(first_name), 급여(salary)를 가져오시오.
--
select distinct department_id from employees;
select employee_id,first_name,salary from employees e inner join departments d
                on e.department_id = d.department_id
                    where (department_name,salary) in 
                    (select department_name,max(salary) as maxsalary from employees e inner join departments d
                    on e.department_id = d.department_id
                    group by department_name);

select department_name,max(salary) as maxsalary from employees e inner join departments d
                on e.department_id = d.department_id
                    group by department_name;

--47. employees. 커미션(commission_pct)별 사원수를 가져오시오. 커미션은 0.2, 0.25는 모두 .2로, 0.3, 0.35는 .3 형태로 바꾸시오.
--    단, 커미션 정보가 없는 사원들도 있는 데 커미션이 없는 사원 그룹은 ‘커미션 없음’으로 바꿔 가져오시오.
--
--48. employees, departments. 커미션(commission_pct)을 가장 많이 받은 상위 4명의 부서명(department_name), 사원명 (first_name), 급여(salary), 커미션(commission_pct) 정보를 가져오시오. 
--결과는 커미션 을 많이 받는 순서로 가져오되 동일한 커미션에 대해서는 급여가 높은 사원을 먼저 정렬하시오.

--49. tblInsa. 부서별 기본급이 가장 높은 사람을 가져오시오. (이름, 부서, 기본급)       
select * from tblinsa
where (buseo,basicpay) in
(select buseo,max(basicpay) as maxpay from tblInsa group by buseo);



--50. tblTodo. 등록 후 가장 빠르게 완료한 할일을 순서대로 상위 5개를 가져오시오.
select * from
(select * from tblTodo
    where completedate is not null
        order by (completedate - adddate)) where rownum <=5;




















































































