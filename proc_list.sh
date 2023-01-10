#!/bin/bash

ps -e -o pid,command | grep sh | grep record_tw | awk '{split($0,a," ");print a[1], a[4]}'
