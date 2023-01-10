#!/bin/bash
# TwitCasting Live Stream Recorder

if [[ ! -n "$1" ]]; then
  echo "usage: $0 twitcasting_id [passwd] [loop|once] [interval]"
  exit 1
fi

if [[ ! -f "./livedl" ]]; then
  echo "This script depends on livedl (https://github.com/himananiito/livedl)."
  echo "Please put the binary file of livedl in the same directory first."
  exit 1
fi

INTERVAL="${4:-10}"

while true; do
  # Monitor live streams of specific user
  while true; do
    LOG_PREFIX=$(date +"[%Y-%m-%d %H:%M:%S]")
    #echo "$LOG_PREFIX Try to get current live stream of twitcasting.tv/$1"
    STREAM_API="https://twitcasting.tv/streamserver.php?target=$1&mode=client"
    (curl -s "$STREAM_API" | grep -q '"live":true') && break

    #echo "$LOG_PREFIX The stream is not available now."
    #echo "$LOG_PREFIX Retry after $INTERVAL seconds..."
    sleep $INTERVAL
  done

  # Record using MPEG-2 TS format to avoid broken file caused by interruption
  FNAME="twitcast_${1}_${2}_$(date +"%Y%m%d_%H%M%S").ts"
  pwhash="$(echo -n "${2}" | md5sum - | cut -d ' ' -f 1 )"

  echo "$LOG_PREFIX Start recording, stream saved to \"$FNAME\"."
  echo "$LOG_PREFIX Use command \"tail -f $FNAME.log\" to track recording progress."

  # Also record low resolution stream simultaneously as backup
  M3U8_URL="http://twitcasting.tv/$1/metastream.m3u8?video=1"
  ffmpeg -headers $"Cookie: wpass=$pwhash; hl=ja\r\n" -i "$M3U8_URL" -codec copy -f mpegts "backup/$FNAME" > "log/$FNAME.log" 2>&1 &

  # Start recording
  ./livedl -tcas "$1" -tcas-pw "$2" > "log/$FNAME.livedl.log" 2>&1
  
  for i in *.ts; do ffmpeg -n -i "$i" -vn -acodec copy "${i%.*}.m4a"; done

  # Exit if we just need to record current stream
  LOG_PREFIX=$(date +"[%Y-%m-%d %H:%M:%S]")
  echo "$LOG_PREFIX Live stream recording stopped."
  [[ "$3" == "once" ]] && break
done
