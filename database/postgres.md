### initialize db
```sh
initdb -D /data/pgsql/13 -U postgres --local C --encoding UTF8
```

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

### upgrade
```bat
set OLD=C:/Program Files/PostgreSQL/9.6
set NEW=C:/Program Files/PostgreSQL/13.3
pg_upgrade.exe --old-datadir "%OLD%/data" --new-datadir "%NEW%/data" --old-bindir "%OLD%/bin" --new-bindir "%NEW%/bin"
```

### select table rows
```sql
SELECT relname, reltuples AS approximate_row_count FROM pg_class order by relname
```

### output
```sh
# run sql
psql -U USER -h HOST -d DBNAME -c "SELECT GETDATE();" > ./test.log

# to csv
psql -U USER -h HOST -d DBNAME -c "SELECT GETDATE();" -A -F,> ./test.csv

# to tsv
psql -U USER -h HOST -d DBNAME -c "SELECT GETDATE();" -A -F$'\t'> ./test.csv

```
