


TRUNCATE TABLE schema_name.table_name
[CASCADE]
[[ PRESERVE | PURGE] MATERIALIZED VIEW LOG ]]
[[ DROP | REUSE]] STORAGE ]

PURGE: 
	In simple terms, using PURGE in the SQL statement means you want to completely get rid of the record of changes (log) that is associated with the table you're truncating. It's like saying, "Not only do I want to remove the data from the table, but I also want to erase any history or log of changes related to it."
PRESERVE: 
In easy terms, using PRESERVE in the SQL statement means you want to keep and maintain the record of changes (log) associated with the table even after truncating it. Its like saying, "Remove the data from the table, but please keep a record of any changes made to it in the past."


TRUNCATE TABLE schema_name.table_name: Removes all rows from the specified table while preserving the table structure.

[CASCADE]: Optional keyword indicating that dependent objects (e.g., foreign keys) should also be truncated.

[[ PRESERVE | PURGE] MATERIALIZED VIEW LOG ]: Optional clause for preserving or purging materialized view logs associated with the table.

[[ DROP | REUSE]] STORAGE ]: Optional clause for dropping or reusing storage space.