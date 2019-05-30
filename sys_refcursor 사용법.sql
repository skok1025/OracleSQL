set serveroutput on;

create or replace procedure proc_mybatis_list(
    presult out sys_refcursor
)
is
begin
    open presult for
        select seq,name,age from tblMyBatis;
end;

declare
    vcursor SYS_REFCURSOR;
    vseq NUMBER;
    vname tblMyBatis.name%type;
    vage tblMyBatis.age%type;
begin
    proc_mybatis_list(vcursor);
    
    loop
        fetch vcursor into vseq,vname,vage;
        exit when vcursor%notfound;
        dbms_output.put_line(vseq||' '||vname||' '||vage);
    end loop;
end;
    