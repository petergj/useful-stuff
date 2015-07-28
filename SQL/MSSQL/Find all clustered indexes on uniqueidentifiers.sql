--------------------------------------------------------------------
--- List clustered indexes on uniqueidentifier in current database
--- Thanks goes to RichardTheKiwi @ http://stackoverflow.com/a/13390865
--------------------------------------------------------------------
select o.name objectname, i.name indexname, c.name as columnname
from sys.objects o
join sys.indexes i on i.object_id = o.object_id
join sys.index_columns ic on ic.index_id = i.index_id and ic.object_id = i.object_id
join sys.columns c on c.object_id = o.object_id and c.column_id = ic.column_id
join sys.types t on c.system_type_id = t.system_type_id
where o.is_ms_shipped = 0
  and i.type_desc = 'CLUSTERED'
  and t.name = 'uniqueidentifier'
order by o.name, i.name