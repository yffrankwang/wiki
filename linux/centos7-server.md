### timezone
    timedatectl set-timezone Asia/Tokyo


### hostname
    hostnamectl set-hostname xx.net


### user
    useradd ou
    passwd ou
    usermod -a -G wheel ou


## Network
CentOS7からはネットワーク周りの設定方法がかなり変わってきています。
CentOS6までは/etc/sysconfig/network-scripts配下のifcfg-eth*ファイルを直接編集することで設定を変更することが可能であり、
CentOS7でも継続して同様な方法で変更可能なのですが、NetworkManagerに付属する「nmtui」と「nmcli」コマンドを使用した変更方法が奨励されています。
最もわかりやすいのはnmtuiで、以前のsystem-config-networkの代替となるコマンドです。これを実行するとGUI経由でネットワーク周りの変更を実施することが可能です。

    # nmtui

上記で変更しただけでは有効にはなりませんので、以下のコマンドを実行することで変更が有効となります。

    # systemctl restart NetworkManager



上記の設定変更をコマンドベースで実施することが可能です。それが「nmcli」コマンドです。

まず以下のコマンドでデバイス(ethernet)の一覧を以下のコマンドで取得可能です。

    # nmcli device
    DEVICE  TYPE      STATE        CONNECTION
    eno1    ethernet  connected    eno1
    eno2    ethernet  unavailable  --
    lo      loopback  unmanaged    --


さらに特定のコネクションを指定し、特定インターフェイスのIPアドレスなどの概要を見ることも可能です。

    # nmcli device show eno1
    GENERAL.DEVICE:                         eno1
    GENERAL.TYPE:                           ethernet
    GENERAL.HWADDR:                         00:1A:A0:0C:A6:12
    GENERAL.MTU:                            1500
    GENERAL.STATE:                          100 (connected)
    GENERAL.CONNECTION:                     eno1
    GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveConnection/0
    WIRED-PROPERTIES.CARRIER:               on
    IP4.ADDRESS[1]:                         ip = 192.168.18.130/24, gw = 192.168.18.1
    IP4.ROUTE[1]:                           dst = 192.168.17.0/24, nh = 192.168.18.1, mt = 0
    IP4.DNS[1]:                             192.168.6.18
    IP6.ADDRESS[1]:                         ip = fe80::21a:a0ff:fe0c:a612/64, gw = ::


以下はUUIDの情報を含めたEthernetの接続一覧を見るコマンドです。

    # nmcli connection
    NAME  UUID                                  TYPE            DEVICE
    eno1  c26f3081-ec1e-47f1-ad19-69521ea9d7c1  802-3-ethernet  eno1
    eno2  4e735009-f1dd-41d5-a8ba-903fb543ded8  802-3-ethernet  --


手動でインターフェイスをActive/Deactiveに設定するには以下のコマンドを実施します。

    ※インターフェイスをActive化
    # nmcli connection up eno1

    ※インターフェイスをDeactive化 
    # nmcli connection down eno1 


さらにインターフェイス接続の詳細情報を得るにはshowオプションを利用します。nmcli deviceよりも詳細な情報を得ることが可能です。

    # nmcli connection show eno1
    connection.id:                          eno1
    connection.uuid:                        c26f3081-ec1e-47f1-ad19-69521ea9d7c1
    connection.interface-name:              --
    connection.type:                        802-3-ethernet
    connection.autoconnect:                 no
    connection.timestamp:                   1405582090
    connection.read-only:                   no
    connection.permissions:
    connection.zone:                        --
    connection.master:                      --
    connection.slave-type:                  --
    connection.secondaries:
    connection.gateway-ping-timeout:        0
    802-3-ethernet.port:                    --
    802-3-ethernet.speed:                   0
    802-3-ethernet.duplex:                  --
    802-3-ethernet.auto-negotiate:          yes
    802-3-ethernet.mac-address:             00:1A:A0:0C:A6:12
    802-3-ethernet.cloned-mac-address:      --
    802-3-ethernet.mac-address-blacklist:
    802-3-ethernet.mtu:                     auto
    802-3-ethernet.s390-subchannels:
    802-3-ethernet.s390-nettype:            --
    802-3-ethernet.s390-options:
    ipv4.method:                            manual
    ipv4.dns:                               192.168.6.18
    ipv4.dns-search:                        unix-power.net
    ipv4.addresses:                         { ip = 192.168.18.130/24, gw = 192.168.18.1 }
    ipv4.routes:
    ipv4.ignore-auto-routes:                no
    ipv4.ignore-auto-dns:                   no
    ipv4.dhcp-client-id:                    --
    ipv4.dhcp-send-hostname:                yes
    ipv4.dhcp-hostname:                     --
    ipv4.never-default:                     no
    ipv4.may-fail:                          yes
    ipv6.method:                            ignore
    ipv6.dns:
    ipv6.dns-search:
    ipv6.addresses:
    ipv6.routes:
    ipv6.ignore-auto-routes:                no
    ipv6.ignore-auto-dns:                   no
    ipv6.never-default:                     no
    ipv6.may-fail:                          yes
    ipv6.ip6-privacy:                       -1 (unknown)
    ipv6.dhcp-hostname:                     --
    GENERAL.NAME:                           eno1
    GENERAL.UUID:                           c26f3081-ec1e-47f1-ad19-69521ea9d7c1
    GENERAL.DEVICES:                        eno1
    GENERAL.STATE:                          activated
    GENERAL.DEFAULT:                        yes
    GENERAL.DEFAULT6:                       no
    GENERAL.VPN:                            no
    GENERAL.ZONE:                           --
    GENERAL.DBUS-PATH:                      /org/freedesktop/NetworkManager/ActiveConnection/0
    GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/Settings/1
    GENERAL.SPEC-OBJECT:                    --
    GENERAL.MASTER-PATH:                    --
    IP4.ADDRESS[1]:                         ip = 192.168.18.130/24, gw = 192.168.18.1
    IP4.DNS[1]:                             192.168.6.18
    IP6.ADDRESS[1]:                         ip = fe80::21a:a0ff:fe0c:a612/64, gw = ::


上記のパラメータを修正したい場合の一例を下記に示します。

    ※IPアドレスを192.168.0.130, GWを192.168.0.1に変更
    # nmcli connection modify eno1 ipv4.addresses "192.168.0.130/24 192.168.0.1"

    ※DNSサーバを192.168.0.1と2に変更
    # nmcli connection modify eno1 ipv4.dns "192.168.0.1 192.168.0.2"

    ※StaticRouteの追加
    # nmcli connection modify eno1 ipv4.routes "192.168.17.0/24 192.168.0.1"


上記の設定変更についても、以下のコマンドを実施後、有効となります。

    # systemctl restart NetworkManager



CentOS6まではネットワーク周りのコマンドとしてifconfig / netstat / arp / routeなどのコマンドが使用されていましたが、CentOS7からはこれらは非奨励となりました。今後はiproute2というパッケージに付属しているコマンド群を使用することが奨励されています。但し、一部は上記のnmcliと重複しているものもありますので好みで使い分ければ良いと思われます。

以前までのコマンドの対比表が下記となります。

    従来 	今後 
    ifconfig  	ip addr , ip -s link 
    route  	ip route 
    arp 	ip neigh
    netstat 	ss 


昔ながらのifconfigでIPを確認する方法は今後は以下のコマンドに置き換えられます。

    # ip addr show
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host
           valid_lft forever preferred_lft forever
    2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
        link/ether 00:1a:a0:0c:a6:12 brd ff:ff:ff:ff:ff:ff
        inet 192.168.0.130/24 brd 192.168.0.255 scope global eno1
           valid_lft forever preferred_lft forever
        inet6 fe80::21a:a0ff:fe0c:a612/64 scope link
           valid_lft forever preferred_lft forever
    3: eno2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN qlen 1000
        link/ether 00:1a:a0:0c:a6:14 brd ff:ff:ff:ff:ff:ff


デバイスごとの処理パケット数の統計値を表すコマンドが下記となります。

    # ip -s link
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        RX: bytes  packets  errors  dropped overrun mcast
        624        6        0       0       0       0
        TX: bytes  packets  errors  dropped carrier collsns
        624        6        0       0       0       0
    2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT qlen 1000
        link/ether 00:1a:a0:0c:a6:12 brd ff:ff:ff:ff:ff:ff
        RX: bytes  packets  errors  dropped overrun mcast
        306310     1806     0       0       0       0
        TX: bytes  packets  errors  dropped carrier collsns
        222109     1283     0       0       0       0
    3: eno2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT qlen 1000
        link/ether 00:1a:a0:0c:a6:14 brd ff:ff:ff:ff:ff:ff
        RX: bytes  packets  errors  dropped overrun mcast
        0          0        0       0       0       0
        TX: bytes  packets  errors  dropped carrier collsns
        0          0        0       0       0       0


netstat -nrに相当するルーティングテーブルを表示するコマンドが下記となります。

    # ip route
    default via 192.168.0.1 dev eno1  proto static  metric 1024
    192.168.18.0/24 dev eno1  proto kernel  scope link  src 192.168.18.130


Macアドレスの調査などを行うarpコマンドの代替となるのが以下のコマンドです。

    # ip neigh
    192.168.18.1 dev eno1 lladdr 50:57:a8:13:a6:3f REACHABLE
    192.168.18.128 dev eno1 lladdr 00:1a:a0:0c:a2:f0 STALE


自身のサーバでどのようなサービスが稼働しているか一覧表示するコマンドが下記です。左端には全てTCPと表示されておりますが、StateのところがUNCONNとなっているのがUDP、LISTENとなっているところがTCPとなります。

    # ss -ltu
    Netid  State      Recv-Q Send-Q        Local Address:Port            Peer Address:Port
    tcp    UNCONN     0      0                         *:sunrpc                     *:*
    tcp    UNCONN     0      0                         *:ntp                        *:*
    tcp    UNCONN     0      0                 127.0.0.1:rpki-rtr                    *:*      
    tcp    UNCONN     0      0                         *:924                        *:*
    tcp    UNCONN     0      0                        :::sunrpc                    :::*
    tcp    UNCONN     0      0                        :::ntp                       :::*
    tcp    UNCONN     0      0                       ::1:rpki-rtr                   :::*      
    tcp    UNCONN     0      0                        :::924                       :::*
    tcp    LISTEN     0      128                       *:sunrpc                     *:*
    tcp    LISTEN     0      32                        *:ftp                        *:*
    tcp    LISTEN     0      128                       *:ssh                        *:*
    tcp    LISTEN     0      128                      :::sunrpc                    :::*
    tcp    LISTEN     0      128                      :::ssh                       :::*


上記の中には既に通信が確立したもの ( established ) のものは含まれておりません。確立したものを表示したい場合は-lオプションを外して使用します。

    # ss -tu
    Netid  State      Recv-Q Send-Q        Local Address:Port            Peer Address:Port
    tcp    ESTAB      0      184           192.168.18.130:ssh            192.168.210.25:53260
	

### static IP
/etc/sysconfig/network-scripts/ifcfg-enp3s0

	ONBOOT=yes
	BOOTPROTO=static
	DNS1="8.8.8.8"
	DNS2="8.8.4.4"
	DOMAIN=mydomain.com
	IPADDR=192.168.100.11
	NETMASK=255.255.255.0
	GATEWAY=192.168.100.1
