--------------------------------------------------------------------
--- Rebuild all indexes on current database
--- Slightly modified version of script found here @ 
--- http://blog.sqlauthority.com/2009/01/30/sql-server-2008-2005-rebuild-every-index-of-all-tables-of-database-rebuild-index-with-fillfactor/
--------------------------------------------------------------------
DECLARE @TableName VARCHAR(255)
DECLARE @sql NVARCHAR(500)
DECLARE @fillfactor INT
SET @fillfactor = 80
DECLARE TableCursor CURSOR FOR

SELECT OBJECT_SCHEMA_NAME([object_id])+'.['+name+']' AS TableName FROM sys.tables
OPEN TableCursor
FETCH NEXT FROM TableCursor INTO @TableName
WHILE @@FETCH_STATUS = 0
BEGIN
	Print 'Rebuilding indexes on Table: ' + @TableName
	SET @sql = 'ALTER INDEX ALL ON ' + @TableName + ' REBUILD WITH (FILLFACTOR = ' + CONVERT(VARCHAR(3),@fillfactor) + ')'
	EXEC (@sql)
	FETCH NEXT FROM TableCursor INTO @TableName
END

CLOSE TableCursor
DEALLOCATE TableCursor
GO