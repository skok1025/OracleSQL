--ex13_join.sql

/*
����, Join
*/
-- �������� + ��� ������Ʈ ����
create table tblStaff(
    seq number primary key, -- ������ȣ
    name varchar2(30) not null, -- ������
    salary number not null, -- �޿�
    address varchar2(300) not null, -- �ּ�
    projectname varchar2(100) null -- �ش������� ��� ���� ������Ʈ ��
);

drop table tblStaff;

insert into tblStaff(seq,name,salary,address,projectname) 
    values(1,'ȫ�浿',250,'�����','ȫ�� ����');
insert into tblStaff(seq,name,salary,address,projectname) 
    values(2,'�ƹ���',230,'�λ��','TV ����');
insert into tblStaff(seq,name,salary,address,projectname) 
    values(3,'������',210,'�����','���� �м�');

SELECT * FROM tblStaff;

-- ��å : ���� 1���� ���� ���� ������Ʈ�� ����ϴ°� �����ϴ�.
insert into tblStaff(seq,name,salary,address,projectname) 
    values(4,'ȫ�浿',250,'�����','�λ� ó��');
insert into tblStaff(seq,name,salary,address,projectname) 
    values(5,'ȫ�浿',250,'�����','���� ��ǰ');

-- ���� ���̺�
create table tblStaff(
    seq number primary key, -- ������ȣ
    name varchar2(30) not null, -- ������
    salary number not null, -- �޿�
    address varchar2(300) not null -- �ּ�
    -- projectSeq number null -- ������Ʈ ��ȣ
    );

-- ������Ʈ ���̺�
create table tblProject(
    seq number primary key, -- ������Ʈ ��ȣ (pk)
    projectname varchar2(100) null, -- �ش������� ��� ���� ������Ʈ ��
    staffSeq number null -- ������ȣ
);






insert into tblStaff(seq,name,salary,address) values(1,'ȫ�浿',250,'�����');
insert into tblStaff(seq,name,salary,address) values(2,'�ƹ���',230,'�λ��');
insert into tblStaff(seq,name,salary,address) values(3,'������',210,'�����');

insert into tblProject (seq,projectname,staffSeq) values(1,'ȫ�� ����',1);
insert into tblProject (seq,projectname,staffSeq) values(2,'TV ����',2);
insert into tblProject (seq,projectname,staffSeq) values(3,'���� �м�',2);
insert into tblProject (seq,projectname,staffSeq) values(4,'���� ����',1);
insert into tblProject (seq,projectname,staffSeq) values(5,'�븮�� �о�',3);

SELECT * FROM tblStaff;
select * from tblProject;

-- tblStaff(�⺻ ���̺�, �θ� ���̺�) + tblProject(���� ���̺�, �ڽ� ���̺�) : �� ���̺��� ����(Relationship)�� �ΰ� �ִ�. 
-- Oracle : RDBMS(Relational Database Management System)

-- ���踦 �ΰ� �ִ� 2���� ���̺��� �����͸� �����ϸ� ����� �ϵ�
-- 1. �θ� ���̺��� ����
--  a. �߰�
--  b.����
--  c.����
-- 2. �ڽ� ���̺��� ����
--  a. �߰�
--  b.����
--  c.����

select * from tblStaff;
select * from tblProject;

-- 1.���Ի�� �Ի� -> �ű� ������Ʈ ����(����� ����)

-- 1.a ���Ի�� �߰� (o)
insert into tblStaff(seq,name,salary,address) values(4,'ȣȣȣ',190,'��õ��');

-- 1.b �ű� ������Ʈ �߰� (o)
insert into tblProject (seq,projectname,staffSeq) values(6,'���� ����',4);

-- 1.c �ű� ������Ʈ �߰�(o)-> ���Ἲ�� ����
-- integrity constraint (HR.TBLPROJECT_STAFFSEQ_FK) violated - parent key not found
insert into tblProject (seq,projectname,staffSeq) values(7,'�� ��ġ',5);


-- 2. 'ȫ�浿' ��� 

-- 2.a 'ȫ�浿' ����
-- integrity constraint (HR.TBLPROJECT_STAFFSEQ_FK) violated - child record found
delete from tblStaff where name ='ȫ�浿';

-- 2.b �����ִ� �����鿡�� 'ȫ�浿'�� ������ ����.
update tblproject set 
    staffSeq = 2
        where staffSeq = 1;

-- 2.c ȫ�浿 ���
delete from tblStaff where name ='ȫ�浿';





-- �θ� ���̺� + �ڽ� ���̺�  :���� ���� (����� ����) > ���� ����
-- �θ� ���̺� + �ڽ� ���̺�  :���� ���� (DBMS�� ����) > ���� ���� > ������� �߰�
-- �ܷ�Ű, Foreign Key
-- : ���� ���迡 �ִ� �� ���̺� ���� ���� �� ������ �ϴ� �÷����� �ִ�. �� ���� �� ������ �÷������� �׻� ��ȿ�ϰ� 
--   ���� �����ִ� ���� ����

-- ���� ���̺�
create table tblStaff(
    seq number primary key, -- ������ȣ
    name varchar2(30) not null, -- ������
    salary number not null, -- �޿�
    address varchar2(300) not null -- �ּ�
    -- projectSeq number null -- ������Ʈ ��ȣ
    );

-- ������Ʈ ���̺�
create table tblProject(
    seq number primary key, -- ������Ʈ ��ȣ (pk)
    projectname varchar2(100) null, -- �ش������� ��� ���� ������Ʈ ��
    staffSeq number constraint tblProject_staffSeq_fk references tblStaff(seq) not null -- ������ȣ
);

drop table tblStaff;
drop table tblProject;




-- �� <-> �Ǹ�
-- �� ���̺�
create table tblCustomer(
    seq number primary key, -- �� ��ȣ (pk)
    name varchar2(30) not null, -- ����
    tel varchar2(15) not null, -- ����ó
    address varchar2(100) not null -- �ּ�
);

create table tblSales(
    seq number primary key, -- �ǸŹ�ȣ
    item varchar2(50) not null, -- ��ǰ��
    qty number not null, -- ����
    regdate date default sysdate not null, -- �Ǹų�¥
    customer number references tblCustomer(seq) not null -- ����ȣ(FK)
                                                            -- �ܷ�Ű�� null �̾ ��
);


-- ���� �뿩��
-- �帣 ���̺�

CREATE TABLE tblGenre
(
    seq number primary key, -- �帣��ȣ (pk)
    name varchar2(30) not null, -- �帣��
    price number not null, -- �뿩 ����
    period number not null
);

-- ���� ���̺�
create table tblVideo
(
    seq number primary key, -- ���� ��ȣ (pk)
    name varchar2(100) not null,
    qty number not null, -- ���� ����
    company varchar2(50) null, -- ���ۻ�
    director varchar2(50) null, -- ����
    major varchar2(50) null, -- �ֿ����
    genre number references tblGenre(seq) not null -- �帣��ȣ(FK)
);

-- ȸ�� ���̺�
create table tblMember
(
    seq number primary key, -- ȸ����ȣ (pk)
    name varchar2(20) not null,
    grade number(1) not null,
    byear number(4) not null, -- ����
    tel varchar2(15) not null,
    address varchar2(300) null,
    money number not null
);

-- �뿩 ���̺�
create table tblRent(
    seq number primary key, -- �뿩��ȣ
    member number references tblMember(seq) not null, -- �뿩�� ȸ����ȣ(FK)
    video number references tblVideo(seq) not null, -- �뿩�� ���� ��ȣ
    rentdate date default sysdate not null, -- �뿩��¥
    retdate date null, -- �ݳ���¥
    remart varchar2(500) -- ���
);

-- ������ ��ü
create sequence memberSeq;
create sequence genreSeq;
create sequence videoSeq;
create sequence rentSeq;


/*
����
- 2�� �̻��� ���̺��� ������ �ѹ��� ������ 1���� ������� ����� �۾�
- �и��Ǿ� �ִ� 2�� �̻��� ���̺��� 1���� ����� �۾�
- 2�� �̻��� ���̺��� ���� ���谡 �־�� �Ѵ�. (���� ���̺��� �����ϴ� ��� x)

������ ���� (ANSI SQL)
1. �ܼ� ����, Cross Join
2. ���� ����, Inner Join
3. �ܺ� ����, Outter Join
4. ���� ����, Self Join


*/

-- 1. �ܼ�����, ũ�ν� ����
select * from tblCustomer; --3��
select * from tblSales; -- 9��

-- 27 ��
select * from tblCustomer, tblSales; -- Oracle ǥ��
select * from tblCustomer cross join tblSales; -- ANSI ǥ��


/*
2. ��������
: �ܼ� ���ο��� ��ȿ�� ���ڵ常�� ���ϴ� ����
: �θ� ���̺��� PK�� �ڽ����̺��� FK�� ������ ���ڵ常�� ���ϴ� ����

select �÷�����Ʈ from ���̺�A 
         inner join ���̺�B 
             on ���̺�A.�÷���(PK) = ���̺�B.�÷���(FK);

*/
-- inner join�� ���> �ڽ� ���̺� ���ڵ� �� > 9 ��
-- ���ų����� �ش� �մ��� ������ �������ÿ�.

select * from tblCustomer;
select * from tblSales;

select * from tblCustomer
    inner join tblSALES
        ON tblCustomer.
        seq = tblSales.customer; -- �θ� = �ڽ� (o) 

select * from tblCustomer
    inner join tblSALES
        ON tblSales.customer = tblCustomer.seq; -- �ڽ� = �θ�
    
    
    
    
-- ORA-00918: column ambiguously defined 
--> ���̺��.�÷��� 
select tblSales.seq, tblCustomer.seq from tblCustomer
    inner join tblSALES
        ON tblCustomer.seq = tblSales.customer;



-- ǥ�� sql
select * from tblCustomer
    inner join tblSALES
        ON tblCustomer.seq = tblSales.customer;
-- Oracle
select * from tblCustomer, tblSales
    where tblCustomer.seq = tblSales.customer;

-- ���� ��� �� ����(�ǵ���) �ϸ� �ȵǴ� �ൿ
-- : PK - FK ����� �����ִ� ���̺����� ����.

select * from tblStaff;
select * from tblZoo;

select * from tblStaff
    inner join tblZoo 
        on tblStaff.seq = tblZoo.leg;
        

-- ��Ʈ(tblSales) �� �簣 ȸ���� ����ó(tblCustomer)?

-- 1. ��������
select name,tel from tblCustomer
    where seq = (select customer from tblSales
                  where item = '��Ʈ');

--2. ����
select tblCustomer.name, tblcustomer.tel from tblCustomer
    inner join tblSales
        on tblCustomer.seq = tblSales.customer
            where tblSales.item = '��Ʈ';
            
-- ���������� from ���� �����ϱ�
select * from (select * from tblCustomer
    inner join tblSales
        on tblCustomer.seq = tblSales.customer) 
        where item = '��Ʈ';

-- ������ �÷��� �տ� ���̺���� ���̱Ⱑ ������.  >�����ϰ� ���� > Table Alias(��Ī)
select c.name, c.tel --4
    from tblCustomer c inner join tblSales s -- 1
        on c.seq = s.customer-- 2
            where s.item = '��Ʈ'; --3
            

select * from tblCustomer;
select * from tblSales;

-- �� 1�� ����
insert into tblCustomer values(4,'ȣȣȣ','010-6866-9202','�����');

-- *****
-- ���� ������ �θ� ���̺��� ���ڵ尡 �ڽ� ���̺� �������� ������ �� �θ� ���ڵ�� ����¿��� ���ܰ� �ȴ�.
-- ���θ����� ��� 1ȸ �̻�(****) �����̷��� �ִ� ���� ������ ���� �̷��� �������ÿ�.
-- �θ����̺�� �ڽ����̺� ��� ���ÿ� �����ϴ� ���ڵ常 �����´�.
select * from tblCustomer c inner join tblSales s
on c.seq = s.customer;



-- ���θ����� �����̷°� ������� ��� �����̷°� �������� ��������, 
-- �����̷��� ���� ���� �̷� ������ ����� ä�� �������ÿ�. 

/*
3.�ܺ� ����
- select �÷�����Ʈ from ���̺�A left[right] outer join ���̺�B on c.PK =s.FK;
- �Ϲ������� ������ �θ����̺��� ����Ų��.
*/


-- ������ �ڽ� ���̺��� ����Ű�� �Ǹ� ���������� ����� �����ϴ�.
select * from tblCustomer c
    left outer join tblSales s
        on c.seq = s.customer;

-- ���� ����
-- ������ �뿩 ��ϰ� �� ������ �������ÿ�. (�ѹ��� �뿩���� �ʾҴ� �� ����)
select * from tblMember m
    inner join tblRent r
        on m.seq = r.member;

-- �ܺ� ����
-- �뿩�� ������ ������� ��� �� ���� + �뿩 ��� �� �������ÿ�.
select * from tblMember m
    left outer join tblRent r
        on m.seq = r.member;

/*
4. ��������
- 1�� ���̺��� ������ ����
- �ڽ��� �ڽ��� �����ϴ� Ű�� ������(PK + FK)
*/
drop table tblSelf;

-- ���� ����
CREATE TABLE tblSelf(
    seq number primary key, -- ������ȣ (pk)
    name varchar2(30) not null,
    department varchar2(30) null,
    super number references tblSelf(seq) null -- ���� ����ȣ(FK)
);

insert into tblSelf values(1,'ȫ����',null,null);
insert into tblSelf values(2,'�����','������',1);
insert into tblSelf values(3,'�̰���','������',2);
insert into tblSelf values(4,'���븮','������',3);
insert into tblSelf values(5,'�ֻ��','������',4);

insert into tblSelf values(6,'�ں���','ȫ����',1);
insert into tblSelf values(7,'�����','ȫ����',6);

select * from tblSelf;

-- ���� ���� + ���� ��� ����
select s2.name as ������, s1.name as ���� from tblSelf s1 -- �θ����̺� (���) 
        inner join tblSelf s2 -- �ڽ����̺� (����)
            on s1.seq = s2.super;
            
select s2.name as ������, nvl(s1.name,'  -') as ���� from tblSelf s1 -- �θ����̺� (���) 
        right outer join tblSelf s2 -- �ڽ����̺� (����)
            on s1.seq = s2.super;




select s2.name as "������", s1.name as "����" from tblSelf s1 inner join tblSelf s2
on s1.seq = s2.super;



-- inner join

-- ���̺� 1�� 
-- ������ ������ �ִ�? 
select * from tblVideo;

-- ���̺� 2��
-- ��� ���� ������ �뿩 ����, �Ⱓ?

select * from tblVideo v
    inner join tblGenre g
        on g.seq = v.genre;
        
-- ���̺� 3��
select * from tblVideo v
    inner join tblGenre g
        on g.seq = v.genre
            inner join tblRent r
                on v.seq=r.vdieo;

-- ���̺� 4��
select * from tblVideo v
    inner join tblGenre g
        on g.seq = v.genre
            inner join tblRent r
                on v.seq=r.vdieo
                    inner join tblMember m
                        on m.seq = r.member;

-- �뿩 ��� ��� : ȸ���� , ���� ����, ���� , �ݳ� ���� ('�ݳ��Ϸ�','�̹ݳ�')
select 
    m.name as "ȸ����",
    v.name as "���� ����",
    to_char(r.rentdate,'yyyy-mm-dd') as �뿩��¥,
    case
        when r.rentdate is null then round(sysdate-(r.rentdate + g.period))
        when r.rentdate is not null then null
    end as "��ü�Ⱓ", g.name,g.period,
    case
        when r.rentdate is null then round(sysdate-(r.rentdate + g.period)) * (g.price * 0.05)
        when r.rentdate is not null then null
    end as "��ü��", 
    case
        when r.rentdate is null then '�̹ݳ�'
        when r.rentdate is not null then '�ݳ� �Ϸ�'
        end as �ݳ�����
    from tblVideo v
        inner join tblGenre g
        on g.seq = v.genre
            inner join tblRent r
            on v.seq = r.video
                inner join tblMember m
                on m.seq = r.member;


-- ��� �������� , Correlated Sub Query
-- : �������� <-> (����) <-> �ٱ��� ����

-- * �� �Ϲ� �÷��� ���� ���� ���Ѵ�.
select *,last || first as name from tblname;
select first,last,weight,height,gender,nick,last || first as name from tblname;

select n.*,last || first as name from tblname n;

-- �ٱ����� ������ �÷��� ���� ���������� ���� �״��� ������ ����. (���� �������� ���̴�.)
select v.*,(select count(*) from tblVideo) from tblVideo v;


-- �ٱ����� ������ �÷��� ���� ���������� ���� �״��� ������ ����. (���� �������� ���̴�.)
select v.*,(select max(price) from tblGenre) from tblVideo v;




-- �ٱ����� ������ �÷��� ���� ���������� ���� ������Ų�� > ��� ��������
select v.*,(select max(price) from tblGenre where seq = v.genre) from tblVideo v;

select * from tblGenre;
select * from tblVideo;







