#!/bin/bash
# Cron job that checks if disk usage exceed a certain %
# If so, sends a push notification via pushover.net
# example:
# 0 * * * * sh ~/bin/probes/disk-usage.sh /dev/vda 50

PUSHOVER=$(which pushover)

usage() {
  echo "usage: $0 <disk> <max-amount>"
  exit 1
}

if [ ! -x "$PUSHOVER" ]; then
  echo "pushover executable not found in PATH"
  echo "hint: mv ~/.dotfiles/pushover.sh ~/bin && chmod +x ~/bin/pushover"
  exit 1
fi

if [ -z "$1" ] || [ -z "$2" ]; then
  usage
fi

DISK_USAGE=$(df $1 | tail -1 | awk '{print $5}' | cut -d "%" -f 1)

if [ "$DISK_USAGE" -ge "$2" ]; then
  $PUSHOVER "Disk usage too high" "Warning: $1 disk usage is over $2% ($DISK_USAGE%)"
fi
