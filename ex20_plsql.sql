-- ex20_plsql.sql
/*
PL/SQL
-- Procedural Language Extensions to SQL (+����, ����)
-- ǥ�� SQL : �� ������ ��� (��ɾ�鰣�� ������ ����. ��ɾ�鳢�� ���������� �ʴ�.)
-- ǥ�� SQL + ������ ��� �߰� -> ����Ŭ �߰� SQL -> PL/SQL
-- �߰��� �κ� : �ڹ��� ���α׷��� ��� �߰� (����,���,�޼ҵ�...)
-- ����Ŭ ���� SQL

- ǥ�� SQL <> PL/SQL : ǥ�� SQL �ڷ����� ���� ���� ���״�.
- ǥ�� SQL : ���� ������ �ʼ� X
- PL/SQL : ���� ������ �ʼ� O


SQL ó�� ���� & ����
1. ǥ�� SQL
    : Ŭ���̾�Ʈ ���� �ۼ� (SELECT ��) > ����(CTRL + Enter) > ��Ʈ��ũ�� ���� SQL(���ڿ�) �� DBMS ������ ���� 
        > DBMS ���� ���� > ���� �м� (�Ľ�) > ������ (����������) > ����(��ɾ�) > ���� ���� (CPU) > ���ó�� > ��ȯ
    : ������ �ѹ� �����ߴ� ���Ǹ� �ٽ� ���� (�Ȱ��� sql�� �ٽ� ����) > ���� ������ ó������ ������ ������ �����ϰ� �ݺ�(****)

2. PL/SQL
    : Ŭ���̾�Ʈ ���� �ۼ� (SELECT ��) > ����(CTRL + Enter) > ��Ʈ��ũ�� ���� SQL(���ڿ�) �� DBMS ������ ���� 
        > DBMS ���� ���� > ���� �м� (�Ľ�) > ������ (����������) > ����(��ɾ�) > ���� ���� (CPU) > ���ó�� > ��ȯ
    : ������ �ѹ� �����ߴ� ���Ǹ� �ٽ� ���� (�Ȱ��� sql�� �ٽ� ����) > Ŭ���̾�Ʈ ���� �ۼ� (SELECT ��) 
        > ����(CTRL + Enter) > ��Ʈ��ũ�� ���� SQL(���ڿ�) �� DBMS ������ ���� 
        > DBMS ���� ���� > X > X > X > ���� ������ ����� �ε� > ���� ���� (CPU) > ���ó�� > ��ȯ

���ν���, Procedure
- �Լ�, �޼ҵ�, �����ƾ ��...
- Ư�� ������ ������ ���� ������� �����ϴ� ��ɾ��� ����
1. �͸� ���ν��� : �̸��� ���� > ������ �������� ���� �ʴ´�. ���۹�� ( ǥ�� sql�� ����) > Ȯ�� ��� ������ ���
2. �Ǹ� ���ν��� : �̸��� ���� > ������ �������� �Ѵ�. > ���۹�� ( PL/SQL ����. ����) > ��� ���� + Ȯ�� ���

*/

SELECT * FROM tblInsa;

set serveroutput on;
-- ���ν��� ���� ( �ڵ� �� ) 
begin -- {
    -- ���� ��ɾ� : ǥ�� SQL + PL/SQL
    dbms_output.put_line('Hello');
end; -- }



/*

PL/SQL �� ����

1. 4�� Ű����� ����
a. [declare]
b. begin
c. [exception]
d. end;

2. declare
- �����, declare section
- ���α׷����� ���Ǵ� ����, ��ü ���� �����ϴ� ����
- ���� ����

3. begin
- �����, ������, executable section
- begin ~ end
- ���α׷����� ���� ���� ������� �����ϴ� ����
- ǥ�� SQL + PL/SQL( ����,���� ��...)
- ���� �Ұ���

4. exception
- ���� ó����, exception section
- catch �� ����
- ����ó�� �ڵ带 �����ϴ� ����
- ���� ����

5. end;
- ���� ����
- ���� �Ұ���

6. PL/SQL �� = ����� + ����� + ����ó����

����Ŭ
begin
    begin
    
    end;
end;


declare
    ����, �ڿ� ����
begin
    ������
exception
    ����ó����
end;

�ڷ��� & ����

�ڷ���
- ǥ�� SQL �� ����( ���� ����+ Ȯ�� ) 

���� �����ϱ�
- ������ �ڷ��� [not null][default ��]
- ǥ�� sql���� �÷� �����ϴ� �Ͱ� ����
- ������ ���� : ������ ���(select ��)�� ���ڰ��� �����ϴ� �뵵

������
- ǥ�� sql ����

ǥ�� sql ���� ������
    - �÷��� = ��; // update tblInsa set buseo = '������';
    - �뵵 : �÷��� ����
    
PL/SQL ���� ������
    - ���� := ��;
    - �뵵 : ������ ����

*/

declare
    num number; -- number  :PL/SQL �ڷ���
    name varchar2(30); -- varchar2 : PL/SQL �ڷ���
    today date; -- date : PL/SQL �ڷ���
begin

    num := 10; -- ������ ���ͷ� ( ǥ�� sql ����)
    dbms_output.put_line(num);

    name := 'ȫ�浿';
    DBMS_OUTPUT.PUT_LINE(name);
    
    today := sysdate;
    DBMS_OUTPUT.PUT_LINE(today);
    DBMS_OUTPUT.PUT_LINE(to_char(today,'yyyy-mm-dd'));
    
    today := '2018-09-04';
    DBMS_OUTPUT.PUT_LINE(today);
    
    -- ORA-06502: PL/SQL: numeric or value error: character string buffer too small
    name := 'ȫ�浿�Դϴپȳ��ϼ���';
    DBMS_OUTPUT.PUT_LINE(name);
    
end;



declare
    num1 number;
    -- num2 number not null; -- ��� ������ ������� end; ������ �ݵ�� ���� ������ �Ѵ�.
    num3 number default 100;
    num4 number not null default 300;
    num5 number := 500; -- ����� ( �ʱ�ȭ�� BEGIN ������ �ַ� �Ѵ�.)
    today date := sysdate; -- ����� ( �ʱ�ȭ�� BEGIN ������ �ַ� �Ѵ�.)
begin
    -- ���� �ʱ�ȭ X
    -- �ٷ� ��� : �ʱ�ȭ���� ���� ������ ����� �����ϴ�. ( null ����ä�� ��� ����) 
    DBMS_OUTPUT.PUT_LINE(num1); -- null ���
 
    -- PLS-00218: a variable declared NOT NULL must have an initialization assignment
    --DBMS_OUTPUT.PUT_LINE(num2); 
    
    --num3 := 200;
    DBMS_OUTPUT.PUT_LINE(num3);
    --num4 := 400;
    DBMS_OUTPUT.PUT_LINE(num4); 
    DBMS_OUTPUT.PUT_LINE(num5); 
    
end;


/*
���̺��� ��ȸ�� �����͸� ������ ���
*/
declare
    vbuseo  varchar2(15);
begin
    -- vbuseo := (select buseo from tblinsa where name = 'ȫ�浿');
    
    -- select �� ��� �÷����� ������ ���� > into
    select buseo into vbuseo from tblinsa where name = 'ȫ�浿';
    DBMS_OUTPUT.PUT_LINE(vbuseo);
end;


desc tblInsa;

declare 
    cnt number;
begin
    select count(*) into cnt from tblAddressBook where address like '����Ư����%';
    DBMS_OUTPUT.put_line('����Ư���� �ο���:'||to_char(cnt,'9,999')||'��');
end;



declare
    vbuseo  number;
begin
    -- vbuseo := (select buseo from tblinsa where name = 'ȫ�浿');
    
    -- select �� ��� �÷����� ������ ���� > into
    select buseo into vbuseo from tblinsa where name = 'ȫ�浿';
    DBMS_OUTPUT.PUT_LINE(vbuseo);
end;




declare 
    cnt varchar2(50); -- ����ȯ�� ������ ��Ȳ�̸� �Ͻ������� ���ش�.
begin
    select count(*) into cnt from tblAddressBook where address like '����Ư����%';
    DBMS_OUTPUT.put_line('����Ư���� �ο���:'||to_char(cnt,'9,999')||'��');
end;





declare
    vbuseo  varchar2(100); -- ���̰� �� ū�� �������. (overflow x)
begin
    -- vbuseo := (select buseo from tblinsa where name = 'ȫ�浿');
    
    -- select �� ��� �÷����� ������ ���� > into
    select buseo into vbuseo from tblinsa where name = 'ȫ�浿';
    DBMS_OUTPUT.PUT_LINE(vbuseo);
end;



declare
    vbuseo  varchar2(6); -- ��������� ũ�Ⱑ ������ ���� �߻�
begin
    -- vbuseo := (select buseo from tblinsa where name = 'ȫ�浿');
    -- select �� ��� �÷����� ������ ���� > into
    select buseo into vbuseo from tblinsa where name = 'ȫ�浿';
    DBMS_OUTPUT.PUT_LINE(vbuseo);
end;



declare
    vpop  number; -- ��������� ũ�Ⱑ ������ ���� �߻�
begin
    -- vbuseo := (select buseo from tblinsa where name = 'ȫ�浿');
    -- select �� ��� �÷����� ������ ���� > into
    select population into vpop from tblCountry where name = '���ѹα�';
    DBMS_OUTPUT.PUT_LINE(vpop);
end;




declare
    --vpop  number; -- ��������� ũ�Ⱑ ������ ���� �߻�
    --vpop  number not null;
    vpop number default 0;
begin
    -- vpop := null
    select 
     nvl(population,0) into vpop 
    from tblCountry where name = '�ɳ�';
    DBMS_OUTPUT.PUT_LINE(vpop);
end;

-- ���� ����
-- ������ ����� ���ϰ��̾�� �Ѵ�.
-- : ���� �÷� + ���� �� 
-- : PK ���� + ���� �÷� : select �����
-- : �����Լ��� �����



-- ��ȯ�Ǵ� �÷��� ������ ������
-- : N ���� ��ȯ�� > 

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
        (select count(*) from tblinsa where buseo = i.buseo and jikwi <> '����')
    into 
        vbuseo,
        vjikwi,
        vbasicpay,
        vtotal,
        vcount
    from tblinsa i where name = 'ȫ�浿';
    
    DBMS_OUTPUT.put_line('�μ�: '|| vbuseo ||', ����:'||vjikwi || ', �޿�:'||vbasicpay);
    DBMS_OUTPUT.PUT_LINE('�ѱ޿�:'|| vtotal);
    DBMS_OUTPUT.PUT_LINE(vbuseo||'�� ����������:'|| vcount);
end;


desc tblInsa;


/*
������
- ����(�÷�)�� �ڷ����� �����ؼ� ������ �ڷ������� ����� �� �ִ�.
- ����(�÷�)�� �ڷ����� ���� �ȴ�.
- �������� ����

1.%type
- ��� �÷��� �ڷ����� ���̸� �����ؼ� �ش� ������ �����ϰڽ��ϴ�.
- ����Ǵ� �׸�
    a. �ڷ���
    b. ����
    c. not null
    
2. %rowtype
- ���̺� ���ڵ� ������ �����ؼ� �ش� ������ �����ϰڽ��ϴ�.
- %type �� ����

*/

declare
  vname tblInsa.name%type; -- vname varchar2(20) not null  
  vbuseo tblinsa.buseo%type;
  vbasicpay tblinsa.basicpay%type;
begin
select name,buseo,basicpay into vname,vbuseo, vbasicpay from tblinsa 
    where (basicpay+sudang) = (select min(basicpay+sudang) from tblinsa); -- �ɽ���
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
    dbms_output.put_line('���� Ű ū ���:'||vlast||vfirst||'-'||vheight);
    
    select first,last,height into vfirst,vlast,vheight from tblname
        where height =(select min(height) from tblname);
    dbms_output.put_line('���� Ű ���� ���:'||vlast||vfirst||'-'||vheight);
    
    select first,last,weight into vfirst,vlast,vweight from tblname
        where weight =(select max(weight) from tblname);
    dbms_output.put_line('���� �׶��� ���:'||vlast||vfirst||'-'||vweight);
    
    select first,last,weight into vfirst,vlast,vweight from tblname
        where weight =(select min(weight) from tblname);
    dbms_output.put_line('���� ���� ���:'||vlast||vfirst||'-'||vweight);
    
end;



declare
begin
    -- ȫ�浿�� ����ģ�� > �ٶ� > ������
    --select * from tblMen;
    --select * from tblWomen;
    
    -- 1.
    select couple from tblMen where name = 'ȫ�浿';
    -- 2.
    update tblWomen set couple = '������' where name = '�嵵��';
    -- 3.
    update tblMen set couple = '�嵵��' where name = '������';
     --4.
    update tblMen set couple = null where name =oldMan;
    
    dbms_output.put_line('�Ϸ�');
    
end;


commit; --������
ROLLBACK; --����ó��

select * from tblWomen;
select * from tblMen;

--tblInsa. ���� �� �Ϻο��Ը� ���ʽ� ����. ���� ������ ������ ����
create table tblBonus
(
    seq number primary key, --�Ϸ� ��ȣ(PK)
    iseq number references tblInsa(num) not null, --���� ��ȣ(FK)
    bonus number not null
);

create sequence bonusSeq;


declare
    vnum tblInsa.num%type;
    vsudang tblinsa.sudang%type;
begin

    --1.
    select num,sudang into vnum,vsudang from tblInsa 
        where city = '����' and jikwi = '����' and to_char(ibsadate,'yyyy') <= 1995;

    --dbms_output.put_line(vnum);
    --dbms_output.put_line(vsudang);

    --2.
    insert into tblBonus (seq,iseq,bonus) values (bonusSeq.nextval,vnum,vsudang * 3);
end;


select b.*,
    (select name from tblinsa where num = b.iseq), -- ���μ�
    (select city from tblinsa where num = b.iseq),
    (select jikwi from tblinsa where num = b.iseq),
    (select to_char(ibsadate,'yyyy') from tblinsa where num = b.iseq),
    (select sudang from tblinsa where num = b.iseq)
from tblBonus b;


-- tblTodo. ���� ���� ���� �Ϸ���� ���� ��Ͽ��� �����ϱ�
select * from tblTodo;

-- ��������
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

-- PL/SQL �� ����
-- �ڷ��� + ���� ����
-- ������ �ڷ��� > ���̺� + �÷� ������
-- SELECT ��� > ���ϰ� ��������
-- SELECT ��� > ���Ϸ��ڵ� + ���� �÷��� ��������
-- �������� SELECT, UPDATE, DELETE, INSERT � ����ϱ�


declare
    -- �ڷ����� ����(good) + �÷� ������ ����. (bad)
--    vfirst tblname.first%type;
--    vlast tblname.last%type;
--    vgender tblname.gender%type;
--    vheight tblname.height%type;
--    vweight tblname.weight%type;
--    vnick tblname.nick%type;
      vrow tblname%rowtype; -- �÷��� ����
begin
--    select first,last,gender,height,weight,nick into
--            vfirst,vlast,vgender,vheight,vweight,vnick 
--            from tblname where last = '��' and first = '�缮';
--    select * into
--            vfirst,vlast,vgender,vheight,vweight,vnick 
--            from tblname where last = '��' and first = '�缮';
    select * into
            vrow 
            from tblname where last = '��' and first = '�缮';

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
    vrow tblInsa%rowtype;--10���� �÷��� ���� ���ڵ� ���� ����(�κ� �÷� ���� �Ұ���)
    vnum tblInsa.num%type; -- �÷� ����
begin
    vnum :=1010;
    
    --select 10�� �÷� into 10�� ���� from tblInsa where num = vnum;
    --select * into vrow from tblInsa where num =vnum;
    select name,buseo,city into vrow from tblInsa where num =vnum;
    
    dbms_output.put_line(vrow.name);
    dbms_output.put_line(vrow.buseo);
    dbms_output.put_line(vrow.city);
end;


commit;
rollback;
-- tblMen -> 1��(����) -> tblWomen : �ű��
select * from tblMen;
select * from tblWomen;

declare
    vrow tblMen%rowtype;
begin
    
    -- 1.'����'�� ��� ���� �������� (select)
    select * into vrow from tblMen where name = '����';
    
    --dbms_output.put_line(vrow.name);
    -- 2. 1���� ��� ������ tblWomen �� �߰��ϱ� (insert)
    insert into tblWomen(name,age,height,weight,couple)
        values (vrow.name,vrow.height,vrow.weight,vrow.couple);
    
    -- 3. tblMen ���� '����' ���� �����ϱ�(delete)
    delete from tblMen where name = '����';
    
end;


commit;
rollback;




/*
PL/SQL ���
- ���ͷ�
- �ڹ� : public static final double PI = 3.14;
- ������ �ڷ��� [not null][default]
- ����� constant �ڷ��� [not null][default]
*/

declare
    num1 number := 100;
    NUM2 constant number := 200; -- ***
    --NUM3 constant number; -- PLS-00322: declaration of a constant 'NUM3' must contain an initialization assignment
    NUM4 constant number default 400; -- default ���� ����� �ʱⰪ���� ���
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


-- ���
-- ���ǹ� : if ��

set serveroutput on;

declare
    vnum number;
begin
    vnum := -10;
    
    if vnum > 0 then -- {
        dbms_output.put_line('���');
    end if; -- }
    
    if vnum > 0 then 
        dbms_output.put_line('���');
    else
        dbms_output.put_line('����ƴ�');
    end if;

    if vnum > 0 then
        dbms_output.put_line('���');
    elsif vnum < 0 then
        dbms_output.put_line('����');
    else
        dbms_output.put_line('zero');
    end if;
    
end;


-- Ŀ�� ���� -> ���� ���̰� ���� ���� Ŀ�� -> ���� ����? ���� ����?
select * from tblMen;
select * from tblWomen;

-- ���� ���̰� ���� ���� Ŀ��
select 
    case 
        when m.age - w.age>0 then '���� ����'
        when w.age - m.age>0 then '���� ����'
    else '����'
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
        dbms_output.put_line('���ڰ� �����Դϴ�.');
    elsif wage > mage then
        dbms_output.put_line('���ڰ� �����Դϴ�.');
    else
        dbms_output.put_line('�������� �Դϴ�.');
    
    end if;

end;


-- ���� �ð��� Ȧ�� ���̸� ���缮�� ������ +1kg ����, ¦�� ���̸� ����� �����Ը� +1kg ����

begin

    if mod(to_char(sysdate,'ss'),2) = 0 then
         dbms_output.put_line('¦��');
         update tblWomen set weight = weight + 1 where name = '�ڳ���';
    else
         dbms_output.put_line('Ȧ��');
         update tblMen set weight = weight + 1 where name = 'ȫ�浿';
    end if;

end;


select * from tblMen;
select * from tblWomen;


select * from tblBonus;

-- ���� ��ȣ -> ����,����(���� 3��), �븮,���(���� 2��)

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
    if vjikwi in ('����','����') then 
        dbms_output.put_line('���� 3�� ����');
        --insert into tblBonus (seq,iseq,bonus,sudang) values (bonusSeq,nextval,vnum,vsudang*3);
        vsudang := vsudang * 3;
    else
        dbms_output.put_line('���� 2�� ����');
        --insert into tblBonus (seq,iseq,bonus,sudang) values (bonusSeq,nextval,vnum,vsudang*2);
        vsudang := vsudang * 2;
    end if;

    insert into tblBonus (seq,iseq,bonus) values (bonusSeq.nextval,vnum,vsudang);
    
end;

select * from tblBonus;


-- case ��
-- �ڹ� : switch case ��
-- ǥ�� SQL �� case�� ����

declare
    vcontinent tblcountry.continent%type;
    vresult varchar2(30);
begin

    -- ���ѹα��� ��� ����� ���ϴ���?
    select continent into vcontinent from tblCountry where name = '���ѹα�';
    
    if vcontinent = 'AS' then
        vresult := '�ƽþ�';
    elsif vcontinent = 'EU' then
        vresult := '����';
    elsif vcontinent = 'AF' then
        vresult := '������ī';
    end if;
    
    dbms_output.put_line(vresult);
    
    case 
        when vcontinent = 'AS' then vresult := '�ƽþ�';
        when vcontinent = 'EU' then vresult := '����';
        when vcontinent = 'AF' then vresult := '������ī';
        else vresult := '��Ÿ';
    end case;

    dbms_output.put_line(vresult);

end;




/*
�ݺ���

1. loop
- ���� �ݺ�

2. for loop
- ���� Ƚ�� �ݺ� (�ڹ� for �� ����)

3. while loop
- ���� �ݺ�(�ڹ� while�� ����)

*/

-- loop

-- ���� ���� & �ٸ� ������ �⺻ ���

begin

    loop
        dbms_output.put_line('���� �ð�:'||sysdate);
        --exit;
        --exit when ����;
        exit when to_char(sysdate,'ss')>30;
    end loop;

end;

-- ��� ��ȣ 1001 ~ 1060 : 10 ���� ����
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
-- : �������� ���� ������ �����Ѵ�.

begin
    -- ���������� ���� �������� �ʴ´�.
    -- i: ��������
    -- ���� in ����
    -- 1  : �ʱ갪
    -- .. : ���� ����
    -- 10 : �ִ�
    -- reverse : ���� Ű����
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


-- ������ ���̺�
create table tblGugudan
(
    --seq number primary key
    dan number not null,-- primary key, -- 2,2...
    num number not null,-- primary key, -- 1,2...
    result number not null, -- 2,4...
    
    -- ����Ű
    -- : 2���̻��� �÷��� �𿩼� �⺻Ű ����
    -- : �÷� �������� ������ �Ұ���, ���̺� �������� ���� ����
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



truncate table tblGugudan; -- commit ����

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
select ���� ���ؼ� ������ �����͸� PL/SQL ������ �ִ� ���

1. select into ���
    - ������� ���ڵ� 1���϶��� �����ϴ�.
2. Ŀ��(cursor) ���
    - ������� ���ڵ尡 1�� �̻��� �� �����ϴ�.
    
Ŀ�� ����

declare
    ��������;
    Ŀ������;
begin
    Ŀ������;
    loop
        Ŀ���� ����ؼ� ������ ����;
    end loop;
    Ŀ���ݱ�;
end;
*/

-- select ������ ��������
-- 1. select into
--  a. �����÷� + ������
--  b. �����÷� + ������

-- 2. cursor
--  a. �����÷� + ������
--  b. �����÷� + ������



-- tblinsa. ������ x 60��
declare
    vname tblinsa.name%type; -- �Ѹ��Ѹ��� �̸��� ������ ����
    cursor vcursor
    is 
    select name from tblInsa order by name asc; -- ���� select �� ���� �� (���� O, ����x)
begin

    open vcursor; -- Ŀ�� ���� (select �� ����)
        loop
            
            -- ���������� ���ڵ� �ϳ��ϳ��� Ŀ���� ����ؼ� ����
            fetch vcursor into vname;
            
            -- Ŀ�� ���� �Ӽ�
            exit when vcursor%notfound; -- ���� ���ڵ尡 �����ϸ� false �������� ������ true
            
            dbms_output.put_line(vname);            
    
    
        end loop;
    
    close vcursor; -- Ŀ�� �ݱ�

end;


select * from tblBonus;

truncate table tblBonus;

delete from tblinsa where city = '����';





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

-- ���� �÷� + ���� ���ڵ�
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
        
        -- ����
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
        
        -- ����
        dbms_output.put_line(vrow.name || ',' || vrow.buseo || ',' || vrow.city);
        
    end loop;
    close vcursor;
end;


/*
cursor ���� (FM)
- Ŀ��  + loop
: Ŀ�� ��ü ���� (select ��) > Ŀ������(select ����) > ���� > ������ ����(fetch) +���(����) > Ŀ�� �ݱ�

cursor ���� (����)
- Ŀ�� + for loop
:Ŀ�� ó���� �ܼ�����

*/


declare 
    --vrow : ���� ���� > ���� ������ �����
    cursor vcursor is
        select * from tblinsa;
begin
    --open vcursor; : ����
    for vrow in vcursor loop  -- loop + fetch into
        dbms_output.put_line(vrow.name);
    end loop;
    --close vcursor; : ����
end;


-- Ŀ�� �� ��(�Ǹ��, �ζ��κ�)
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
- ����ó����
*/
declare
    vname number;
begin
    dbms_output.put_line('����');
    select name into vname from tblinsa where num = 1001;
    dbms_output.put_line('��');
    
exception
    when others then -- catch(Exception e)
        dbms_output.put_line('���� ó��');
end;


-- ���� �߻� ���(�α� ���̺�)
create table tblLog
(
    seq number primary key, -- PK
    code varchar2(20) check (code in('AAA0001','BBB001','CCC001')) not null, -- ���� ���� �ĺ���
    message varchar2(1000) null, -- ���¸޼���
    regdate date default sysdate not null -- �߻��ð�
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
        dbms_output.put_line('tblName ���̺� �����Ͱ� �����ϴ�.');
        insert into tblLog values (LOGSEQ.nextval,'AAA0001','��븮 ���',default);
    
    when too_many_rows then 
        dbms_output.put_line('������ ������ �ʹ� �����ϴ�.');
        insert into tblLog values (LOGSEQ.nextval,'BBB001',NULL,default);

    when others then 
        dbms_output.put_line('���� �߻�');
        insert into tblLog values (LOGSEQ.nextval,'CCC001',NULL,default);

end;

select * from tblLog;

-- PL/SQL ���� Ʈ����� ó��
-- : �Ϲ������� PL/SQL�� �� ��ü�� �ϳ��� Ʈ����� ����
-- : �Ϲ������� �Ǹ� PL/SQL �� ���� �� �ַ� Ʈ����� ó���� ����.

select  * from tblMen; -- ȫ�浿 : �嵵��
select * from tblWomen; -- �嵵�� : ȫ�浿

commit;
rollback;

begin
    --1.
    update tblMen set couple = null where name = 'ȫ�浿'; -- ����
    --2.
    update tblWomen set couple = '����������������������' where name = '�嵵��'; -- ����
    
    commit;
exception
    when other then
            rollback;
end;



/*
PL/SQL �� > �̸� ���̱� > ���� ����Ŭ ������ ����(��ü) > ���� �� > ���� ���α׷� > Stored Procedure

���� ���ν���
- �̸��� ���� PL/SQL ��
- ���� �� 1���� ���� ���ν��� ���� > ����Ŭ ���� ���� > ������ ������ ���� ���� ( ���ٱ����� ���� ��� )
- ���� ���(���� �м� ~ ������ ���� ����)
- ��Ʈ��ũ Ʈ���� ���� (�ڵ� ��ü ���� -> ���α׷� �̸��� ����)
- ���� ������ ������ �ڵ带 ��� ���� + ���� �ο� ����

���� ���α׷� ����
1. ���� ���ν���. Stored Procedure
    - ��� SQL ��� �뵵
    - �Ű����� ����
    - ��ȯ�� ����
    - �ڹ� : �޼ҵ�
    - ǥ�� SQL���� ����� �Ұ����ϴ�.
    
2. ���� �Լ�. Stored Function
    - �ַ� SELECT �뵵
    - �ݵ�� �Ű������� ������.
    - �ݵ�� ��ȯ���� ������.(��ȯ���� ���ϰ�) : �ڹ� �޼ҵ� return��
    - ǥ�� SQL ���� ����� �����ϴ�. (***)


���� ���ν��� ����

create [or replace] procedure ���ν�����
is[as]
    [�����;]
begin
    �����;
[exception
    ����ó����;]
end [���ν�����];

*/

-- ���ν��� ����
create or replace procedure procTest
is -- �͸� ���� declare ����
    vnum number;
begin
    vnum := 100;
    dbms_output.put_line(vnum);
end procTest;

-- ���ν��� ȣ��
-- 1. PL/SQL �� ������ ȣ�� (******)
-- ���α׷��� ���
-- �͸� �� or �ٸ� ���ν��� ȣ��
-- �ַ� ���Ǵ� ���

-- 2. ��ũ��Ʈ ȯ�濡�� ȣ�� (ANSI-SQL ȯ��)
-- ������, �����
-- execute, call ��ɾ� ���

-- 2��ȯ�� (ANSI SQL)

begin -- 1��ȯ��
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


-- �Ű������� �ִ� ���ν���
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
    procTest('�簢��A',100,200);
end;






create or replace procedure procTest
(   pname varchar2, -- �Ű������� ���� ��� X
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
    procTest('�簢��A',100,200);
    procTest('�簢��A',100);
    procTest('�簢��A');
    --procTest('�簢��A',null,100); -- ���� null
    --procTest('�簢��A',default,100); -- ����
end;



/*
�Ű������� �۵�(����) ���
- �Ű������� �����ϴ� ���

1. in ��� : �⺻
2. out ��� 
3. in out ��� : ��� x

*/

create or replace procedure procSum
(
    pnum1 in number, -- in �Ķ����
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
    pnum1 in number, -- in �Ķ����
    pnum2 in number,
    presult out number, -- out �Ķ����, ��ȯ�� ����
    presult2 out number, -- out �Ķ����
    presult3 out varchar2
)
is
begin
    presult := pnum1 + pnum2;
    presult2 := pnum1 - pnum2;
    if pnum1 > pnum2 then
        presult3 := 'ũ��';
    else
        presult3 := '�۴�';
    end if;
    
end;





declare
    vresult number;
    vresult2 number;
    vresult3 varchar2(20);
begin
    --���� = procSum(10,20); // �� ��� ���Ұ� (����� �޼ҵ��� ��ȯ������ �ٸ���.)
    procSum(10,20,vresult,vresult2,vresult3);
    dbms_output.put_line(vresult);
    dbms_output.put_line(vresult2);
    dbms_output.put_line(vresult3);
end;



-- �˻�, �߰�, ���� ��...

-- ���� ����ϱ�
-- 1. ���� ��ȣ > ���
-- 2. ������(����) > ���
create or replace procedure procDelInsa
(
    pnum in number                           
)
is 
begin
    delete from tblInsa where num = pnum;
    insert into tblLog(seq, code, message, regdate) values (logSeq.nextval,'AAA0001','ȫ�浿 ���',default);
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


-- �� �� �߰��ϱ� ���ν���
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
    procAddTodo('����Ŭ ���ν��� �����ϱ�');
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
    procAddName('�̱���','m',190,70,'�⸰');
end;


select * from tblName;

rollback;












