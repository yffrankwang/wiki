LinuxインフラSEなら知っておくべきリソース監視に関するコマンド。
------------------------------------------------

以下のコマンド実行例はCentOS 6.3 で確認したもの。

	[root@localhost /]# cat /etc/issue
	CentOS release 6.3 (Final)


### 空きメモリが知りたい

freeで確認可能。

	> free
				 total       used       free     shared    buffers     cached
	Mem:       1026876     974072      52804          0     202656     348008
	-/+ buffers/cache:     423408     603468
	Swap:      2048276         92    2048184

ここで注意なのは、Linuxは空きメモリをbufferとcacheとして使用するので、
一見freeは少ない(上記の場合52M)と思われがちだが、実際にはbuffer+cacheとして確保されている(上記の場合600M確保されている)


###ディスクの空き容量が知りたい。

dfで確認可能。基本ですね。

	[root@localhost /]# df
	/dev/mapper/VolGroup-lv_root
						  12941636   1851304  10432924  16% /
	Filesystem           1K-blocks      Used Available Use% Mounted on
	tmpfs                   510348         0    510348   0% /dev/shm
	/dev/sda1               495844     70443    399801  15% /boot
	/vagrant             488383484 421285716  67097768  87% /vagrant

ちなみに表示が長いと2行に分けて出力されるのだけど、スクリプトで使用率を定期的に監視したいときに非常にめんどくさい。その場合はdf -P を使えば1行で表示される。

### iノードの使用率が知りたい。
df -i で表示される。サイズの小さなファイルが非常に大量にある場合、ディスクの空き容量があるのになぜか書き込みに失敗した！なんてことが発生する。

	[root@localhost /]# df -i
	Filesystem            Inodes   IUsed   IFree IUse% Mounted on
	/dev/mapper/VolGroup-lv_root
						  822544   72999  749545    9% /
	tmpfs                 127587       1  127586    1% /dev/shm
	/dev/sda1             128016      44  127972    1% /boot
	/vagrant                1000       0    1000    0% /vagrant

### 特定のディレクトリ以下のディスクの使用量を知りたい。
du で確認可能。 結果をsortして表示したりすると分かりやすい。

	[root@localhost /]# du -sk /var/* | sort -nr  | head -5
	43788   /var/cache
	42600   /var/lib
	2060    /var/log
	104     /var/run
	44      /var/spool

### 物理ディスクの空き容量が知りたい(LVMを使っている場合)
dfでは論理ボリュームの使用量が分かるが、物理ディスクにどのくらい空きがあるか
知りたい場合は、pvdisplayを使用する。

	[root@localhost /]# pvdisplay
	  --- Physical volume ---
	  PV Name               /dev/sda2
	  VG Name               VolGroup
	  PV Size               14.51 GiB / not usable 3.00 MiB
	  Allocatable           yes (but full)
	  PE Size               4.00 MiB
	  Total PE              3714
	  Free PE               0
	  Allocated PE          3714
	  PV UUID               d2cKaW-6Ir3-XKJ6-GN2K-xKr0-jqlL-Vu7Ev9

ここのFree PE * PE Sizeが空き容量に相当する。(この場合は空き容量なし)
論理ボリュームの拡張作業などを行いたい際に確認できる。
論理ボリュームに関するその他の操作はLVM各種操作コマンドを参照。


### LISTENしているポート一覧を知りたい。

	[root@localhost fd]# netstat -an | grep LISTEN
	tcp        0      0 0.0.0.0:55118               0.0.0.0:*                   LISTEN
	tcp        0      0 0.0.0.0:111                 0.0.0.0:*                   LISTEN
	tcp        0      0 0.0.0.0:22                  0.0.0.0:*                   LISTEN

grep使わなくても-lオプションでLISTENしているポートのみ表示可。

	[root@localhost fd]# netstat -nlt 
	tcp        0      0 0.0.0.0:111                 0.0.0.0:*                   LISTEN
	tcp        0      0 0.0.0.0:22                  0.0.0.0:*                   LISTEN
	tcp        0      0 0.0.0.0:42936               0.0.0.0:*                   LISTEN


### 特定のポートを使用しているプロセスが知りたい。
lsofを使うと簡単。

	[root@localhost fd]# lsof -i:111
	COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
	rpcbind 1013  rpc    6u  IPv4   8479      0t0  UDP *:sunrpc
	rpcbind 1013  rpc    8u  IPv4   8482      0t0  TCP *:sunrpc (LISTEN)
	rpcbind 1013  rpc    9u  IPv6   8484      0t0  UDP *:sunrpc
	rpcbind 1013  rpc   11u  IPv6   8487      0t0  TCP *:sunrpc (LISTEN)


### 特定のファイルを開いているプロセスが知りたい
lsofはファイル名を引数に与えると掴んでいるプロセスを表示できる。便利。

	[root@localhost fd]# lsof /var/log/messages
	COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF   NODE NAME
	rsyslogd 990 root    1w   REG  253,0   462813 655345 /var/log/messages

lsofが入っていないマシンの場合はfuserでもOK

	[root@localhost /]# fuser /var/log/messages
	/var/log/messages:    1060


### プロセスが掴んでいるファイル一覧が知りたい。
lsof -p <PID>で確認できる。

	[root@localhost ~]# lsof -p 991
	COMMAND  PID USER   FD   TYPE             DEVICE SIZE/OFF       NODE NAME
	rsyslogd 991 root  cwd    DIR              253,0     4096          2 /
	rsyslogd 991 root  rtd    DIR              253,0     4096          2 /
	rsyslogd 991 root  txt    REG              253,0   391968       6410 /sbin/rsyslogd
	rsyslogd 991 root  mem    REG              253,0    27232     391290 /lib64/rsyslog/imklog.so
	　/* 一部省略 */
	rsyslogd 991 root  mem    REG              253,0   154624     407189 /lib64/ld-2.12.so
	rsyslogd 991 root    0u  unix 0xffff880037aef3c0      0t0       8354 /dev/log
	rsyslogd 991 root    1w   REG              253,0   492990     655345 /var/log/messages
	rsyslogd 991 root    2w   REG              253,0    47992     655346 /var/log/secure
	rsyslogd 991 root    3r   REG                0,3        0 4026532037 /proc/kmsg

lsofが使えなければ、/proc/<PID>/fd 以下を見てもある程度確認可能。

	[root@localhost ~]# ll /proc/991/fd
	total 0
	lrwx------ 1 root root 64 May 24 03:39 0 -> socket:[8354]
	l-wx------ 1 root root 64 May 24 03:39 1 -> /var/log/messages
	l-wx------ 1 root root 64 May 24 03:39 2 -> /var/log/secure
	lr-x------ 1 root root 64 May 24 03:39 3 -> /proc/kmsg


### プロセス内のスレッドの数を確認したい。
ps -Lオプションでスレッドを確認可能。

	[root@localhost ~]# ps aux -L
	USER       PID   LWP %CPU NLWP %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
	 <中略>
	root      1021  1021  0.0    4  0.3 249080  3612 ?        Sl   10:18   0:00 /sbin/rsyslogd -i /var/run/syslogd.pid -c 5
	root      1021  1022  0.0    4  0.3 249080  3612 ?        Sl   10:18   0:00 /sbin/rsyslogd -i /var/run/syslogd.pid -c 5
	root      1021  1024  0.0    4  0.3 249080  3612 ?        Sl   10:18   0:00 /sbin/rsyslogd -i /var/run/syslogd.pid -c 5
	root      1021  1025  0.0    4  0.3 249080  3612 ?        Sl   10:18   0:00 /sbin/rsyslogd -i /var/run/syslogd.pid -c 5
	[root@localhost ~]# ps aux -L | head -1

同じPIDで複数のLWPが表示されているプロセスであれば、複数のスレッドを持っていることが分かる。


### 稼動しているプロセスを検索したい。
pgrepを使えば、PIDとプロセス名を簡単に検索できる。
ps -ef | grep ...とかより手っ取り早い。

	[root@localhost ~]# pgrep -l syslog
	1060 rsyslogd


### プロセスのメモリマップを確認したい
pmapコマンドでそのプロセスが使用しているメモリ状況が確認できる。
メモリのチューニングや使用量の確認の際に使える。

	[root@localhost ~]# pmap -x 1298
	1298:   crond
	Address           Kbytes     RSS   Dirty Mode   Mapping
	00007fa1b356e000      48      20       0 r-x--  libnss_files-2.12.so
	00007fa1b357a000    2048       0       0 -----  libnss_files-2.12.so
	 (中略)
	ffffffffff600000       4       0       0 r-x--    [ anon ]
	----------------  ------  ------  ------
	total kB          117208    1232     600```

表示される項目は以下の通り。

	Address: マップの開始アドレス
	Kbytes: 仮想メモリのマップサイズ(キロバイト単位)
	RSS: 物理常駐メモリのマップサイズ(キロバイト単位)
	Mode: マップのパーミッション: 読込み、書込み、実行、共有、プライベート(書き込み時コピー)
	Mapping: マップされているファイル名、または ’[ anon ]’ で動的に確保されたメモリ、または ’[ stack ]’ でプログラムスタック
	Device: デバイス名 (メジャー:マイナー)


### ロードアベレージを手っ取り早く知りたい。
topでも表示されるけど、メモリリークしてたりCPU使用率が100%のときは重すぎてtopが起動しないときがある。
そんなときはuptimeのほうが早く見れるのでお勧め。

	[root@localhost ]# 
	 16:26:02 up  1:21,  1 user,  load average: 0.00, 0.00, 0.00

ロードアベレージが高いと言うことは、CPU待ちかIO待ちのプロセスが多いと言うこと。
サーバが遅いなどの問題が見受けられたら、まずはロードアベレージを確認すると良い。
システムの稼動時間が知りたい。

uptimeで確認可能。

	[root@localhost ~]# uptime
	 09:48:55 up 1 day, 16:20,  3 users,  load average: 0.04, 0.01, 0.00

ろくに監視していないサーバをずっと起動しているとある日突然リブートしていたりするので、そういった事象が発生していないかどうか確認するために使ったりする。


### CPU使用率を定期的に取得したい。
vmstatで取るのが一般的。
	[root@localhost ~]# vmstat 5
	procs -----------memory---------- ---swap-- -----io---- --system-- -----cpu-----
	 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
	 0  0      0 392708  10852 462084    0    0   162    12  162  285  2  0 96  1  0

procの項目：

	r　…　実行可能で、「実行キュー」に入っているプロセスの数。
	b　…　本来は実行可能なプロセスであるが、I/O待ちなどの何らかの理由で待ちとなっているプロセスの数

bの数が大きいとI/O負荷等が大きいことが予想される。
rが大きいとCPUの負荷が大きく、ユーザに遅いと感じさせている可能性がある。

systemの項目：

	in 1秒当たりの割り込みの回数
	cs 1秒当たりのコンテキストスイッチの回数
	cpuの項目：
	us　…　ユーザーが使用したCPUの割合（%）
	sy　…　システムが使用したCPUの割合（%）
	id　…　CPUアイドル時間の割合(100 - us - sy)（%）
	wa　…　IO待ち時間

もっと詳細が知りたい方は以下へ
参考：http://www.fulldigit.net/content/view/54/6/

sysstatが入っているなら、sar -u <取得間隔> でも可能。

	[root@localhost ~]# sar -p 5
	04:38:27 PM     CPU     %user     %nice   %system   %iowait    %steal     %idle
	04:38:32 PM     all      0.00      0.00      0.00      0.00      0.00    100.00
	04:38:37 PM     all      0.00      0.00      0.20      0.00      0.00     99.80 

各CPUごとの付加を知りたいなら、 sar -u -P ALL <取得間隔> を使う。


### ディスクI/O使用率を定期的に取得したい。
vmstat -d で取得可能
	[root@localhost ~]# vmstat -d 5
	disk- ------------reads------------ ------------writes----------- -----IO------
		   total merged sectors      ms  total merged sectors      ms    cur    sec
	loop7      0      0       0       0      0      0       0       0      0      0
	sr0        0      0       0       0      0      0       0       0      0      0
	sda     6753   1823  462434   56021   3086   2639   36562    9380      0     28
	dm-0    7228      0  453258   80149   5454      0   36544   16809      0     28
	dm-1     297      0    2376     619      0      0       0       0      0      0

read/writeの項目：
total　…　読み書きに成功した総数
ms　…　読み書きに使用した時間
特定のユーザの使用しているプロセスのCPU/メモリ使用率を知りたい。

top -uオプションをつけると便利。

	[root@localhost ~]# top -u oracle
	 1773 oracle    20   0  608m  13m  12m S  0.0  1.4   0:01.83 oracle
	 1775 oracle    20   0  608m  13m  11m S  0.0  1.4   0:01.87 oracle
	 /* 省略 */


### ネットワークに正常にパケットが送受信できているか確認したい。
netstat -i で確認可能。

	[root@localhost ~]# netstat -i
	Kernel Interface table
	Iface       MTU Met    RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR Flg
	eth0       1500   0     9020      0      0      0    11186      0      0      0 BMRU
	lo        16436   0     2823      0      0      0     2823      0      0      0 LRU

RXが受信、TXが送信。
OK　…　正常に送受信できたパケット数
ERR　…　送受信でエラーとなったパケット数
DRP　…　送受信時に破棄したパケット数
OVR　…　送受信時にオーバーロードしたパケット数。受信側のバッファを越えてパケット送信されたとき などがこれに該当する。
よく分からない通信エラーが出た際に確認すると、ネットワークレベルで異常があったかどうかの
確認に使用できるかも。


### ユーザのログイン履歴が知りたい
リソース監視とは直接関係ないけど、利用者がいつのまにかログインして悪さしていないかどうかを
調べることはあると思うのでついでに記載。
lastlogかlastコマンドで確認可能。
lastlogで各ユーザが最後にログインした時刻を確認でき、lastは最近ログインしたユーザの時刻を確認できる。

	[root@localhost ~]# last | head -5
	root     pts/1        10.0.2.2         Sun May 24 03:13   still logged in
	root     pts/0        10.0.2.2         Sun May 24 03:04   still logged in
	reboot   system boot  2.6.32-279.5.2.e Sun May 24 01:04 - 04:18  (03:14)
	root     pts/0        10.0.2.2         Sun May 17 15:06 - 17:18  (02:12)
	reboot   system boot  2.6.32-279.5.2.e Sun May 17 13:04 - 17:18  (04:13)
	[root@localhost ~]# lastlog -u root
	Username         Port     From             Latest
	root             pts/1    10.0.2.2         Sun May 24 03:13:15 +0200 2015```

### プロセスの親子関係が知りたい
pstree を実行すると簡単にわかる。

	[root@localhost ~]# pstree
	init─┬─VBoxService───7*[{VBoxService}]
		 ├─auditd───{auditd}
		 ├─crond
		 ├─dhclient
		 ├─fcoemon
		 ├─lldpad
		 ├─6*[mingetty]
		 ├─rpc.idmapd
		 ├─rpc.statd
		 ├─rpcbind
		 ├─rsyslogd───3*[{rsyslogd}]
		 ├─2*[sendmail]
		 ├─sshd───sshd───bash───pstree
		 └─udevd───2*[udevd]

上記の結果ではinitから各プロセスの親子関係がわかる。
