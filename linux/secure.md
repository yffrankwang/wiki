 ssh secure log
-----------------

	cat /var/log/secure* | grep "Failed"   | awk -F ' from ' '{print $2}' | awk '{print $1}' | sort | uniq -c | sort -b -n -r
	cat /var/log/secure* | grep "Accepted" | awk -F ' from ' '{print $2}' | awk '{print $1}' | sort | uniq -c | sort -b -n -r
