--------------------------------------------------------------------
--- Shrink Database files
--------------------------------------------------------------------
DECLARE @logFile VARCHAR(50), @databaseFile VARCHAR(50)

SELECT @logFile = name FROM sys.master_files WHERE database_id = db_id() AND type = 1
SELECT @databaseFile = name FROM sys.master_files WHERE database_id = db_id() AND type = 0

DBCC SHRINKFILE(@logFile, 1)
DBCC SHRINKFILE(@databaseFile, 1)

