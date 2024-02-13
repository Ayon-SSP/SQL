-- synchronized backup copy of a table using DML Trigger
/*
Table 1 (Main Table)
Table 2 (Backup Table)


*/

create table main_table(
    id int
);

Insert into main_table values(1);
Insert into main_table values(2);

create table main_table_backup AS
select * from main_table where 1=2;


select * from main_table;
select * from main_table_backup;


CREATE OR REPLACE TRIGGER main_table_backup_trigger
BEFORE INSERT OR DELETE OR UPDATE ON main_table
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO main_table_backup VALUES(:new.id);
    ELSIF DELETING THEN
        DELETE FROM main_table_backup WHERE id = :old.id;
    ELSIF UPDATING THEN
        UPDATE main_table_backup SET id = :new.id WHERE id = :old.id;
    END IF;
END;
/

Insert into main_table values(10);
Insert into main_table values(11);

select * from main_table;
select * from main_table_backup;
