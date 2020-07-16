--------------------------------------------------------
--  File created - Wednesday-July-15-2020   
--------------------------------------------------------
DROP TYPE "C##TDW"."LIST_ROOM";
DROP TYPE "C##TDW"."RESULT";
DROP TYPE "C##TDW"."ROOM_RECORD";
DROP TYPE "C##TDW"."ROOM_TABLE";
DROP TABLE "C##TDW"."ANALRESULT" cascade constraints;
DROP TABLE "C##TDW"."DIAGNOSIS" cascade constraints;
DROP TABLE "C##TDW"."PEOPLE" cascade constraints;
DROP TABLE "C##TDW"."ROOMS" cascade constraints;
DROP TABLE "C##TDW"."USERS" cascade constraints;
DROP VIEW "C##TDW"."SHOW_DIAGNOSIS";
DROP VIEW "C##TDW"."SHOW_PATIENTS";
DROP VIEW "C##TDW"."SHOW_ROOMS";
DROP PROCEDURE "C##TDW"."ANALYSTIC_DIAG";
--------------------------------------------------------
--  DDL for Type LIST_ROOM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##TDW"."LIST_ROOM" is table of room_record;

/
--------------------------------------------------------
--  DDL for Type RESULT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##TDW"."RESULT" is table of varchar2(150);

/
--------------------------------------------------------
--  DDL for Type ROOM_RECORD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##TDW"."ROOM_RECORD" is object(id number, cap number);

/
--------------------------------------------------------
--  DDL for Type ROOM_TABLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##TDW"."ROOM_TABLE" is table of number;

/
--------------------------------------------------------
--  DDL for Table ANALRESULT
--------------------------------------------------------

  CREATE TABLE "C##TDW"."ANALRESULT" 
   (	"ID" NUMBER, 
	"DIAG_NAME" VARCHAR2(64 BYTE), 
	"RATIO" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table DIAGNOSIS
--------------------------------------------------------

  CREATE TABLE "C##TDW"."DIAGNOSIS" 
   (	"ID" NUMBER, 
	"NAME_DIAG" VARCHAR2(64 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table PEOPLE
--------------------------------------------------------

  CREATE TABLE "C##TDW"."PEOPLE" 
   (	"ID" NUMBER, 
	"FIRST_NAME" VARCHAR2(16 BYTE), 
	"LAST_NAME" VARCHAR2(16 BYTE), 
	"FATHER_NAME" VARCHAR2(16 BYTE), 
	"ID_ROOM" NUMBER, 
	"ID_DIAG" NUMBER, 
	"DESCRIPTIONS" VARCHAR2(1024 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table ROOMS
--------------------------------------------------------

  CREATE TABLE "C##TDW"."ROOMS" 
   (	"ID" NUMBER, 
	"NAME" VARCHAR2(16 BYTE), 
	"CAP" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table USERS
--------------------------------------------------------

  CREATE TABLE "C##TDW"."USERS" 
   (	"LOGIN" VARCHAR2(32 BYTE), 
	"PASS" VARCHAR2(64 BYTE), 
	"ROLE" VARCHAR2(32 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for View SHOW_DIAGNOSIS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "C##TDW"."SHOW_DIAGNOSIS" ("ID", "NAME", "FIRST_NAME", "LAST_NAME", "FATHER_NAME", "ROOM") AS 
  select DIAGNOSIS.ID, DIAGNOSIS.Name_Diag, PEOPLE.first_Name, PEOPLE.last_Name, PEOPLE.father_Name, ROOMS.Name   
    from DIAGNOSIS
    join PEOPLE on DIAGNOSIS.ID =PEOPLE.ID_Diag
    join ROOMS on ROOMS.ID = PEOPLE.ID_Room
    order by DIAGNOSIS.ID
;
--------------------------------------------------------
--  DDL for View SHOW_PATIENTS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "C##TDW"."SHOW_PATIENTS" ("ID", "FIRST_NAME", "LAST_NAME", "FATHER_NAME", "ROOM", "DIAGNOSIS", "DESCRIPTIONS") AS 
  select PEOPLE.ID, PEOPLE.first_Name, PEOPLE.last_Name, PEOPLE.father_Name,ROOMS.Name, DIAGNOSIS.Name_Diag, PEOPLE.descriptions 
    from PEOPLE
    join ROOMS on ROOMS.ID = people.ID_Room
    join DIAGNOSIS on DIAGNOSIS.ID = PEOPLE.ID_Diag
    order by PEOPLE.id
;
--------------------------------------------------------
--  DDL for View SHOW_ROOMS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "C##TDW"."SHOW_ROOMS" ("ID", "ROOM", "CAPACITY", "FIRST_NAME", "LAST_NAME", "FATHER_NAME", "DIAGNOSIS") AS 
  select ROOMS.ID, ROOMS.Name, ROOMS.cap, PEOPLE.first_Name, PEOPLE.last_Name, PEOPLE.father_Name, DIAGNOSIS.Name_Diag    
    from ROOMS
    join PEOPLE on ROOMS.ID =PEOPLE.ID_Room
    join DIAGNOSIS on DIAGNOSIS.ID = PEOPLE.ID_Diag
    order by ROOMS.Name
;
REM INSERTING into C##TDW.ANALRESULT
SET DEFINE OFF;
Insert into C##TDW.ANALRESULT (ID,DIAG_NAME,RATIO) values (5,'myocardial infarction',12.5);
Insert into C##TDW.ANALRESULT (ID,DIAG_NAME,RATIO) values (6,'heart failure',12.5);
Insert into C##TDW.ANALRESULT (ID,DIAG_NAME,RATIO) values (7,'Herniated Disc',25);
Insert into C##TDW.ANALRESULT (ID,DIAG_NAME,RATIO) values (8,'gout',18.75);
Insert into C##TDW.ANALRESULT (ID,DIAG_NAME,RATIO) values (9,'Osteoporosis',12.5);
Insert into C##TDW.ANALRESULT (ID,DIAG_NAME,RATIO) values (2,'PNEUMONIA',0);
Insert into C##TDW.ANALRESULT (ID,DIAG_NAME,RATIO) values (3,'BRONCHITIS',0);
Insert into C##TDW.ANALRESULT (ID,DIAG_NAME,RATIO) values (4,'myocarditis',12.5);
Insert into C##TDW.ANALRESULT (ID,DIAG_NAME,RATIO) values (1,'COVID-19',6.25);
REM INSERTING into C##TDW.DIAGNOSIS
SET DEFINE OFF;
Insert into C##TDW.DIAGNOSIS (ID,NAME_DIAG) values (5,'myocardial infarction');
Insert into C##TDW.DIAGNOSIS (ID,NAME_DIAG) values (6,'heart failure');
Insert into C##TDW.DIAGNOSIS (ID,NAME_DIAG) values (7,'Herniated Disc');
Insert into C##TDW.DIAGNOSIS (ID,NAME_DIAG) values (8,'gout');
Insert into C##TDW.DIAGNOSIS (ID,NAME_DIAG) values (9,'Osteoporosis');
Insert into C##TDW.DIAGNOSIS (ID,NAME_DIAG) values (2,'PNEUMONIA');
Insert into C##TDW.DIAGNOSIS (ID,NAME_DIAG) values (3,'BRONCHITIS');
Insert into C##TDW.DIAGNOSIS (ID,NAME_DIAG) values (4,'myocarditis');
Insert into C##TDW.DIAGNOSIS (ID,NAME_DIAG) values (1,'COVID-19');
REM INSERTING into C##TDW.PEOPLE
SET DEFINE OFF;
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (7,'Divinity','Wood  ','Jagger',7,9,'good');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (8,'Gala','Henderson  ','Kingsley',6,4,'bad');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (9,' Judson ','Ross  ','Washburn',7,7,'good');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (10,'Kennard','Cook  ','Adney',8,8,'bad');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (11,'Indiana','Wright  ','Blackburn',8,7,'good');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (12,'Peony','Davis  ','Bryce',8,7,'bad');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (13,'London','Brown  ','Byrd',8,7,'good');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (14,'Rugby','Jones  ','Stanwick',7,8,'bad');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (15,'Wrenn','Young  ','Taft',7,9,'good');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (16,'Sedgwick','Morgan  ','Ulmer',4,6,'bad');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (17,'Jarrell','Coleman  ','Norvell',4,4,'good');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (18,'Malachite','Perry  ','Octha',4,5,'good');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (19,'Kell','Long  ','Osgood',4,6,'good');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (20,'Pansy','Patterson  ','Robin',5,5,'good');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (1,'Phong','Truong ','Nguyen',9,8,'good');
Insert into C##TDW.PEOPLE (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,ID_ROOM,ID_DIAG,DESCRIPTIONS) values (2,'DUng','Viet','Bui',1,1,'bad');
REM INSERTING into C##TDW.ROOMS
SET DEFINE OFF;
Insert into C##TDW.ROOMS (ID,NAME,CAP) values (3,'103-Vip',1);
Insert into C##TDW.ROOMS (ID,NAME,CAP) values (4,'202-Heart',15);
Insert into C##TDW.ROOMS (ID,NAME,CAP) values (5,'203-Heart',12);
Insert into C##TDW.ROOMS (ID,NAME,CAP) values (6,'204-Vip',1);
Insert into C##TDW.ROOMS (ID,NAME,CAP) values (7,'301-Bone',9);
Insert into C##TDW.ROOMS (ID,NAME,CAP) values (8,'302-Bone',6);
Insert into C##TDW.ROOMS (ID,NAME,CAP) values (9,'303-Vip',1);
Insert into C##TDW.ROOMS (ID,NAME,CAP) values (10,'001-Boss',1);
Insert into C##TDW.ROOMS (ID,NAME,CAP) values (1,'101-Lung',15);
Insert into C##TDW.ROOMS (ID,NAME,CAP) values (2,'102-Lung',12);
REM INSERTING into C##TDW.USERS
SET DEFINE OFF;
Insert into C##TDW.USERS (LOGIN,PASS,ROLE) values (' doctorwuh','a107ff1f8cc37ce618e9adf87d0ac2977b81dfad03b3464dc29f0cb84e0805ba','doctor');
Insert into C##TDW.USERS (LOGIN,PASS,ROLE) values ('professorX','a83a3327bddbd09c9dd339e49f6f3a6891c89e093150f8842f454d22b85cb0d4','doctor');
Insert into C##TDW.USERS (LOGIN,PASS,ROLE) values ('ironman','b2dc7470eb646eab0f97a29ff509afc333e3267ea0d10314f7d0c74bb7aacc31','doctor');
Insert into C##TDW.USERS (LOGIN,PASS,ROLE) values ('blackpink','8a771c4775b2617a783cbaf58c860db875ec5b2e282952975b1e1938574725aa','doctor');
Insert into C##TDW.USERS (LOGIN,PASS,ROLE) values ('ADMIN','552a8347c909a1e9f6508635f90b06b1165a8b4389d2556b5dd837750a4a7a00','admin');
--------------------------------------------------------
--  DDL for Trigger CAN_NOT_CHANGE_DIAG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##TDW"."CAN_NOT_CHANGE_DIAG" 
    before update on DIAGNOSIS
    for each row
declare
    temp_count number;
begin
    select count(ID_DIAG) into temp_count from PEOPLE where ID_Diag = :old.ID;
    if (temp_count > 0) then
        raise_application_error(-20002, 'Error: DIAGNOSIS_EXSITED_CAN_NOT_CHANGE');
    end if;
end;

/
ALTER TRIGGER "C##TDW"."CAN_NOT_CHANGE_DIAG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger CAN_NOT_INSERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##TDW"."CAN_NOT_INSERT" 
    before insert on PEOPLE
    for each row
declare
    numb number;
    capacity number;
begin
    select count(ID_Room) into numb from PEOPLE where ID_Room = :new.ID_Room;
    select cap into capacity from ROOMS where ID = :new.ID_Room;
    if (numb = capacity) then
        raise_application_error(-20001, 'Error: ROOM IS FULL. CAN NOT ADD MORE PEOPLE');
    end if;
end;

/
ALTER TRIGGER "C##TDW"."CAN_NOT_INSERT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger ROOM_DEL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##TDW"."ROOM_DEL" 
for delete on ROOMS
compound trigger
    temp_room number;
    old_list list_room;
before statement is
begin
    select room_record(ROOMS.ID, ROOMS.cap) bulk collect into old_list from ROOMS;
end before statement;
before each row is
begin
    for current_person in  (select * from PEOPLE where ID_room = :old.ID) loop
    begin 
        select ID_room into temp_room
        from( 
            select ID_room, countR, tableR.cap as cap
            from (
                select ID_room , count(ID_Room) as countR
                from PEOPLE
                where ID_Diag= current_person.ID_Diag
                group by ID_room
                )
            join table(old_list) tableR on tableR.id = ID_room 
            where ID_room != :old.ID)
        where countR< cap and rownum = 1;
        exception
            when no_data_found then
                raise_application_error(-20100, 'ALL_ROOMS_WITH_THE_SAME_DIAGNOSIS_ARE_FULL');
            end;
            if (temp_room is not null) then
                update PEOPLE set ID_room = temp_room where id = current_person.id;
            end if;
    end loop;
end before each row;
end;


/
ALTER TRIGGER "C##TDW"."ROOM_DEL" ENABLE;
--------------------------------------------------------
--  DDL for Procedure ANALYSTIC_DIAG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "C##TDW"."ANALYSTIC_DIAG" (ratio1 in number) is
    total number; 
    countP number;
begin
    select count(ID) into total from PEOPLE;
    for diag in (select * from DIAGNOSIS)  loop 
        select cc into countP 
        from (
            select count(ID)/total as cc
            from PEOPLE
            where ID_DIAg= diag.id);

            insert into analresult(ID, DIAG_NAME, RATIO ) values( diag.id, diag.name_diag,countP*100);
            delete from analresult where analresult.ratio< ratio1;
    end loop;
end;

-----------------------------------------------------------------------------------

/
--------------------------------------------------------
--  Constraints for Table PEOPLE
--------------------------------------------------------

  ALTER TABLE "C##TDW"."PEOPLE" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "C##TDW"."PEOPLE" MODIFY ("FIRST_NAME" NOT NULL ENABLE);
  ALTER TABLE "C##TDW"."PEOPLE" MODIFY ("LAST_NAME" NOT NULL ENABLE);
  ALTER TABLE "C##TDW"."PEOPLE" MODIFY ("FATHER_NAME" NOT NULL ENABLE);
  ALTER TABLE "C##TDW"."PEOPLE" MODIFY ("ID_ROOM" NOT NULL ENABLE);
  ALTER TABLE "C##TDW"."PEOPLE" MODIFY ("ID_DIAG" NOT NULL ENABLE);
  ALTER TABLE "C##TDW"."PEOPLE" MODIFY ("DESCRIPTIONS" NOT NULL ENABLE);
  ALTER TABLE "C##TDW"."PEOPLE" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table ROOMS
--------------------------------------------------------

  ALTER TABLE "C##TDW"."ROOMS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "C##TDW"."ROOMS" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "C##TDW"."ROOMS" MODIFY ("CAP" NOT NULL ENABLE);
  ALTER TABLE "C##TDW"."ROOMS" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table DIAGNOSIS
--------------------------------------------------------

  ALTER TABLE "C##TDW"."DIAGNOSIS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "C##TDW"."DIAGNOSIS" MODIFY ("NAME_DIAG" NOT NULL ENABLE);
  ALTER TABLE "C##TDW"."DIAGNOSIS" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table USERS
--------------------------------------------------------

  ALTER TABLE "C##TDW"."USERS" ADD PRIMARY KEY ("LOGIN")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PEOPLE
--------------------------------------------------------

  ALTER TABLE "C##TDW"."PEOPLE" ADD CONSTRAINT "FK_PR" FOREIGN KEY ("ID_ROOM")
	  REFERENCES "C##TDW"."ROOMS" ("ID") ENABLE;
  ALTER TABLE "C##TDW"."PEOPLE" ADD CONSTRAINT "FK_PD" FOREIGN KEY ("ID_DIAG")
	  REFERENCES "C##TDW"."DIAGNOSIS" ("ID") ENABLE;
