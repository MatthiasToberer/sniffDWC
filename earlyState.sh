#!/bin/bash

if [ $# -eq 0 ]   # check if we have a target
  then
    echo "No target set! Use $0 {IP}"
    exit 0
fi

clear
printf "%s" "send M999 (reset) to duet ...\n\n"
URL_RESPONSE=$(curl -s --connect-timeout 1 "http://${1}/rr_gcode?gcode=M999")    # https://reprap.org/wiki/G-code#M999:_Restart_after_being_stopped_by_error
printf "$CURL_RESPONSE\n\n"

responses=0
while [[ $responses -lt 18 ]]; do
	for i in 1 2 3; do
		CURL_RESPONSE=$(curl -s -m 1 "http://${1}/rr_status?type=$i")
		if [[ $(echo $CURL_RESPONSE | wc -c ) -gt 2 ]]; then
			printf "============================== \t rr_status=${i} \t ====================================\n"
			printf "$CURL_RESPONSE \n\n"
			responses=$((responses+1))
		fi
		sleep .1
	done
	if [[ $(echo $CURL_RESPONSE | wc -c ) -gt 2 ]]; then
		printf "\n\n============================== \t ==================== \t ====================================\n\n\n"
	fi
done

printf "\n%s\n"  "duet is back..."