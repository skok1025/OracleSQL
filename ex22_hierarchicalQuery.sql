-- ex22_hierarchicalQuery.sql


/*
������ ����, HierarchicalQuery
- ����Ŭ������ ���� 
- �亯�� �Խ���, ī�װ� ����, BOM(���� ����) ��...
- �θ�� �ڽ����� ������ Ʈ�� ������ �����͸� ó���ϴ� ����

��ǻ��
    - ��ü
        -���κ���
        -�׷���ī��
        -��ī��
        -�޸�
    - �����
        -��ȣ�ʸ�
    - ������
        -��ũ īƮ����
        -A4 ����

*/
create table tblComputer
(
    seq number primary key,
    name varchar2(100) not null,
    qty number not null,
    pseq number references tblComputer(seq) -- �θ� ��ǰ (FK)
);


insert into tblComputer values(1,'��ǻ��',1,null); -- ��Ʈ ���

insert into tblComputer values(2,'��ü',1,1);
insert into tblComputer values(3,'�����',1,1);
insert into tblComputer values(4,'������',1,1);

insert into tblComputer values(5,'���κ���',1,2);
insert into tblComputer values(6,'�׷���ī��',1,2);
insert into tblComputer values(7,'��ī��',1,2);
insert into tblComputer values(8,'�޸�',2,2);

insert into tblComputer values(9,'��ȣ�ʸ�',1,3);

insert into tblComputer values(10,'��ũ īƮ����',1,4);
insert into tblComputer values(11,'A4����',100,4);



select * from tblComputer;


-- 1. ��������
-- : inner join or outer join > ������ ���̺��� ������ ���� > ��Ȳ

select c1.name as �θ��ǰ, c2.name as �ڽĺ�ǰ From 
                                tblComputer c1 inner join tblComputer c2
                                                          on c1.seq = c2.pseq; -- c1(�θ�), c2(�ڽ�)


-- 2. ������ ����
-- : start with �� connect by ��
select * from tblComputer
    start with seq = 1 -- ��Ʈ��� ����
        connect by prior seq = pseq; -- �θ� �ڽ��� ���� ��

-- ������ ������ �ǻ��÷�
select lpad(' ',(level-1)*5)||name,level from tblComputer
    start with seq = 1 
        connect by prior seq = pseq; 

-- prior : ������ ���� �ǻ� �÷� > �θ� ���ڵ� ����
select lpad(' ',(level-1)*5)||name,level,prior name from tblComputer
    start with seq = 1 
        connect by prior seq = pseq; 


-- start with
select lpad(' ',(level-1)*5)||name,level,prior name from tblComputer
    --start with seq = 2
    --start with seq = (select seq from tblComputer where name = '��ǻ��')
    start with pseq is null -- root node
        connect by 
                    prior seq = pseq; 


drop table tblComment;
drop table tblBoard;


-- ������ �Խ���
create table tblBoard
(
    seq number primary key,
    subject varchar2(1000) not null,
    pseq number null -- �θ� �۹�ȣ
);


-- ī�װ� ���̺�
create table tblCategory
(
    seq number primary key,
    name varchar2(100) not null,
    pseq number null -- �θ� ī�װ�
);

INSERT INTO tblboard VALUES (1, '1�� ���Դϴ�.', NULL);
INSERT INTO tblboard VALUES (2, '2�� ���Դϴ�.', NULL);
INSERT INTO tblboard VALUES (3, '3�� ���Դϴ�.', NULL);

INSERT INTO tblboard VALUES (4, '1���� ù��° �亯���Դϴ�.', 1);
INSERT INTO tblboard VALUES (5, '1���� �ι�° �亯���Դϴ�.', 1);
INSERT INTO tblboard VALUES (6, '1���� ����° �亯���Դϴ�.', 1);

INSERT INTO tblboard VALUES (7, '2���� ù��° �亯���Դϴ�.', 2);
INSERT INTO tblboard VALUES (8, '2���� �ι�° �亯���Դϴ�.', 2);

INSERT INTO tblboard VALUES (9, '3���� ù��° �亯���Դϴ�.', 3);
INSERT INTO tblboard VALUES (10, '3���� �ι�° �亯���Դϴ�.', 3);
INSERT INTO tblboard VALUES (11, '3���� ����° �亯���Դϴ�.', 3);

INSERT INTO tblboard VALUES (12, '1���� ù��° �亯�� ù��° �亯���Դϴ�.', 4);
INSERT INTO tblboard VALUES (13, '1���� ù��° �亯�� �ι�° �亯���Դϴ�.', 4);

INSERT INTO tblboard VALUES (14, '2���� ù��° �亯�� ù��° �亯���Դϴ�.', 7);
INSERT INTO tblboard VALUES (15, '3���� �ι�° �亯�� ù��° �亯���Դϴ�.', 10);


INSERT INTO tblcategory VALUES (1, '�м��Ƿ�/��ȭ', NULL);
INSERT INTO tblcategory VALUES (2, '��Ƽ', NULL);
INSERT INTO tblcategory VALUES (3, '�ֹ��ǰ', NULL);
INSERT INTO tblcategory VALUES (4, '�����м�', 1);
INSERT INTO tblcategory VALUES (5, '�����м�', 1);
INSERT INTO tblcategory VALUES (6, '���̺��м�', 1);
INSERT INTO tblcategory VALUES (7, 'Ƽ����', 4);
INSERT INTO tblcategory VALUES (8, '����', 4);
INSERT INTO tblcategory VALUES (9, '���콺', 5);
INSERT INTO tblcategory VALUES (10, '���ǽ�', 5);
INSERT INTO tblcategory VALUES (11, '��ĿƮ', 5);
INSERT INTO tblcategory VALUES (12, '���̺� ����', 6);
INSERT INTO tblcategory VALUES (13, '���̺� ����', 6);
INSERT INTO tblcategory VALUES (14, '���̺� ����', 6);
INSERT INTO tblcategory VALUES (15, '��Ų�ɾ�', 2);
INSERT INTO tblcategory VALUES (16, '���', 2);
INSERT INTO tblcategory VALUES (17, '���� ȭ��ǰ', 15);
INSERT INTO tblcategory VALUES (18, 'Ŭ��¡', 15);
INSERT INTO tblcategory VALUES (19, '����ũ', 15);
INSERT INTO tblcategory VALUES (20, '���� ���', 16);
INSERT INTO tblcategory VALUES (21, '���� ���', 16);
INSERT INTO tblcategory VALUES (22, '�׸�', 3);
INSERT INTO tblcategory VALUES (23, '��', 3);
INSERT INTO tblcategory VALUES (24, '��ȸ��ǰ', 3);
INSERT INTO tblcategory VALUES (25, '�ı�', 22);
INSERT INTO tblcategory VALUES (26, '���ƽı�', 22);
INSERT INTO tblcategory VALUES (27, '�ӱ�', 23);
INSERT INTO tblcategory VALUES (28, '������', 23);
INSERT INTO tblcategory VALUES (29, '�Һ�', 23);
INSERT INTO tblcategory VALUES (30, '������', 24);


commit;

select * from tblBoard;
select * from tblCategory;


-- ������ ����
select lpad(' ',(level-1)*5) || subject as subject from tblBoard
    -- where ��
    start with pseq is null
        connect by prior seq = pseq
            -- order by ��
            order siblings by seq desc;


-- ī�װ�
select lpad(' ',(level-1)*5) || name from tblCategory
    start with pseq is null
        connect by prior seq = pseq
            order siblings by name asc;



-- ������...
select 
lpad(' ',(level-1)*5) || name as "���� ī�װ�",
prior name as "�θ� ī�װ�",
connect_by_root name as "��Ʈ ī�װ�",
connect_by_isleaf,
sys_connect_by_path(name,'��') as "���"
    from tblCategory
    start with pseq is null
        connect by prior seq = pseq
            order siblings by name asc;










































