--ex20_account.sql
/*
사용자 관련 sql
-DCL의 한 부분
- 계정 생성 + 삭제
- 리소스 접근 권한 제어

사용자 계정 생성하기 
- 시스템 권한을 가지고 있는 계정만 가능하다.


*/

-- 새 계정 생성하기
-- create user 계정명 identified by 암호; // 계정 생성 + 암호 지정
-- alter user 계정명 identified by 암호; // 암호 수정
-- drop user 계정명; // 계정 삭제

-- 프로젝트 용도 > 계정(스키마) 생성 > 작업 공간이 별도로 생성


-- hr 
 create user team identified by java1234;

-- system
show user;
create user team identified by java1234;


-- 각종 권한 관리하기
-- 권한(privileges) 부여하기 (할당하기)
-- grant 권한 to 유저명;
grant create session to team; -- team 계정에게 세션을 생성할 수 있는 권한 부여 > 접속 권한
grant create table to team; -- team 계정에게 테이블 생성 권한 (수정 + 삭제 포함)
grant create view to team;
grant create sequence to team;

-- 롤(Role) 관리하기
-- 권한의 집합
-- 1. connect 
-- : 사용자 DB 접속 권한
-- 2. resource
-- : 사용자가 객체를 조작할 수 있는 권한 모음
-- 3. DBA
-- :관리자급 계정 권한 모음
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



-- 계정 추가하기(일반계정)
-- 1. 계졍 생성
create user user1 identified by java1234;

-- 2. 권한 부여 > Role 사용
grant connect to user1;
grant resource to user1;
grant create view to user1;

-- 각 종 Role 목록
select * from DBA_ROLES;

-- 특정 Role 이 어떤 권한이 있는지 ? 
select grantee,privilege
    from dba_sys_privs
        where grantee = 'DBA';


-- 객체 권한 관리하기 
-- : 테이블, 뷰, 시퀀스 등에 대해서 객체별로 DML 을 사용할 수 있는 권한 제어
-- : GRANT 권한 ON 대상 TO 유저;

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
select * from hr.tblInsa; -- 다른 계정의 자원은 반드시 소속 (계정명, 스키마명) 을 명시해야 한다.
delete from hr.tblInsa where num = 1001;

select * from hr.tblname;
rollback;

-- 권한 뺏기
-- : revoke 권한 on 대상 from 유저;
revoke delete 
    on hr.tblInsa
        from team;

revoke create session from team;


-- DB 프로젝트 > 팀 계정 > 권한 부여 (connect, resource , create view)

drop user team cascade;

-- tblGenre : tblRent > tblVideo > tblGenre
drop table tblGenre;
drop table tblGenre cascade constraints; -- 억지로 삭제 (굉장히 위험)

select * from tblGenre;
select * from tblVideo;












