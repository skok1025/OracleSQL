--ex16_pseudo.sql
/*
�ǻ� �÷�, Pseudo Column

rownum
- ��¥ �÷��� �ƴѵ� �÷�ó�� �ൿ�ϴ� ���
- ���ȣ �ǻ��÷�(���� ���� ������ ��ȯ�ϴ� �ǻ� �÷�)
- ����Ŭ ����
- ���������� ���ϸ� ����ϱ� ����

*/
select * from tblinsa;

select name,buseo,jikwi,basicpay, rownum from tblinsa where rownum<=5;


select name,buseo,jikwi,basicpay, rownum --2
from tblinsa -- 1
order by basicpay desc;--3


-- **** rownum �� �׻� from ���� ����� �� ����** ���������. **************
select name,buseo,jikwi,basicpay,rownum,rnum from
--select * from
(select name,buseo,jikwi,basicpay, rownum as rnum
from tblinsa 
order by basicpay desc);

--**** ����
select i.*,rownum 
from
(select * from tblinsa order by basicpay desc) i
where rownum<=5;


select name,buseo,jikwi,basicpay,rownum as rnum 
from tblinsa
--where rownum = 1 -- o
--where rownum <= 5; -- o
------------------------ rownum�� ����� 1�� ���ԵǴ� ������ ���� ����
--where rownum = 3; --X
--where rownum>=10 and rownum<=20; --X
--where rownum>5; --X
--where rownum>=1 and rownum<=5; -- O
--where rownum=1 or rownum=2; -- O
----------------------- rownum �� ������ ����Ϸ��� �ݵ�� 1���� �����ؼ� ���������� �����;� �Ѵ�.
--where rownum=1 or rownum=3; -- X
where rownum=1 or rownum=2 or rownum=4;








-- web : ����¡(paging) 
-- ���� 60��

select name,basicpay,rownum 
    from tblInsa; --  ����


select name,basicpay,rownum 
    from tblInsa
        order by basicpay desc; -- ���ϴ� ���� + ���ȣ(��ȿX)

select name,basicpay, rownum
from
(select name,basicpay
    from tblInsa
        order by basicpay desc);-- ���ϴ� ���� > �ٽ� ���ȣ �Ҵ� (from ��)


select name,basicpay, rownum
from
(select name,basicpay
    from tblInsa
        order by basicpay desc)
                where rownum between 3 and 7; -- ���ϴ� ���� + ���ȣ���� > ����



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
            
            
            
            
-- �α����� ���� ���� ���� ���� ��� 3��
select * from tblCountry;    
            

select * 
from
    (select a.*,rownum as "�α� ���� ����" from
    (select * from tblCountry 
    where population is not null
    order by population asc) a)
where "�α� ���� ����" between 5 and 10;
        
-- tblInsa. �μ��� �ο��� Top 3

select 
b.*,
(select round(avg(basicpay)) from tblinsa where buseo = b.buseo) as �ش�μ���ձ޿�
from
    (select a.*,rownum as rank from
    (select buseo,count(*) as cnt from tblInsa 
        group by buseo 
        order by cnt desc) a) b
where rank<=3;


-- ���뺰 �׷�
select * from
(select ����,��,rownum as ���� from
(select floor(age/10) * 10 as ���� ,count(*) as �� from tblAddressBook
    group by floor(age/10) order by count(*) desc) a)
    where ���� between 2 and 3;

        