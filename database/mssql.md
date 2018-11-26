### generates a random number between 0-9
	ABS(Checksum(NewID()) % 9)


#### select table rows(2000)
	-- Shows all user tables and row counts for the current database 
	-- Remove OBJECTPROPERTY function call to include system objects 
	SELECT o.NAME, i.rowcnt 
	FROM sysindexes AS i
	  INNER JOIN sysobjects AS o ON i.id = o.id 
	WHERE i.indid < 2  AND OBJECTPROPERTY(o.id, 'IsMSShipped') = 0
	ORDER BY i.rowcnt desc


#### select table rows
	-- Shows all user tables and row counts for the current database 
	-- Remove is_ms_shipped = 0 check to include system objects 
	-- i.index_id < 2 indicates clustered index (1) or hash table (0) 
	SELECT o.name, ddps.row_count 
	FROM sys.indexes AS i
	  INNER JOIN sys.objects AS o ON i.OBJECT_ID = o.OBJECT_ID
	  INNER JOIN sys.dm_db_partition_stats AS ddps ON i.OBJECT_ID = ddps.OBJECT_ID
	  AND i.index_id = ddps.index_id 
	WHERE i.index_id < 2  AND o.is_ms_shipped = 0 ORDER BY o.NAME 
	ORDER BY ddps.row_count desc


#### disable all constraints
	EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"


#### enable all constraints
	EXEC sp_msforeachtable @command1="print '?'", @command2="ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"

