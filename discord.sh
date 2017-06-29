#!/bin/bash
# Sends message to a discord channel
# usage: sh discord.sh <username> <message> <webhook>

usage() {
  echo "usage: $0 <username> <message> <webhook>"
  exit 1
}

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  usage
fi

curl -s \
  -F "username=$1" \
  -F "content=$2" \
  $3
