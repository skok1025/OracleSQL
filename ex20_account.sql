--ex20_account.sql
/*
����� ���� sql
-DCL�� �� �κ�
- ���� ���� + ����
- ���ҽ� ���� ���� ����

����� ���� �����ϱ� 
- �ý��� ������ ������ �ִ� ������ �����ϴ�.


*/

-- �� ���� �����ϱ�
-- create user ������ identified by ��ȣ; // ���� ���� + ��ȣ ����
-- alter user ������ identified by ��ȣ; // ��ȣ ����
-- drop user ������; // ���� ����

-- ������Ʈ �뵵 > ����(��Ű��) ���� > �۾� ������ ������ ����


-- hr 
 create user team identified by java1234;

-- system
show user;
create user team identified by java1234;


-- ���� ���� �����ϱ�
-- ����(privileges) �ο��ϱ� (�Ҵ��ϱ�)
-- grant ���� to ������;
grant create session to team; -- team �������� ������ ������ �� �ִ� ���� �ο� > ���� ����
grant create table to team; -- team �������� ���̺� ���� ���� (���� + ���� ����)
grant create view to team;
grant create sequence to team;

-- ��(Role) �����ϱ�
-- ������ ����
-- 1. connect 
-- : ����� DB ���� ����
-- 2. resource
-- : ����ڰ� ��ü�� ������ �� �ִ� ���� ����
-- 3. DBA
-- :�����ڱ� ���� ���� ����
grant resource to team;

------------------------------------------------------------------------------------------------

-- team
show user;
select * from tabs;

create table tblTeam
(
    seq number primary key,
    data varchar2(100) not null
);



-- ���� �߰��ϱ�(�Ϲݰ���)
-- 1. ���� ����
create user user1 identified by java1234;

-- 2. ���� �ο� > Role ���
grant connect to user1;
grant resource to user1;
grant create view to user1;

-- �� �� Role ���
select * from DBA_ROLES;

-- Ư�� Role �� � ������ �ִ��� ? 
select grantee,privilege
    from dba_sys_privs
        where grantee = 'DBA';


-- ��ü ���� �����ϱ� 
-- : ���̺�, ��, ������ � ���ؼ� ��ü���� DML �� ����� �� �ִ� ���� ����
-- : GRANT ���� ON ��� TO ����;

-- SYSTEM, hr
grant select 
    on hr.tblInsa
        to team;
        
grant delete 
    on hr.tblInsa
        to team;

-- team 
select * from tabs;
select * from team.tblInsa;
select * from hr.tblInsa; -- �ٸ� ������ �ڿ��� �ݵ�� �Ҽ� (������, ��Ű����) �� ����ؾ� �Ѵ�.
delete from hr.tblInsa where num = 1001;

select * from hr.tblname;
rollback;

-- ���� ����
-- : revoke ���� on ��� from ����;
revoke delete 
    on hr.tblInsa
        from team;

revoke create session from team;


-- DB ������Ʈ > �� ���� > ���� �ο� (connect, resource , create view)

drop user team cascade;

-- tblGenre : tblRent > tblVideo > tblGenre
drop table tblGenre;
drop table tblGenre cascade constraints; -- ������ ���� (������ ����)

select * from tblGenre;
select * from tblVideo;












