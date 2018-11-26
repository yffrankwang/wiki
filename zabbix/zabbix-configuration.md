Zabbix Configuration
========================

### Template OS Linux / Processor Loader is too high on {HOST.NAME}
	{Template OS Linux:system.cpu.load[percpu,avg1].avg(5m)}>5 and {Template OS Linux:system.cpu.util[,user].min(5m)}>75
