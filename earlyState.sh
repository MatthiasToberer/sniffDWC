#!/bin/bash
printf "%s" "reset duet ..."
curl `https://$IP/rr_gcode?gcode=M999`

printf "%s" "waiting for response ..."
while ! timeout 0.2 ping -c 1 -n $1 &> /dev/null
do
    for i in 1 2 3;
      do
        CURL_RESPONSE=`curl 'http://$IP/rr_status?type=$i'`
    done
done
printf "\n%s\n"  "Duet is back..."
