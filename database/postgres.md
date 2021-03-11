### error message
C:\Program Files\PostgreSQL\9.?\data\postgresql.conf

	lc_messages = 'en_US'

### create
```sql
CREATE USER testuser PASSWORD 'testpass';
CREATE DATABASE testdb WITH OWNER = testuser ENCODING = 'UTF-8';
GRANT ALL ON DATABASE testdb TO testuser;
```

### backup
```sh
pg_dump database_name > backup.sql
pg_dump -Ft database_name > backup.tar
pg_dump -Fc database_name > backup.dmp

# schema-only
pg_dump -U postgres -s foo > schema-only.sql

# data-only
pg_dump -U postgres -a foo > data-only.sql
```


### restore
```sh
psql database_name < backup.sql
pg_restore -d database_name -Ft -c backup.tar
pg_restore -d database_name -Fc -c backup.dmp
```

#### select table rows
```sql
SELECT relname, reltuples AS approximate_row_count FROM pg_class order by relname
```
