#!/bin/bash
#########################---Created by ThienNQ---#########################
#
#This service will get the data sent from Filebeat to Redis at the
#Forward Node according to each key type
#
# =============================== INPUTS =================================
#Change the value of LOG_TYPE to change the data collected
#
LOG_TYPE=(KEY1 KEY2)
#
# ========================== GLOBAL VARIABLES ============================
#
#DO NOT EDIT THE TEXT BELOW
#
#
#
KEY=(${LOG_TYPE[*]})
#
ERROR_1='Could not connect to Redis at 127.0.0.1:6379: Connection refused'
ERROR_2='Error: Connection reset by peer'
#
OLD_TIME="$(date +"%Y-%m-%d")"
#
# ============================= PROCESSORS ===============================

function writeData(){
        echo "$(redis-cli -r 10 LPOP "$1" | iconv -c | tr -d '\0')" | sed '/^$/d' | sed "/^$ERROR_1$/d; /^$ERROR_2$/d" >> "${DIRECTORY[$i]}$CURRENT_TIME.log"
}

function compressFile(){
        for (( i=0; i<${#KEY[*]}; i++ )); do
                gzip --best "${DIRECTORY[$i]}$OLD_TIME.log"
        done

        OLD_TIME="$CURRENT_TIME"
}

function createFile(){
        for (( i=0; i<${#KEY[*]}; i++ )); do
                touch "${DIRECTORY[$i]}$1.log"
        done
}

function main(){
        while :
        do
		REDIS_PORT=$(netstat  -lp | grep -w 'redis' 2>&1) &&  REDIS_PORT=${REDIS_PORT#*:} &&  REDIS_PORT=${REDIS_PORT%:*} &&  REDIS_PORT=${REDIS_PORT% *}
                
                if [[ $REDIS_PORT == "" ]]; then
                        if [[ $minute != $(date +"%S") ]]; then
                                minute=$(date +"%S" 2>&1)
                                echo 'Could not connect to Redis'
                        fi
                else
                        if [[ $minute != $(date +"%S") ]]; then
                                minute=$(date +"%S" 2>&1)
                                echo "Reading on port $REDIS_PORT"
                        fi

                        CURRENT_TIME="$(date +"%Y-%m-%d")"

                        for (( i=0; i<${#KEY[*]}; i++ )); do
				if [[ $CURRENT_TIME == $OLD_TIME ]]; then
	                                writeData ${KEY[$i]}
	                        else
	                                compressFile
	                                createFile $CURRENT_TIME
	                                writeData ${KEY[$i]}
	                        fi

                        done
                fi
        done
}
# =============================== START =================================

for (( i=0; i<${#LOG_TYPE[*]}; i++ )); do
        DIRECTORY[$i]="/nsm/raw_log/${LOG_TYPE[$i]}/"

        if [[ ! -d "${DIRECTORY[$i]}" ]]; then
                mkdir -p ${DIRECTORY[$i]} >>/dev/null 2>&1
        fi
done

for (( i=0; i<${#LOG_TYPE[*]}; i++ )); do
        createFile $(date +"%Y-%m-%d")
done

main
