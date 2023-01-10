#!/bin/bash

id=$1
pw=$2
if [ -z "$2" ]
then
  pw=nopw
fi

nohup ./record_twitcast.sh $1 $2 > log/$1_$2.log &
