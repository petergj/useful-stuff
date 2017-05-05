--------------------------------------------------------------------
--- Disable all constraint checks and delete from all tables
--- Thanks goes to kristof @ http://stackoverflow.com/questions/155246/how-do-you-truncate-all-tables-in-a-database-using-tsql/156813#156813
--------------------------------------------------------------------

-- disable all constraints
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

-- delete data in all tables
EXEC sp_MSForEachTable "DELETE FROM ?"

-- enable all constraints
exec sp_msforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"