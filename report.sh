#!/bin/bash

set -e

# incomming parameters
report_file="report.txt"

# Install the blc
blc_install(){
    git clone https://github.com/osscameroon/broken_link_checker.git blc
    pip install -r blc/requirements.txt
}

# Track the broken links
blc_track(){
    python -m blc.blc -n -d .5 -b 5 $HOST > $report_file
    # We look for an error
    for i in $(cat $report_file | grep "\w* errors" -o | grep "[0-9]*" -o)
    do
      if [ $i != 0 ]
      then
        return 0
      fi
    done
    return 1
}

# A curl to send message in a chat
blc_report(){
    echo "----------------------------------------------"
    payload="{\"chat_id\": $TELEGRAM_CHAT_ID, \"text\": \"$(cat $report_file)\"}"
    echo "msg-payload: $payload"
    echo "----------------------------------------------"

    curl -s -d "$payload" -H "Content-Type: application/json" -X POST https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage
}

# The main function to be executed
main(){
    echo "Installing of the tracker..."

    blc_install

    echo "Starting of the tracking..."

    if blc_track
    then
        echo "Sending of the report..."
        blc_report
    else
        echo "No broken links."
    fi
}

main
