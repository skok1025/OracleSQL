--ex19_index.sql
/*
�ε���, index
- ����
- �˻��� ���� �ӵ��� �ϱ� ���ؼ� ����ϴ� ����
- ����Ŭ�� ���̺� ���� �� �ε����� ���� �������� �ʾƵ� �ڵ����� �����ȴ�. -> pk, unique �÷� �ڵ����� ���� ���� 
    -> num �÷� �˻��ӵ� (PK > Index ����) >>>>> name �÷� �˻� �ӵ�

*/

select * from tblinsa where num = 1001;
select * from tblinsa where name = 'ȫ�浿';


select count(*) from tblAddressBook;

create table tblIndex
as
select * from tblAddressBook;

select count(*) from tblIndex;

insert into tblIndex
    select * from tblInd��ex;
    
commit;    
    
select * from tblIndex where rownum<10;

select * from tblindex where name = '������';

-- name �÷��� �ε��� �����ϱ�
create index idxIndexName
    on tblIndex(name);

select * from tblindex where name = '������';








/*
�ε��� ��,����
- �˻� ó�� �ӵ��� ��� ��Ų��.
- ����� ��δ�.

�ε��� ����ؾ� �ϴ� ���
1. ���̺� ���� ������ ���� ���
2. �ε����� ������ �÷��� where ���� ���� ���Ǵ� ��� (****)
3. join�� �� ����ϴ� �÷� (on �θ����̺�.PK = �ڽ����̺�.FK) (****)
4. �˻� ����� ���� ���̺� ������ 2~4%�� �ش��ϴ� ��� (****)
5. �ش� �÷��� NULL �� �����ϴ� ��� (���ο� NULL ����)

�ε��� ����ϸ� �� ���� ���
1.���̺��� ���� ������ ���� ���
2. �˻������ ���� ���̺� ���� ������ �����ϴ� ���
3. ���� ���̺��� ����,����,������ ����� ��� (****)

*/

select * from tbladdressbook;

-- ����� �ε���
-- �ε����� �ɸ� �÷� > job > �ߺ��� ����
CREATE INDEX idxIndexJob 
    on tblIndex(job);

-- ���� �ε���
-- �ε��� �ɸ� �÷� > seq > PK, Unique
create index idxIndexSeq
    on tblIndex(seq);
    
-- ���� �ε���
-- �ε��� �� �÷��� 1���϶�...
create index idxIndexEmail
    on tblIndex(email)

select * from tbindex where email = 'without_carry@live.com'; -- idxIndexEmail ���� O
select * from tbindex where email = 'without_carry@live.com' and age =16; -- idxIndexEmail ���� X
select * from tblindex where substr(name,1,1) ='��'; -- idxIndexName ���� X , idxIndexLastName ���� O

create index idxIndexLastName
    on tblIndex(substr(name,1,1));

select * from tblindex where name = '��浿'; -- idxIndexName ���� O 
    
select * from tblindex where (height+weight)>200;

create index idxIndexBMI
    on tblIndex((height+weight))

-- ����(����) �ε���
create index idxIndexEmailAge
    on tblIndex(email,age);

-- �ϳ��� ���̺� : �������� �ε���




-- ����Ŭ�� Ű������ ��/�ҹ��ڸ� �������� �ʴ´�. (SQL Ư¡)

select * from tblname;
SELECT * FROM tblname;







































