--------------------------------------------------------------------
--- List size information about all tables in the current database.
--- Thanks goes to marc-s @ http://stackoverflow.com/a/7892349
--------------------------------------------------------------------

SELECT 
    t.NAME AS TableName,
    s.Name AS SchemaName,
    p.rows AS RowCounts,
    Convert(int, SUM(a.total_pages) * 8.0/1024) AS TotalSpaceMB, 
    Convert(int, SUM(a.used_pages) * 8.0/1024) AS UsedSpaceMB, 
    Convert(int, (SUM(a.total_pages) - SUM(a.used_pages)) * 8.0/1024) AS UnusedSpaceMB
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
WHERE 
    t.NAME NOT LIKE 'dt%' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255
GROUP BY 
    t.Name, s.Name, p.Rows
ORDER BY 
    p.rows desc