#!/bin/bash

for i in *.ts; do ffmpeg -nostats -y -i "$i" -vn -acodec copy "${i%.*}.m4a"; done
