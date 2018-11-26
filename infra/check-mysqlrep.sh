#! /bin/sh

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4
mysqlpath='/usr/bin'
null="NULL"
usage1="Usage: $0 -H <host> [-P <port>] -u <user> -p <password>"

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
    *)
      echo "Unknown argument: $1"
      echo $usage1;
      exit $STATE_UNKNOWN
      ;;
  esac
  shift
done
if [ -z "$host" -o -z "$user" -o -z "$pass" -o -z "$port" ]; then
  echo "some args are not specified"
  echo $usage1;
  exit $STATE_UNKNOWN
fi

_IFS_OLD=$IFS
IFS=''

status=`$mysqlpath/mysql -u $user -p$pass -P $port -h $host -e 'show slave status\G' 2>&1`
if [ $? -gt 0 ]
then
  echo $status | head -1
  exit $STATE_CRITICAL
fi

badcount=`echo $status | grep Running | grep No | wc -l`;
lasterror=`echo $status | grep Last_error`
IFS=$_IFS_OLD

if [ $badcount -gt 0 ]; then
  echo "NG: $lasterror"
  exit $STATE_CRITICAL
else
  echo 'OK'
  exit $STATE_OK
fi
exit $STATE_UNKNOWN
