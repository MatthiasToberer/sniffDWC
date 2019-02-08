#!/bin/bash

if [ $# -eq 0 ]   # check if we have a target
  then
    echo "No target set! Use $0 {IP}"
    exit 0
fi

clear
printf "%s" "send M999 (reset) to duet ..."
URL_RESPONSE=`curl 'http://$1/rr_gcode?gcode=M999'`    # https://reprap.org/wiki/G-code#M999:_Restart_after_being_stopped_by_error
echo "$CURL_RESPONSE \n\n"

printf "%s" "waiting for response ...\n"
while ! ping -c1 $1 &>/dev/null
do
  #echo "waiting for duet ob $1 ... \n"
  printf "%c" "."
done

for i in 1 2 3; 
  do
    CURL_RESPONSE=`curl "http://${1}/rr_status?type=$i"`
    echo "rr_status=$i\n"
    echo "$CURL_RESPONSE \n\n"
done



printf "\n%s\n"  "duet is back..."
