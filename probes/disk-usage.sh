#!/bin/bash
# Cron job that checks if disk usage exceed a certain %
# If so, sends a push notification via pushover.net
# example:
# 0 * * * * sh ~/bin/probes/disk-usage.sh /dev/vda 50 https://discordapp.com/api/webhook/dqdqw

DISCORD=$(which discord)

usage() {
  echo "usage: $0 <disk> <max-amount> <webhook>"
  exit 1
}

if [ ! -x "$DISCORD" ]; then
  echo "Discord executable not found in PATH"
  echo "hint: mv ~/.dotfiles/discord.sh ~/bin && chmod +x ~/bin/discord"
  exit 1
fi

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  usage
fi

DISK_USAGE=$(df $1 | tail -1 | awk '{print $5}' | cut -d "%" -f 1)

if [ "$DISK_USAGE" -ge "$2" ]; then
  $DISCORD "$(uname -n) disk usage" ":warning: `$1` disk usage is over $2% ($DISK_USAGE%)" $3
fi
