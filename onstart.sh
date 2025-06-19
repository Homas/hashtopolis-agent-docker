#!/bin/bash

MESSAGE="Hashtopolis agent is starting $VAST_CONTAINERLABEL"

# Check if a message was provided.
if [ -z "$MESSAGE" ]; then
    echo "Usage: $0 \"<message>\""
    exit 1
fi

# --- Send Notification ---
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    --data "chat_id=$CHAT_ID" \
    --data "text=$MESSAGE" > /dev/null

# Check if the notification was sent successfully.
if [ $? -eq 0 ]; then
    echo "Notification sent successfully."
else
    echo "Failed to send notification."
fi


cp -u /root/hashtopolis.zip /root/agent-python
cd /root/agent-python
python3 /root/agent-python/hashtopolis.zip --url $HASHTOPOLIS_URL --voucher $HASTOPOLIS_VOUCHER

