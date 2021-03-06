-- ex17_union.sql

/*
union
-砺戚鷺聖 杯帖澗 奄綬
- 曽

join
-砺戚鷺聖 杯帖澗 奄綬
- 半

*/

create table 引舌
as
select * from tblinsa where jikwi = '引舌';

create table 採舌
as
select * from tblinsa where jikwi = '採舌'; 


select * from 引舌; --8
select * from 採舌; --5

-- union:姥繕亜 旭精 2鯵 戚雌 砺戚鷺聖 馬蟹稽 杯庁陥
select * from 引舌
union
select * from 採舌; -- 8+5

select name,ssn from 引舌
union
select name,basicpay from 採舌;

-- 姥繕亜 疑析馬陥壱 背亀 union聖 馬檎 照吉陥. (***) > 姥繕人 税耕亜 乞砧 旭焼醤 亜管!!!
select name,sudang from 引舌
union
select name,basicpay from 採舌;

-- 砧 実税 鎮軍 呪亀 疑析背醤 廃陥.
select name,basicpay,ssn from 引舌
union
select name,basicpay,null from 採舌;


-- 食君 砺戚鷺聖 1鯵税 砺戚鷺稽 昼杯(***)馬澗 遂亀
select name from tblCustomer
union
select name from tblMember
union
select last||first as name from tblname
union
select name from tblStaff;


-- 噺紫(採辞紺 惟獣毒)
-- 1. 惟獣毒 砺戚鷺 1鯵幻 姥失
--    :惟獣弘税 採辞研 姥歳馬澗 鎮軍 持失 & 紫遂 
--    : 穣巷掻 乞窮 惟獣弘聖 羨悦馬澗 穣巷亜 朔腰拝 凶

-- 2. 惟獣毒 砺戚鷺 採辞紺 姥失
--    : 採辞紺稽 紺亀税 砺戚鷺 持失
--    : 舵鯵辞 瑳 穣巷亜 弦壱, 杯団辞 瑳 穣巷亜 旋聖 凶

-- 慎穣採, 恥巷採, 奄塙採 惟獣毒

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

-- 惟獣弘
insert into tblBoard1 values (1,'慎穣採 惟獣毒脊艦陥');
insert into tblBoard1 values (2,'慎穣採 噺縦脊艦陥');
insert into tblBoard1 values (3,'慎穣採 因走脊艦陥');

insert into tblBoard2 values (1,'恥巷採 惟獣毒脊艦陥');
insert into tblBoard2 values (2,'ずし巷採 惟獣毒脊艦陥');

insert into tblBoard3 values (1,' 奄塙 惟獣毒脊艦陥');
insert into tblBoard3 values (2,'奄塙 惟獣毒脊艦陥');
insert into tblBoard3 values (3,'奄塙 惟獣毒脊艦陥');
insert into tblBoard3 values (4,'ずけい採 惟獣毒脊艦陥');


------------------------------------------------------------

-- 析恵腰硲 + 違帖走 省澗 収切 > sequence 梓端
create sequence boardSeq;
insert into tblBoard1 values (boardSeq.nextval,'慎穣採 惟獣毒脊艦陥');
insert into tblBoard1 values (boardSeq.nextval,'慎穣採 噺縦脊艦陥');
insert into tblBoard1 values (boardSeq.nextval,'慎穣採 因走脊艦陥');

insert into tblBoard2 values (boardSeq.nextval,'恥巷採 惟獣毒脊艦陥');
insert into tblBoard2 values (boardSeq.nextval,'ずし巷採 惟獣毒脊艦陥');

insert into tblBoard3 values (boardSeq.nextval,' 奄塙 惟獣毒脊艦陥');
insert into tblBoard3 values (boardSeq.nextval,'奄塙 惟獣毒脊艦陥');
insert into tblBoard3 values (boardSeq.nextval,'奄塙 惟獣毒脊艦陥');
insert into tblBoard3 values (boardSeq.nextval,'ずけい採 惟獣毒脊艦陥');




select * from tblBoard1;
select * from tblBoard2;
select * from tblBoard3;

-- 紫舌還 -> 乞窮 惟獣弘聖 廃腰拭 左惟 背含虞..

select * from
    (select * from tblBoard1
    union
    select * from tblBoard2
    union
    select * from tblBoard3)
    order by seq desc;




-- 塾戚杉球
-- 号誤系 : 惟獣弘 5鰍帖 > 臣背 6鰍託
-- 1. 1鯵 砺戚鷺 紫遂
-- : 析胤伊事, 搭杯淫軒 畷敗.
-- : 汽戚斗亜 弦焼霜呪系 伊事拭 獣娃戚 神掘杏顕
-- 2. 食君鯵 砺戚鷺 紫遂
-- : 砺戚鷺 鯵雁 傾坪球研 匝食辞 伊事 紗亀研 匝戚切
-- : 搭杯 淫軒 > union 去税 奄綬聖 紫遂背辞 (搭杯,搾遂降持)


 
create table tblUnionA
(
    name varchar2(50) NOT NULL
);
 
create table tblUnionB
(
    name varchar2(50) NOT NULL
);

INSERT INTO tblUnionA values('紫引');
INSERT INTO tblUnionA values('疫');
INSERT INTO tblUnionA values('督昔蕉巴');
INSERT INTO tblUnionA values('郊蟹蟹');
INSERT INTO tblUnionA values('匂亀');


INSERT INTO tblUnionB values('徹是');
INSERT INTO tblUnionB values('郊蟹蟹');
INSERT INTO tblUnionB values('神兄走');
INSERT INTO tblUnionB values('匂亀');
INSERT INTO tblUnionB values('差周焼');

SELECT * from tblUnionA;
SELECT * from tblUnionB;

SELECT name,count(*) from
(SELECT * from tblUnionA
UNION -- 掻差葵精 薦暗
SELECT * from tblUnionB) group by name;

SELECT * from tblUnionA
UNION all-- 掻差葵亀 妊薄
SELECT * from tblUnionB;

SELECT name,count(*) from
(SELECT * from tblUnionA
UNION ALL -- 掻差葵精 妊薄
SELECT * from tblUnionB) group by name having count(*)>1;


select * from tblinsa where buseo = '奄塙採'
UNION
select * from tblinsa where jikwi = '企軒';


SELECT * FROM tblUnionA
intersect -- 嘘増杯
SELECT * FROM tblUnionB;

select * from tblUnionA
minus -- A-B -> A拭幻 赤澗 依幻
select * from tblUnionB;

select * from tblUnionB
minus -- B-A -> B拭幻 赤澗 依幻
select * from tblUnionA;
