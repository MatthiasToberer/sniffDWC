#!/bin/bash

if [ $# -eq 0 ]   # check if we have a target
  then
    echo "No target set! Use $0 {IP}"
    exit 0
fi

clear
printf "%s" "send M999 (reset) to duet ...\n\n"
URL_RESPONSE=`curl "http://${1}/rr_gcode?gcode=M999"`    # https://reprap.org/wiki/G-code#M999:_Restart_after_being_stopped_by_error
printf "$CURL_RESPONSE\n\n"

# check if we have connection
printf "waiting for response ...\n\n"
while ! ping -c1 $1 &>/dev/null
do
  #echo "waiting for duet ob $1 ... \n"
  printf "%c" "."
done

# fire up some status checks
for i in 1 2 3; 
  do
    printf "rr_status=${i}\n"
    CURL_RESPONSE=`curl "http://${1}/rr_status?type=$i"`
    printf "$CURL_RESPONSE \n\n"
done



printf "\n%s\n"  "duet is back..."
