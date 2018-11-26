#### startup/shutdown pluggable database
	$ sqlplus / as sysdba
	alter pluggable database pdborcl open;
	alter pluggable database pdborcl close immediate;

#### auto start pluggable database
	$ sqlplus / as sysdba
	alter pluggable database pdborcl open;
	alter pluggable database pdborcl save state;

#### clone pdb
	$ sqlplus / as sysdba
	create pluggable database xe from pdborcl
		file_name_convert = (
		'C:\oracle\oradata\orcl\pdborcl\',
		'C:\oracle\oradata\orcl\xe\'
	)
	path_prefix = 'C:\oracle\oradata\orcl\xe';

#### connect pdb
	alter session set container=pdborcl;
	show con_name;
	show pdbs;
	select name, open_mode from v$pdbs;

#### connect service
	@see https://oracle-base.com/articles/12c/multitenant-connecting-to-cdb-and-pdb-12cr1
	sqlplus user/PWD@//localhost:1521/service

#### show tables;
	SELECT TNAME FROM TAB;
	SELECT TABLE_NAME FROM USER_TABLES;
