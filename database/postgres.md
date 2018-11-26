### backup
	pg_dump database_name > backup.sql
	
	pg_dump -Ft database_name > backup.tar

### restore
	pg_restore -d database_name -Ft -c ./backup.tar

#### select table rows
	SELECT relname, reltuples AS approximate_row_count FROM pg_class order by relname

