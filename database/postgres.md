### initialize db
```sh
initdb -D D:\Develop\Database\pgsql18 -U postgres --locale=C --encoding=UTF8
```

### pg_upgrade
change old/new pg_hba.conf METHOD to trust.

```bat
pg_upgrade.exe --old-datadir D:\Develop\Database\pgsql16 --new-datadir D:\Develop\Database\pgsql18 --old-bindir D:\Develop\Servers\pgsql-16.3\bin --new-bindir D:\Develop\Servers\pgsql-18.6\bin -U postgres
```

### pgvector
https://github.com/pgvector/pgvector

```bat
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

set "PGROOT=C:\Program Files\PostgreSQL\16"
cd %TEMP%
git clone --branch v0.7.3 https://github.com/pgvector/pgvector.git
cd pgvector
nmake /F Makefile.win
nmake /F Makefile.win install
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

### create superuser
```sql
CREATE ROLE mysuperuser2 WITH SUPERUSER CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'mysuperpass2';
```

### backup
```sh
pg_dump -d database_name     -f backup.sql
pg_dump -d database_name -Ft -f backup.tar
pg_dump -d database_name -Fc -f backup.dmp

# schema-only
pg_dump -U postgres -s foo -f schema-only.sql

# data-only
pg_dump -U postgres -a foo -f data-only.sql

# specific schema
pg_dump -U postgres -d database_name -n schema_name     -f schema-backup.sql
pg_dump -U postgres -d database_name -n schema_name -Fc -f schema-backup.dump

```


### restore
```sh
psql -d database_name -f backup.sql
pg_restore -d database_name -Ft backup.tar
pg_restore -d database_name -Fc backup.dmp
pg_restore --verbose --clean --no-acl --no-owner -d database_name backup.dmp
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

### encoding
```bat
SET PGCLIENTENCODING=utf-8
chcp 65001
psql.exe -U postgres -f utf8.sql  testdb
```

### reset sequence
```sql
ALTER SEQUENCE test_id_seq RESTART WITH 100;

SELECT SETVAL('test_id_seq', 101, false);

SELECT SETVAL('test_id_seq', COALESCE((SELECT MAX(id)+1 FROM test), 1), false);
```

### schemas
```sql
SELECT schema_name FROM information_schema.schemata;

CREATE SCHEMA test;
```

### indexes
```sql
SELECT
	schemaname,
	tablename,
	indexname,
	indexdef
FROM
	pg_indexes
ORDER BY
	schemaname,
	tablename,
	indexname;
```

```sql
SELECT
	'DROP INDEX ' || schemaname || '.' || indexname || ';' as sql
FROM
	pg_indexes
WHERE
	indexname like 'idx_%'
ORDER BY
	schemaname,
	tablename,
	indexname;
```

### statistics

schema list:
```sql
SELECT
	nspname AS name,
	COALESCE((SELECT SUM(pg_table_size(oid)) FROM pg_catalog.pg_class WHERE relnamespace = pg_namespace.oid AND relkind = 'r'), 0) AS size,
	COALESCE(obj_description(oid, 'pg_namespace'), '') AS comment
FROM "pg_catalog"."pg_namespace"
WHERE "nspname" NOT LIKE '%\_%'
```

table list:
```sql
SELECT
	n.nspname,
	c.relname,
	pg_relation_size(c.oid) as relsize,
	pg_table_size(c.oid) as tblsize,
	pg_indexes_size(c.oid) as idxsize,
	pg_total_relation_size(c.oid) as size
FROM
	pg_catalog.pg_class c
JOIN
	pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE
	 n.nspname NOT LIKE '%\_%'
 AND c.relkind = 'r'
ORDER BY nspname, relname
```