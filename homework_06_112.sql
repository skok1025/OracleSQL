--homework_06_112

--1. tblStaff, tblProject. ���� �������� ��� ������ �̸�, �ּ�, ����, ���������Ʈ���� �������ÿ�.
select * from tblStaff;
select * from tblProject;

select s.name,s.address,s.salary,p.projectname 
    from tblStaff s left outer join tblProject p on s.seq = p.staffseq;

--2. tblVideo, tblRent, tblMember. '�ǻ��ұ��' ��� ������ ������ ȸ���� �̸���?
select * from tblVideo;
select * from tblRent;
select * from tblMember;

select m.name from tblMember m 
    inner join tblRent r on m.seq = r.member
        inner join tblVideo v on v.seq = r.video
            where v.name = '�ǻ��ұ��';
        
--3. tblStaff, tblProejct. '��������'�� ����� ������ ������ ���ΰ�?
select * from tblStaff;
select * from tblProject;

select s.name from tblStaff s inner join tblProject p on s.seq = p.staffseq
    where p.projectname='���� ����';

--4. tblVideo, tblRent, tblMember. '�й̳�����' ������ �ѹ��̶� �������� ȸ������ �̸���?
select * from tblVideo;
select * from tblRent;
select * from tblMember;

select m.name from tblMember m left outer join tblRent r on m.seq = r.member
    left join tblVideo v on r.video = v.seq
        where v.name = '�й̳�����';
--5. tblStaff, tblProject. ����ÿ� ��� ������ ������ ������ �������� �̸�, ����, ���������Ʈ���� �������ÿ�.
select * from tblStaff;
select * from tblProject;

select s.name,s.salary,p.projectname from tblStaff s left outer join tblProject p on s.seq=p.staffseq
    where s.address<>'�����';

--6. tblCustomer, tblSales. ��ǰ�� 2��(���ϻ�ǰ) �̻� ������ ȸ���� ����ó, �̸�, ���Ż�ǰ��, ������ �������ÿ�.
select * from tblCustomer;
select * from tblSales;

select c.name,c.tel,s.item,s.qty from tblCustomer c inner join tblSales s on c.seq = s.customer
    where s.qty >=2;
--7. tblVideo, tblRent, tblGenre. ��� ���� ����, ��������, �뿩������ �������ÿ�.
select * from tblVideo;
select * from tblRent;
select * from tblGenre;
select distinct v.name,v.qty,g.price from tblVideo v left outer join tblRent r on v.seq=r.video 
    left outer join tblGenre g on g.seq = v.genre;


--8. tblVideo, tblRent, tblMember, tblGenre. 2007�� 2���� �뿩�� ���ų����� �������ÿ�. ȸ����, ������, ����, �뿩����
select m.name, v.name, r.rentdate, g.price from tblMember m inner join tblRent r on m.seq = r.member
    inner join tblVideo v on r.video = v.seq 
        inner join tblGenre g on g.seq = v.genre
            where r.rentdate >'2007-02-01' and r.rentdate < '2007-03-01' ;

--9. tblVideo, tblRent, tblMember. ���� �ݳ��� ���� ȸ����� ������, �뿩��¥�� �������ÿ�.
select m.name,v.name,to_char(r.rentdate,'yyyy-mm-dd') from tblVideo v left outer join tblRent r on v.seq=r.video
    left outer join tblMember m on r.member = m.seq
        where rentdate is not null and retdate is null;  
--10. tblInsa. ���� ���� �߿��� �޿��� 3��°�� ���� �޴� ������ 9��°�� ���� �޴� ������ �޿� ������ ��?
select distinct (select �޿� 
    from (select i2.*,rownum as num from (select basicpay+sudang as �޿� from tblInsa i order by �޿� desc) i2 ) i3 where num=3) 
    - (select �޿� 
    from (select i2.*,rownum as num from (select basicpay+sudang as �޿� from tblInsa i order by �޿� desc) i2 ) i3 where num=9) as �޿��� from tblInsa;


select �޿� 
    from (select i2.*,rownum as num from (select basicpay+sudang as �޿� from tblInsa i order by �޿� desc) i2 ) i3 where num=3;

--11. employees, departments. ������� �̸�, �μ���ȣ, �μ����� �������ÿ�.
select * from employees;
select * from departments;

select e.last_name||e.first_name as �̸� , e.department_id as �μ���ȣ, d.department_name as �μ��� from employees e inner join departments d on e.department_id=d.department_id;

--12. employees, jobs. ������� ������ �������� �������ÿ�.
select * from employees;
select * from jobs;

select e.* ,j.job_title from employees e inner join jobs j on j.job_id =e.job_id;

--13. employees, jobs. ����(job_id)�� �ְ�޿�(max_salary) �޴� ��� ������ �������ÿ�.
select * from employees;
select * from jobs;

select e.* from employees e inner join jobs j on e.job_id=j.job_id
    where e.salary = j.max_salary;

--14. departments, locations. ��� �μ��� �� �μ��� ��ġ�ϰ� �ִ� ������ �̸��� �������ÿ�.
select * from departments;
select * from locations;

select d.department_name,l.city from departments d inner join locations l on d.location_id=l.location_id;

--15. locations, countries. location_id �� 2900�� ���ð� ���� ���� �̸��� �������ÿ�.
select * from locations;
select * from countries;

select c.country_name from locations l inner join countries c on l.country_id = c.country_id
    where l.location_id=2900;

--16. employees. �޿��� 12000 �̻� �޴� ����� ���� �μ����� �ٹ��ϴ� ������� �̸�, �޿�, �μ���ȣ�� �������ÿ�.
select last_name||first_name as name,salary,department_id from
employees where department_id in (select department_id from employees where salary >=12000 group by department_id);

--17. employees, departments. locations.  'Seattle'����(LOC) �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸��� �������ÿ�.
select * from departments;
select * from locations;
select * from employees;

select e.last_name||e.first_name as name , e.job_id,e.department_id,d.department_name from employees e inner join departments d on e.department_id = d.department_id
    inner join locations l on d.location_id = l.location_id
        where l.city='Seattle';

--18. employees, departments. first_name�� 'Jonathon'�� ������ ���� �μ��� �ٹ��ϴ� ������ ������ �������ÿ�.
select * from departments;
select * from locations;
select * from employees;

select * from employees where job_id
in (select job_id from departments d inner join locations l on d.location_id = l.location_id 
    inner join employees e on e.department_id = d.department_id
        where e.first_name='Jonathon');
    

--19. employees, departments. ����̸��� �� ����� ���� �μ��� �μ���, �׸��� ������ ����ϴµ� ������ 3000�̻��� ����� �������ÿ�.
select e.last_name||e.first_name as name, d.department_name,e.salary from employees e inner join departments d on e.department_id = d.department_id
    where e.salary >=3000;


--20. employees, departments. �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�, ����, �޿������ �������ÿ�.
select e.department_id,d.department_name,e.last_name||e.first_name as name from employees e inner join departments d on e.department_id = d.department_id 
    where e.department_id=10;


--21. employees, departments. ��� �μ��� ������ �������� �μ����� �ִ� �μ��� �μ����� ������ ���� �������ÿ�. ****
select * from employees;
select * from departments;

select e.* from employees e inner join departments d on e.department_id = d.department_id
    where d.manager_id=e.employee_id;


--22. departments, job_history. ����� ����� �Ի���, �����, �ٹ��ߴ� �μ� �̸��� �������ÿ�.
select * from job_history;
select * from departments;

select to_char(h.start_date,'yyyy-mm-dd') as �Ի���,
        to_char(h.end_date,'yyyy-mm-dd') as �����,
        d.department_name
    from job_history h inner join departments d on h.department_id = d.department_id;


--23. employees. �����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� �������� �����ȣ�� ����̸��� ����ϵ� ������ �÷����� '�����ȣ', '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� �������ÿ�.

select e2.employee_id as �����ȣ, e2.last_name||e2.first_name as ����̸�, e2.manager_id as �����ڹ�ȣ, e1.last_name||e1.first_name as �������̸�
    from employees e1/*�Ŵ������̺�*/ inner join employees e2/*���*/ on e1.employee_id = e2.manager_id;



--24. employees, jobs. ��å(Job Title)�� Sales Manager�� ������� �Ի�⵵�� �Ի�⵵(hire_date)�� ��� �޿��� �������ÿ�. �⵵�� �������� �������� ����.
select * from employees;
select * from jobs;


select to_char(hire_date,'yy-mm-dd') as �Ի�⵵,avg(salary) as ��ձ޿� from
(select * from employees e inner join jobs j on e.job_id = j.job_id where j.job_title='Sales Manager') group by hire_date order by hire_date asc;


--25. employees, departments. locations. �� ����(city)�� �ִ� ��� �μ� ������� ��ձ޿��� ���� ���� ���ú��� ���ø�(city)�� ��տ���, �ش� ������ ������� �������ÿ�. 
--��, ���ÿ� �� ���ϴ� ����� 10�� �̻��� ���� �����ϰ� �������ÿ�.

select * from employees;
select * from departments;
select * from locations;

select * 
    from (select city,round(avg(salary)) as ��ձ޿�,count(*) as cnt 
        from (select l.city,e.salary from employees e inner join departments d on e.department_id = d.department_id inner join locations l on d.location_id = l.location_id) t group by city)
            where cnt <10 order by ��ձ޿� asc;


select city,round(avg(salary)),count(*) as cnt 
    from (select l.city,e.salary from employees e inner join departments d on e.department_id = d.department_id inner join locations l on d.location_id = l.location_id) t group by city;
select l.city,e.salary from employees e inner join departments d on e.department_id = d.department_id inner join locations l on d.location_id = l.location_id;



--26. employees, jobs, job_history. ��Public  Accountant���� ��å(job_title)���� ���ſ� �ٹ��� ���� �ִ� ��� ����� ����� �̸��� �������ÿ�. 
--���� ��Public Accountant���� ��å(job_title)���� �ٹ��ϴ� ����� ��� ���� ����.
select * from employees;
select * from jobs;
select * from job_history;

select e.employee_id,e.last_name||e.first_name as name  from employees e inner join job_history h on e.employee_id=h.employee_id inner join jobs j on h.job_id = j.job_id
    where j.job_title = 'Public Accountant';


--27. employees, departments, locations. Ŀ�̼��� �޴� ��� ������� first_name, last_name, �μ���, ���� id, ���ø��� �������ÿ�.
select * from employees;
select * from departments;
select * from locations;

select e.first_name,e.last_name,d.department_name,l.country_id, l.city from employees e inner join departments d on e.department_id = d.department_id inner join locations l on d.location_id = l.location_id
    where e.commission_pct is not null;


--28. employees. �ڽ��� �Ŵ������� ���� ���� ������� first_name, last_name, ������� �������ÿ�.
select * from employees;

--select * from employees e1 inner join employees e2/*�Ŵ�������*/ on e1.employee_id =e2.manager_id;
select ������,�����̸�,to_char(���������,'yy-mm-dd') from
(select e2.first_name as ������,e2.last_name as �����̸�,e2.hire_date as ��������� ,e1.first_name,e1.last_name,e1.hire_date as �Ŵ�������� 
    from employees e1 /*�Ŵ�������*/ inner join employees e2 on e1.employee_id =e2.manager_id) t where ��������� < �Ŵ��������;
        

--29. employees. �ų����� �ٹ��ϴ� ����� �� ����ΰ�?
select count(*) from
    employees where employee_id in (select manager_id from employees  group by manager_id) ;


--30. employees. �ڽ��� �Ŵ������� ����(salary)�� ���� �޴� ������� ��(last_name)�� ����(salary)�� �������ÿ�.
select ������,�������� from 
    (select e1.last_name as ������,e1.salary as ��������,e2.salary as �Ŵ������� 
        from employees e1 inner join employees e2/*�Ŵ���*/ on e2.employee_id = e1.manager_id) 
            where ��������>�Ŵ�������;


--31. employees. �� ��� �� ��  2003, 2004, 2005, 2006 �⵵ �� ���� ������� �� ���� �������ÿ�. ***
select * from employees order by hire_date asc;
select (select count(*) from employees) as ��ü�����,
    ()
    
    from employees ;
select (select count(*) from employees) as ��ü�����,to_char(hire_date,'yyyy') as �Ի�⵵,count(*) as ����� from employees where to_char(hire_date,'yyyy') between 2003 and 2006 group by to_char(hire_date,'yyyy');




--32. employees, departments. 2007�⿡ �Ի�(hire_date)�� ������� ���(employee_id), �̸�(first_name), ��(last_name), �μ���(department_name)�� �������ÿ�. 
--��, �μ��� ��ġ���� ���� ����� 'Not Assigned'�� �������ÿ�. ***

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

--33. employees. ������ 'AD_PRESS' �� ����� A �����, 'ST_MAN' �� ����� B �����, 'IT_PROG' �� ����� C �����, 'SA_REP' �� ����� D �����, 'ST_CLERK' �� ����� E ����� ��Ÿ�� 0 �� �ο��Ͽ� �������ÿ�.
select e.*,
    case
        when job_id = 'AD_PRES' then 'A'
        when job_id = 'ST_MAN' then 'B'
        when job_id = 'IT_PROG' then 'C'
        when job_id = 'SA_REP' then 'D'
        when job_id = 'ST_CLERK' then 'E'
        else '0'
    end as ���
    
    from employees e;


--34. employees, jobs. ������(job_title)�� ��Sales Representative���� ��� �߿��� ����(salary)�� 9,000�̻�, 10,000 ������ ������� �̸�(first_name), ��(last_name)�� ����(salary)�� �������ÿ�.
select e.first_name,e.last_name,e.salary from employees e inner join jobs j on e.job_id = j.job_id
    where j.job_title = 'Sales Representative' and salary between 9000 and 10000;


--35. employees, departments. 
--�μ����� ���� ���� �޿��� �ް� �ִ� ����� �̸�, �μ��̸�, �޿��� �������ÿ�. �̸��� last_name�� ��������, 
--�μ��̸����� �������� �����ϰ�, �μ��� ���� ��� �̸��� ���� ���� �������� �����Ͽ� �������ÿ�.  ***

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


--36. employees, departments, locations. ����� �μ��� ���� ����(city)�� 
---��Seattle���� ����� �̸�, �ش� ����� �Ŵ��� �̸�, ��� �� �μ��̸��� �������ÿ�. �̶� ����� �Ŵ����� ���� ��� ���������̶�� �������ÿ�. 
--�̸��� last_name�� ��������, ����� �̸��� ������������ �����Ͻÿ�.
--
select e.last_name,nvl((select last_name from employees where employee_id = e.manager_id),'����'),d.department_name from employees e inner join departments d 
                    on e.department_id = d.department_id inner join locations l
                        on l.location_id = d.location_id
                        where l.city = 'Seattle';
                        

--37. employees, jobs. �� ����(job) ���� ����(salary)�� ������ ���ϰ��� �Ѵ�. 
--    ���� ������ ���� ���� �������� ������(job_title)�� ���� ������ �������ÿ�. �� ���������� 30,000���� ū ������ �������ÿ�.
--
select * from employees;
select * from jobs;

--38. employees, departments, locations, jobs. �� ���(employee)�� ���ؼ� ���(employee_id), �̸�(first_name), ������(job_title), �μ� ��(department_name)�� �������ÿ�. �� ���ø�(city)�� ��Seattle���� ����(location)�� �μ� (department)�� �ٹ��ϴ� ����� �����ȣ �������������� �������ÿ�.
--
--39. employees. 2001~20003����̿� �Ի��� ����� �̸�(first_name), �Ի���(hire_date), �����ڻ�� (employee_id), ������ �̸�(fist_name)�� �������ÿ�.
--    ��, �����ڰ� ���� ��������� ����� ���Խ��� �������ÿ�.
--
select e2.first_name,e2.hire_date,e1.employee_id,e1.first_name from employees e1 left outer join employees e2
                on e2.manager_id = e1.employee_id 
                where e2.hire_date between to_date('2001-01-01') and to_date('2003-12-31') ;
--40. employees, departments. ��Sales�� �μ��� ���� ����� �̸�(first_name), �޿�(salary), �μ��̸�(department_name)�� �������ÿ�. 
--    ��, �޿��� 100�� �μ��� ��պ��� ���� �޴� ��� ������ �������ÿ�.
--
select first_name,salary,department_name from employees e inner join departments d 
                on e.department_id = d.department_id
                    where department_name = 'Sales' and salary<(select avg(salary) from employees where department_id = 100);

select avg(salary) from employees where department_id = 100;

--41. employees. last_name �� 'u' �� ���ԵǴ� ������ ���� �μ��� �ٹ��ϴ� ������� ��� �� last_name�� �������ÿ�.
--
select employee_id,last_name from employees 
where
department_id in 
(select distinct department_id from employees where last_name like '%u%');


--42. employees, departments. �μ��� ������� �ִ�, �ּ�, ��ձ޿��� ��ȸ�ϵ�, ��ձ޿��� ��IT�� �μ��� ��ձ޿����� ����, ��Sales�� �μ��� ��պ��� ���� �μ� ������ �������ÿ�. 
--
select * from 
(select (select distinct department_name from departments where department_id = e.department_id) as �μ�,avg(salary) as ��� from employees e inner join departments d
                    on e.department_id = d.department_id
                        group by e.department_id)
                        
                        where ��� between (select avg(salary) from employees e inner join departments d
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

--43. employees, departments. �� �μ����� ����� �Ѹ� �ִ� �μ��� �������ÿ�. 
--��, ����� ���� �μ��� ���ؼ��� ���Ż��μ������ ���ڿ��� ��������,  ����� �μ����� �������� ���� ���ĵǰ� �Ͻÿ�.
--

select * from
(select * from departments d left outer join employees e
                    on d.department_id = e.department_id)
minus                    
(select * from departments d inner join employees e
                    on d.department_id = e.department_id);   
       
       
select d.department_name, 
        case
        when e.employee_id is null then '�Ż��μ�'
        when e.employee_id is not null then '�Ѹ� �ִ� �μ�'
        end as "����"
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
    

--44. employees, departments. �μ��� �Ի���� ������� �������ÿ�. ��, ������� 5�� �̻��� �μ��� ��������,  ����� �μ��̸� ������ �Ͻÿ�.
--
select * from
(select d.department_name,to_char(hire_date,'mm'),count(*) as cnt from employees e inner join departments d
                on e.department_id = d.department_id
                group by d.department_name,to_char(hire_date,'mm'))
where cnt >=5 order by department_name;
--45. employees, departments, locations, countries. ����(country_name) �� ����(city)�� ������� �������ÿ�.  
--    �μ������� ���� ����� ������� ���ø� ��ſ� ���μ��������� �־ �������ÿ�.
--
--46. employees, departments. �� �μ��� �ִ� �޿����� ���̵�(employee_id), �̸�(first_name), �޿�(salary)�� �������ÿ�.
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

--47. employees. Ŀ�̼�(commission_pct)�� ������� �������ÿ�. Ŀ�̼��� 0.2, 0.25�� ��� .2��, 0.3, 0.35�� .3 ���·� �ٲٽÿ�.
--    ��, Ŀ�̼� ������ ���� ����鵵 �ִ� �� Ŀ�̼��� ���� ��� �׷��� ��Ŀ�̼� ���������� �ٲ� �������ÿ�.
--
--48. employees, departments. Ŀ�̼�(commission_pct)�� ���� ���� ���� ���� 4���� �μ���(department_name), ����� (first_name), �޿�(salary), Ŀ�̼�(commission_pct) ������ �������ÿ�. 
--����� Ŀ�̼� �� ���� �޴� ������ �������� ������ Ŀ�̼ǿ� ���ؼ��� �޿��� ���� ����� ���� �����Ͻÿ�.

--49. tblInsa. �μ��� �⺻���� ���� ���� ����� �������ÿ�. (�̸�, �μ�, �⺻��)       
select * from tblinsa
where (buseo,basicpay) in
(select buseo,max(basicpay) as maxpay from tblInsa group by buseo);



--50. tblTodo. ��� �� ���� ������ �Ϸ��� ������ ������� ���� 5���� �������ÿ�.
select * from
(select * from tblTodo
    where completedate is not null
        order by (completedate - adddate)) where rownum <=5;




















































































