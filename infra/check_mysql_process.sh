#! /bin/sh

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4
mysqlpath='/usr/bin'
null="NULL"
usage1="Usage: $0 -H <host> [-P <port>] -u <user> -p <password> -c <crit_range> -w <warn_range>"

exitstatus=$STATE_WARNING #default
port="3306"
if [ -z "$1" ]; then
  echo $usage1;
  exit $STATE_UNKNOWN;
fi
while test -n "$1"; do
  case "$1" in
    -u)
      user=$2
      shift
      ;;
    -p)
      pass=$2
      shift
      ;;
    -h)
      echo $usage1;
      exit $STATE_UNKNOWN
      ;;
    -H)
      host=$2
      shift
      ;;
    -P)
      port=$2
      shift
      ;;
    -c)
      crit=$2
      shift
      ;;
    -w)
      warn=$2
      shift
      ;;
    *)
      echo "Unknown argument: $1"
      echo $usage1;
      exit $STATE_UNKNOWN
      ;;
  esac
  shift
done
if [ -z "$host" -o -z "$user" -o -z "$pass" -o -z "$crit" -o -z "$warn" -o -z "$port" ]; then
  echo "some args are not specified"
  echo $usage1;
  exit $STATE_UNKNOWN
fi

processcount=`$mysqlpath/mysql -u $user -p$pass -P $port -h $host -BNe 'show processlist' | awk '{print $5}' | grep -v Sleep | wc -l`;

echo "processcount:  $processcount"
if [ $processcount -ge $crit ]; then
  exit $STATE_CRITICAL
elif [ $processcount -ge $warn ]; then
  exit $STATE_WARNING
else
  exit $STATE_OK
fi
exit $STATE_UNKNOWN
