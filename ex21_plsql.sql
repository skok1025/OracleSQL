--ex21_plsql.sql


create table tblFullname
(
    seq number primary key,
    fullname varchar2(45) not null,
    employee_id number(6) not null references employees(employee_id)
);

create sequence fullnameSeq;

select * from employees;

-- ���ν��� : id > full name ��ȯ

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
    vfullname varchar2(45); -- out �Ķ���Ϳ� ������ ������ ����
begin
    procGetFullname(101,vfullname);
    dbms_output.put_line(vfullname);
    procAddFullname(100,'Steven King');
end;


select * from tblFullname;

-- ���ν��� : fullname insert
create or replace procedure procAddFullname
(
    pid number,
    pfullname varchar2
)
is
begin
    insert into tblFullname(seq,fullname,employee_id) values (fullnameSeq.nextval,pfullname,pid);
end;



-- ���� 2���� ���ν����� �ϳ��� ����
create or replace procedure procInsertName
(
    pid in number
)
is 
    vfullname varchar2(45);
begin
    -- 1.
    procGetFullname(pid,vfullname); -- ��ȯ��
    -- 2.
    procAddFullname(pid,vfullname);
end;


begin
    procInsertName(105);
    procInsertName(110);
    procInsertName(123);
end;

-- ���ν��� ���� ���� : CRUD
select * from tabs;


create table tblAddress
(
    seq number primary key, -- PK
    name varchar2(30) not null, -- �̸�
    age number(3) not null,
    tel varchar2(15) not null,
    address varchar2(500) not null,
    regdate date default sysdate not null -- ��Ͻð�
);

create sequence addressSeq;

-- C : �ּҷ� �߰��ϱ�
create or replace procedure procAddAddress
(
    pname in varchar2,
    page in number,
    ptel in varchar2,
    paddress in varchar2,
    presult out number -- �߰� ���� ���� ���� (1: ����, 0: ����)
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
    procAddAddress('ȫ�浿',20,'010-1234-5678','����� ������ ���ﵿ',vresult);

    if vresult = 1 then 
        dbms_output.put_line('�Է� ����');
    else
        dbms_output.put_line('�Է� ����');
    end if;
end;

select * from tblAddress;

select * from tblAddressBook;


-- R : �б�
-- 1���� seq > ��� ���� ��ȯ
create or replace procedure procReadAddress
(
    pseq in number, -- �˰���� �ּҷ� ��ȣ
    pname out varchar2,
    page out number,
    ptel out varchar2,
    paddress out varchar2,
    pregdate out date,
    presult out number -- ���� ����
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
        dbms_output.put_line('�������� �ʰų� �̹� ������ ��ȣ�� �Է��߽��ϴ�.');
    else
        dbms_output.put_line('����Ŭ ����. �����ڿ��� �����ϼ���.');
    end if;
end;



-- U : �ּҷ� �� 1��(���ڵ�) �����ϱ�
-- ��ȣ(PK)
-- �̸�,����,��ȭ,�ּ�,�����

procUpdateAddress(seq,'ȫ�海');
procUpdateAddress(seq,'����� ������ õȣ��');
procUpdateAddress(seq,'ȫ�海',19);
procUpdateAddress(seq,'010-6866-9202','����� ������ ��ġ��');
--
--update tblAddress set
--    name = ���̸�
--        where seq = ��ȣ
--
--update tblAddress set
--    address = ���ּ�
--        where seq = ��ȣ


procUpdateAddress(1,'ȫ�海',20,'010-1234-5678','����� ������ ���ﵿ');




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
    procUpdateAddress(5,'ȫ�浿','������','010-1234-5678','����� ������ ���ﵿ',vresult);
    
    if vresult = 1 then 
        dbms_output.put_line('���� �Ϸ�');
    elsif vresult = 2 then 
        dbms_output.put_line('�������� �ʰų� �̹� ������ �����Դϴ�.');
    else
        dbms_output.put_line('����Ŭ ����');
    end if;
end;

select * from tblAddress;


-- D : �ּҷ� ���ڵ� ����
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

-- �θ����̺� (pk) <-> �ڽ����̺� (fk + �Ϲ��÷�) : ��ĺ� ����
-- �θ����̺� (pk) <-> �ڽ����̺� (fk + PK �÷�) : �ĺ� ����

-- ȸ�� ���� > ȸ�� ����(�ֿ� ���� + ���� ����)

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


-- ȸ�� ���� ���ν���
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
    --procRegister('hong','1234','ȫ�浿',20,'010-2525-8223','�����');
    procRegister('hong','1234','ȫ�浿',20,'010-2525-82232314325423234343423','�����');
end;

select * from tblMain;
select * from tblSub;


-- ���� ���α׷�
-- 1. ���� ���ν���
-- : PL/SQL ������ ��밡��

-- 2. ���� �Լ�
-- : PL/SQL or ǥ�� SQL ������ ��� ��밡��
-- : ******* ǥ�� SQL ������ �Ϻη� ��밡�� (select, insert, update, delete)
-- : return 1��

-- �Լ�, Function
-- : ���� (1�� �̻�) -> ��ȯ��(1��) ���ν���
-- : out �Ķ���� ��� ���� > return �� ���

-- ���ν���
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

    select height,weight into vheight,vweight from tblName where first = '�缮';

    procAAA(vheight,vweight,vresult);
    dbms_output.put_line(vresult);
    


end;




-- �Լ� ����
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
    
    -- �Լ��� ��� ����
    select fnBBB(height,weight) into vresult from tblName where first = '�缮';
    dbms_output.put_line(vresult);
     
end;


select fnBBB(height,weight)  from tblName where first = '�缮';
select fnBBB(basicpay,sudang) from tblinsa;
select procAAA(basicpay,sudang) from tblinsa;






/*

���ν��� vs �Լ�
1. �Ű�����
    a. ���ν��� : 0~ �������
    b. �Լ� : 1��~�������

2. ��ȯ��
    a. ���ν��� : 0~������� + out �Ķ����
    b. �Լ� : 1�� + return ��
3. �����ġ
    a. ���ν��� : PL/SQL ��
    B. �Լ� : ǥ�� SQL ��
*/

select name,ssn from tblinsa;
select name,fnGender(ssn) from tblinsa;


-- ssn > ����

create or replace function fnGender
(
    pssn varchar2
) return varchar2
is
begin
    case
        when substr(pssn,8,1) = '1' then return '����';
        when substr(pssn,8,1) = '2' then return '����';
        else return null;
    end case;
end;



/*
Ʈ����,Trigger
- ���ν����� ����
- Ư�� ����� �߻��ϸ� �ڵ����� ����Ǵ� ���ν���
- ������ ����(ȣ��) X, DBMS ����(ȣ��) O
- Ư�� ��� : Ư�� ���̺��� ������� ����Ŭ�� �ǽð� ���� (���̺� ����: insert, update, delete) -> �߻�
            -> �̸� �غ��س��� ���ν����� �ڵ����� ȣ���Ѵ�.
            
- �ǽð� ���� : ��� �߻� > �ּ��� �ʿ��� ������...

Ʈ���� ����
create or replace trigger Ʈ���Ÿ�
    -- Ʈ���� ���� �ɼ�
    before|after -- ��� �߻��� | ��
    insert|update|delete -- ��� ����
    on ���̺�� -- ��� ��� ���̺�
    [for each row]
declare
    �����;
begin
    �����;
exception
    ���ܺ�;
end;
*/

drop trigger trgDeleteName;

-- Ư�� ����(��) ���� tblName�� �����͸� ������ �� ���� !!
create or replace trigger trgDeleteName
    before
    delete 
    on tblName
        
begin
    dbms_output.put_line('trgDeleteName ����Ǿ����ϴ�.');

    if to_char(sysdate,'d') = 4 then
        -- ������ ���� �߻�
        -- ����(�����ڵ��ȣ) : -20000 ~ 29990
        raise_application_error(-20000,'�����Ͽ��� tblName�� ������ �� �����ϴ�.');
    end if;

end;


select * from tblName;
delete from tblName where first = '�缮';

drop trigger trgDeleteName;

COMMIT;
rollback;


select * from tblName; -- 12��
select * from tblLog; -- 2��
-- �α� Ʈ����
-- : tblName �� ��ȭ�� ����� ���߿� �����ڰ� ���� ���� �α׸� ���
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
        vmessage := 'tblName ���̺� ���ο� ���ڵ尡 �߰��Ǿ����ϴ�.';
    elsif updating then
        vcode := 'BBB001';
        vmessage := 'tblName ���̺� ���ڵ尡 �����Ǿ����ϴ�.';
    elsif deleting then
        vcode := 'CCC001';
        vmessage := 'tblName ���̺� ���ڵ尡 �����Ǿ����ϴ�.';
    end if;
    
    insert into tblLog(seq,code,message,regdate) values ( logSeq.nextval,vcode,vmessage,default);
    
end;


insert into tblName values('����','��','m',170,60,'����');
update tblName set first = 'ȣȣ' where first = '����' and last = '��';
delete from tblName where first = 'ȣȣ';


select * from tblLog;


/*
[for each row]

1. ����
- ���� ���� Ʈ����
- 1ȸ
- DML �� ���� ����� ���� ������ ������� DML 1ȸ�� Ʈ���� 1ȸ ȣ��

2. ���
- �� ���� Ʈ����
- �ݺ�
- DML �� ���� ����� ���� ������ŭ Ʈ���Ű� ȣ��
- ��� ���� ���� ����
    A. :old
    B. :new

2.1 insert �۾� �߻�
    - Ʈ���ų����� ��� insert �� ���� �÷����� ���� �����ϴ�.
    - :new <- ��� �߰��� ���� �����ϴ� ����
    - :new.�÷��� <- ��� �߰��� ���� Ư�� �÷��� ����
    - :old ��� �Ұ���
    - after Ʈ���ſ����� ����� ������ (before Ʈ���ſ����� ��� �Ұ���)
    
2.2 update �۾� �߻�
    - Ʈ���� ������ ��� ������ ���� �����Ǳ� ���� ���� ������ ���� ���� ���� �����ϴ�.
    - :new <- ��� ������ ���� ���� �����ϴ� ����
    - :old <- ��� ������ ���� ���� �����ϴ� ����
    
2.3 delete �۾� �߻�
    - Ʈ���� ������ ��� ������ ���� ���� ���� ����
    - :old <- ��� ������ ���� �����ϴ� ����
    - :new <- ���Ұ�  
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

insert into tblTodo values (20,'���ο� ����',sysdate,null);


create or replace trigger trgUpdateTodo 
    after
    update
    on tblTodo
    for each row
begin
    dbms_output.put_line(:old.title); -- vrow
    dbms_output.put_line(:new.title); -- vrow

end;

update tblTodo set title = '������ ��ȹ�ϱ�' where seq = 20;


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

-- tblTodo : ������ ��ϵǸ� �ּ��� 3�ϵ����� ������ �Ұ����ϴ�.


create table tblBoard
(
    seq number primary key, -- �۹�ȣ
    subject varchar2(1000) not null, -- ������
    regdate date default sysdate not null -- �۾���¥
);

create table tblComment
(
    seq number primary key, -- ��۹�ȣ (PK)
    subject varchar2(1000) not null, -- ������
    regdate date default sysdate not null, -- �۾���¥
    bseq number not null references tblBoard(seq) -- �θ�۹�ȣ(FK)
);

create sequence boardSeq;
create sequence commentSeq;



-- �Խ��� ���̺� > ���� Ʈ���� > ������ ���� ��ȣ > ��� ���� ����
create or replace trigger trgDeleteBoard
    before
    delete
    on tblBoard
    for each row
begin
    
    delete from tblComment where bseq = :old.seq;
    
end;




select * from tblBoard; -- �Խ���
select * from tblComment; -- ���


insert into tblBoard values(1,'�Խ��� �׽�Ʈ�Դϴ�.',default);
insert into tblBoard values(2,'�ȳ��ϼ���~.',default);

insert into tblComment values (1,'����Դϴ�',default,1);
insert into tblComment values (2,'����Դϴ�',default,1);
insert into tblComment values (3,'����Դϴ�',default,1);

insert into tblComment values (4,'�� �ȳ��ϼ���.',default,2);
insert into tblComment values (5,'�ݰ����ϴ�.~',default,2);


-- ù���� �Խù� �����ϱ�
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

insert into tblUser values('hong','ȫ�浿',default);

select * from tblUser;

drop table tblUser;
insert into tblMemo values (1,'�޸� �׽�Ʈ',default,'hong');
insert into tblMemo values (2,'�޸� �׽�Ʈ',default,'hong');
delete from tblMemo where seq = 2;
insert into tblMemo values (3,'�޸� �׽�Ʈ',default,'hong');
delete from tblMemo where seq  =3;
delete from tblMemo where seq  =4;
insert into tblMemo values (4,'�޸� �׽�Ʈ',default,'hong');


rollback;
-- Ʈ���� ����� : �޸� ���� (+10), �޸� ���� (-5)
-- 1.insert 1�� , delete 1��
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











