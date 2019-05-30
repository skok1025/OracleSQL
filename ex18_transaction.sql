-- ex18_transaction.sql

/*

Ʈ�����, Transaction
- ����Ŭ(DBMS)���� �߻��ϴ� 1���̻��� ��ɾ���� �ϳ��� �� �������� ������� ���� -> ���� (����)
- Ʈ����ǿ� ���ؼ� �����Ǵ� ��ɾ� : DML �� ���� (insert,update,delete). �����Ϳ� ������ ���ϴ� ��ɾ�.

Ʈ����� ����
- DCL �� ����
1. commit
2. rollback
3. savepoint

Ʈ������� ����
- �ϳ��� Ʈ��������� �����ִ� ��� ��ɾ ��� > ��� ��ɾ �����ϸ� Ʈ����� ����, �Ϻ� ��ɾ �����ϸ� Ʈ����� ����


1.�� Ʈ������� �����ϴ� ���
    a. Ŭ���̾�Ʈ�� ������ ����
    b. commit��ɾ ������ ����
    c. rollback��ɾ ������ ����
    d. ddl,dcl ��ɾ ������ ���� (commit �� �ǵ��� �ִ�)
    
2.���� Ʈ������� �����ϴ� ���
    a. Ŭ���̾�Ʈ�� ������ ������ ����
    b. commit��ɾ ������ ����
    c. rollback��ɾ ������ ����
    d. ddl,dcl ��ɾ ������ ����(Auto Commit)
    
c. �ڵ� Ŀ�� (Auto Commit)
    --ddl,dcl ��ɾ ���ؼ� ���� Ʈ������� ����Ǵ� ����
    -- ����!
    
d. Auto Commit
    - Tool �� �ڵ� Ŀ�� ���
    - ��� insert,update,delete �� ���� ������ ������ commit �ٷ� �̾ ����
    - rollback �Ұ���
*/

drop table �����;

create table �����
as
select * from tblinsa where city ='����';

select * from �����;

delete from ����� where name = 'ȫ�浿';

COMMIT; -- Ʈ����� �Ϸ�, �����ͺ��̽� ������ �ݿ�

delete from ����� where name = '������';
update ����� set jikwi = '�븮' where name ='������';


ROLLBACK;

--commit �� �ǵ�
create table testT
(
    seq number primary key
);



delete from ����� where name = '�迵��';
savepoint A;

delete from ����� where name = '�����';
SAVEPOINT B;

delete from ����� where name = '�踻��';


rollback; -- Ʈ����� ���
ROLLBACK to A; 








-- ó�� : commit, rollback
-- ���� : savepoint

commit; 














