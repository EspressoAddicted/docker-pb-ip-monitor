#!/bin/bash

[[ -z "${PB_TOKEN}" ]] && echo "=> PB_TOKEN is empty"

CHANGE_LOGFILE=/change.log
ADDRESS_LOGFILE=/address.log

touch $ADDRESS_LOGFILE
OLD_ADDR=$(cat $ADDRESS_LOGFILE)
CUR_ADDR=$(curl -s -6 ipconfig.io)

NOTE_MESSAGE=${NOTE_MESSAGE:-"Change Warning! Old: $OLD_ADDR, New: $CUR_ADDR"}
NOTE_TITLE=${NOTE_TITLE:-"IP Address Change"}

if [ "$OLD_ADDR" == "$CUR_ADDR" ]; then
  echo "Address: $CUR_ADDR"
else
  echo "####"
  echo "WARNING: IP address has changed!"
  echo "Old: $OLD_ADDR"
  echo "Current: $CUR_ADDR"
  echo "####"

  echo "$(date) :: Changed: Old ($OLD_ADDR), New ($CUR_ADDR)" >> $CHANGE_LOGFILE

  curl -s --header "Access-Token: $PB_TOKEN" \
    --header 'Content-Type: application/json' \
    --data-binary "{\"body\":\"$NOTE_MESSAGE\",\"title\":\"$NOTE_TITLE\",\"type\":\"note\"}" \
    --request POST \
    https://api.pushbullet.com/v2/pushes

fi

echo "$CUR_ADDR" > $ADDRESS_LOGFILE
