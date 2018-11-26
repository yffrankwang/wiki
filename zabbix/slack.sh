#!/bin/bash

# Slack incoming web-hook URL and user name
url='CHANGEME'		# example: https://hooks.slack.com/services/QW3R7Y/D34DC0D3/BCADFGabcDEF123
username='Zabbix'

## Values received by this script:
# To = $1 (Slack channel or user to send the message to, specified in the Zabbix web interface; "@username" or "#channel")
# Subject = $2 (usually either PROBLEM or RECOVERY)
# Message = $3 (whatever message the Zabbix action sends, preferably something like "Zabbix server is unreachable for 5 minutes - Zabbix server (127.0.0.1)")

# Get the Slack channel or user ($1) and Zabbix subject ($2 - hopefully either PROBLEM or RECOVERY)
to="$1"
subject="$2"
message="$3"
emoji=':ghost:'

# Change message emoji depending on the subject - smile (RECOVERY), frowning (PROBLEM), or ghost (for everything else)
if [[ $subject = RECOVERY ]]; then
	emoji=':smile:'
elif [[ $subject = PROBLEM ]]; then
	emoji=':frowning:'
elif [[ $subject == OK:* ]]; then
	emoji=':smile:'
elif [[ $subject == PROBLEM:* ]]; then
	emoji=':frowning:'
fi

# Build our JSON payload and send it as a POST request to the Slack incoming web-hook URL
payload="{ \"channel\": \"${to//\"/\\\"}\", \"username\": \"${username//\"/\\\"}\", \"icon_emoji\": \"${emoji}\", \"text\": \"${subject//\"/\\\"}\", \"attachments\": [{\"text\": \"${message//\"/\\\"}\"}] }"
curl -m 5 -X POST -H 'Content-type: application/json' --data "${payload}" $url
