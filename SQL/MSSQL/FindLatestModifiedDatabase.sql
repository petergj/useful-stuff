--------------------------------------------------------------------
--- List all databases according to the last modified data.
--- Slightly modified version of https://stackoverflow.com/questions/18876078/list-all-the-databases-on-one-sql-server-in-the-order-they-were-created/18876951#18876951
--------------------------------------------------------------------
DROP TABLE IF EXISTS #db_name
create table #db_name (db_name nvarchar(128), last_change datetime);
exec sp_MSForEachDB 'Use [?]; insert into #db_name (db_name, last_change) select ''?'', max(modify_date) from sys.tables'
select * from #db_name order by last_change desc
