#!/bin/bash
[[ -z "${TG_API_Token}" ]] && echo "ERROR: Telegram API Token is empty or miss-configured!"
[[ -z "${TG_Chat_ID}" ]] && echo "ERROR: Telegram ChatID is empty or miss-configured!"

OLD_WANIP_LOG=./Archive_WANIP.log
CURRENT_WANIP_LOG=./Current_WANIP.log

touch $CURRENT_WANIP_LOG
OLD_WANIP=$(cat $CURRENT_WANIP_LOG)
NEW_WANIP=$(curl -s ipconfig.io)

TG_TITLE=${TG_TITLE:-":: <b>WAN IP Changed</b> ::%0A"}
TG_MESSAGE=${TG_MESSAGE:-"We inform you that your WAN IP has been changed from: $OLD_WANIP to: $NEW_WANIP"}

if [ "$OLD_WANIP" == "$NEW_WANIP" ]; then
  echo "**************************************************"
  echo "$(date)"
  echo "No changes in WAN IP address: $NEW_WANIP"
  echo "**************************************************"
else
  echo "**************************************************"
  echo "$(date)"
  echo "WARNING: WAN IP address has changed!"
  echo "Old WAN IP: $OLD_WANIP"
  echo "Current WAN IP: $NEW_WANIP"
  echo "**************************************************"

  echo "$(date) :: Changed: Old ($OLD_WANIP), New ($NEW_WANIP)" >> $OLD_WANIP_LOG

  TG_API_ENDPOINT="https://api.telegram.org/bot${TG_API_Token}/sendMessage"                                                                                
  curl -s -X POST $TG_API_ENDPOINT -d chat_id="${TG_Chat_ID}" -d text="${TG_TITLE}${TG_MESSAGE}" -d parse_mode="html" 

  echo " "
  echo "Telegram message send into ChatID: ${TG_Chat_ID}"
fi

echo "$NEW_WANIP" > $CURRENT_WANIP_LOG