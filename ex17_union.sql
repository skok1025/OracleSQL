-- ex17_union.sql

/*
union
-���̺��� ��ġ�� ���
- ��

join
-���̺��� ��ġ�� ���
- Ⱦ

*/

create table ����
as
select * from tblinsa where jikwi = '����';

create table ����
as
select * from tblinsa where jikwi = '����'; 


select * from ����; --8
select * from ����; --5

-- union:������ ���� 2�� �̻� ���̺��� �ϳ��� ��ģ��
select * from ����
union
select * from ����; -- 8+5

select name,ssn from ����
union
select name,basicpay from ����;

-- ������ �����ϴٰ� �ص� union�� �ϸ� �ȵȴ�. (***) > ������ �ǹ̰� ��� ���ƾ� ����!!!
select name,sudang from ����
union
select name,basicpay from ����;

-- �� ���� �÷� ���� �����ؾ� �Ѵ�.
select name,basicpay,ssn from ����
union
select name,basicpay,null from ����;


-- ���� ���̺��� 1���� ���̺�� ����(***)�ϴ� �뵵
select name from tblCustomer
union
select name from tblMember
union
select last||first as name from tblname
union
select name from tblStaff;


-- ȸ��(�μ��� �Խ���)
-- 1. �Խ��� ���̺� 1���� ����
--    :�Խù��� �μ��� �����ϴ� �÷� ���� & ��� 
--    : ������ ��� �Խù��� �����ϴ� ������ ����� ��

-- 2. �Խ��� ���̺� �μ��� ����
--    : �μ����� ������ ���̺� ����
--    : �ɰ��� �� ������ ����, ���ļ� �� ������ ���� ��

-- ������, �ѹ���, ��ȹ�� �Խ���

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

-- �Խù�
insert into tblBoard1 values (1,'������ �Խ����Դϴ�');
insert into tblBoard1 values (2,'������ ȸ���Դϴ�');
insert into tblBoard1 values (3,'������ �����Դϴ�');

insert into tblBoard2 values (1,'�ѹ��� �Խ����Դϴ�');
insert into tblBoard2 values (2,'�������� �Խ����Դϴ�');

insert into tblBoard3 values (1,' ��ȹ �Խ����Դϴ�');
insert into tblBoard3 values (2,'��ȹ �Խ����Դϴ�');
insert into tblBoard3 values (3,'��ȹ �Խ����Դϴ�');
insert into tblBoard3 values (4,'�������� �Խ����Դϴ�');


------------------------------------------------------------

-- �Ϸù�ȣ + ��ġ�� �ʴ� ���� > sequence ��ü
create sequence boardSeq;
insert into tblBoard1 values (boardSeq.nextval,'������ �Խ����Դϴ�');
insert into tblBoard1 values (boardSeq.nextval,'������ ȸ���Դϴ�');
insert into tblBoard1 values (boardSeq.nextval,'������ �����Դϴ�');

insert into tblBoard2 values (boardSeq.nextval,'�ѹ��� �Խ����Դϴ�');
insert into tblBoard2 values (boardSeq.nextval,'�������� �Խ����Դϴ�');

insert into tblBoard3 values (boardSeq.nextval,' ��ȹ �Խ����Դϴ�');
insert into tblBoard3 values (boardSeq.nextval,'��ȹ �Խ����Դϴ�');
insert into tblBoard3 values (boardSeq.nextval,'��ȹ �Խ����Դϴ�');
insert into tblBoard3 values (boardSeq.nextval,'�������� �Խ����Դϴ�');




select * from tblBoard1;
select * from tblBoard2;
select * from tblBoard3;

-- ����� -> ��� �Խù��� �ѹ��� ���� �ش޶�..

select * from
    (select * from tblBoard1
    union
    select * from tblBoard2
    union
    select * from tblBoard3)
    order by seq desc;




-- ���̿���
-- ���� : �Խù� 5��ġ > ���� 6����
-- 1. 1�� ���̺� ���
-- : �ϰ��˻�, ���հ��� ����.
-- : �����Ͱ� ���������� �˻��� �ð��� �����ɸ�
-- 2. ������ ���̺� ���
-- : ���̺� ���� ���ڵ带 �ٿ��� �˻� �ӵ��� ������
-- : ���� ���� > union ���� ����� ����ؼ� (����,���߻�)


 
create table tblUnionA
(
    name varchar2(50) NOT NULL
);
 
create table tblUnionB
(
    name varchar2(50) NOT NULL
);

INSERT INTO tblUnionA values('���');
INSERT INTO tblUnionA values('��');
INSERT INTO tblUnionA values('���ξ���');
INSERT INTO tblUnionA values('�ٳ���');
INSERT INTO tblUnionA values('����');


INSERT INTO tblUnionB values('Ű��');
INSERT INTO tblUnionB values('�ٳ���');
INSERT INTO tblUnionB values('������');
INSERT INTO tblUnionB values('����');
INSERT INTO tblUnionB values('������');

SELECT * from tblUnionA;
SELECT * from tblUnionB;

SELECT name,count(*) from
(SELECT * from tblUnionA
UNION -- �ߺ����� ����
SELECT * from tblUnionB) group by name;

SELECT * from tblUnionA
UNION all-- �ߺ����� ǥ��
SELECT * from tblUnionB;

SELECT name,count(*) from
(SELECT * from tblUnionA
UNION ALL -- �ߺ����� ǥ��
SELECT * from tblUnionB) group by name having count(*)>1;


select * from tblinsa where buseo = '��ȹ��'
UNION
select * from tblinsa where jikwi = '�븮';


SELECT * FROM tblUnionA
intersect -- ������
SELECT * FROM tblUnionB;

select * from tblUnionA
minus -- A-B -> A���� �ִ� �͸�
select * from tblUnionB;

select * from tblUnionB
minus -- B-A -> B���� �ִ� �͸�
select * from tblUnionA;
