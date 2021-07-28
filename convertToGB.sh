#!/bin/bash

USAGE=$(cat<<EOF
$(basename $BASH_SOURCE) converts data sizes in Gigabytes. 
usage:
	sh $(basename $BASH_SOURCE) <input_file_path>
EOF
)

if [ $# -ne 1 ]; then
	echo "Please provide a single argument as data size (eg. - 334T or 444M)"
	echo "$USAGE"
	exit 1
fi


#funtion to convert size in GigaBytes
#
function convertToGB(){
	measurement="${1: -1}"
	if [ $measurement == "G" ];then
		echo "${1%?}"
	elif [ $measurement == "T" ];then
		val=$(echo "${1%?}")
		val=$(expr $val \* 1024)
		echo $val
	else
		echo 0
	fi
}

convertToGB $1
#echo "$USAGE"
