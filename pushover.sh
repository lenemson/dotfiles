#!/bin/bash
# Sends push notification via pushover.net
# Need a ~/.pushover.conf file containing TOKEN, USER, BASE_TITLE and URL
# usage: sh pushover.sh <title> <message>

PUSHOVER_URL="https://api.pushover.net/1/messages.json"
CONFIG_FILE="$HOME/.pushover.conf"

usage() {
  echo "usage: $0 <title> <message>"
  exit 1
}

if [ -e $CONFIG_FILE ]; then
  . $CONFIG_FILE
else
  echo "Need a config file at $CONFIG_FILE with:"
  echo "TOKEN=yourapplicationtoken (https://pushover.net/apps/build)"
  echo "USER=youruserkey (https://pushover.net)"
  echo "BASE_TITLE=basetitle"
  echo "URL=anurl"
  exit 1
fi

if [ -z "$1" ] || [ -z "$2" ]; then
  usage
fi

curl -s \
  -F "token=$TOKEN" \
  -F "user=$USER" \
  -F "title=$BASE_TITLE $1" \
  -F "message=$2" \
  -F "url=$URL" \
  $PUSHOVER_URL
