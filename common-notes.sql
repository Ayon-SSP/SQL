create table table_name(
	colname data_type constrent;
)

Constraint: 
1. NOT NULL
2. UNIQUE
3. PRIMARY KEY
4. FOREIGN KEY
5. CHECK
6. DEFAULT
7. CREATE INDEX


-- insertion order is maintained
insert into table_name (col1, col2, col3);




-- column
alter table table_name
add column new_col_name data_tupe;
-<or>- drop column col_name;
-<or>- drop column (col_name, col_name2);
-<or>- alter column column_name new_datatype;
-<or>- rename column old_name to new_colname;

alter table table_name
add/drop/enable/disable constraint constraint_name
...
-- default
ALTER TABLE table_name
ALTER COLUMN column_name SET DEFAULT new_default_value;

-- table name
alter table table_name
rename to new_table_name;

-- keys
alter table table_name
add constraint pk_constraint_name 
add (
    column_name `data_type` constraints,
    column_name `data_type` constraints,
);
primary key (column_name);
-<or>-  add constraint fk_constraint_name
	foreign key (column_name) references reference_table(ref_column);
-<or>- drop constraint pk_constraint_name;
-<or>- drop constraint (pk_constraint_name, fk_constraint_name);


rename old_table to new_table;

Drop <opt> table_name;
<opt> =
	database
	table
	view
	user
	index
	proceger

truncate table table_name;

TRUNCATE TABLE table_name
CASCADE;


comment on table table_name is 'This is a prat of online shopint project';





on delete set NULL
on delete cascade
