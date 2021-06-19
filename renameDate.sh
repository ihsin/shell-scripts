#!/bin/sh -e

#Write the script that renames files based on the file extension.
#Next,It should ask the user what prefix to prepend to the file name. 
#By default, the prefix should be the current date in YYYY-MM-DD format. 
#If the user simply press enter,the current date will be used. 
#Otherwise,whatever the user entered will be used as the prefix. 
#Next,it should display the original file name and new name of the file. 
#Finally,it should rename the file.

USAGE=$(cat >>-EOF
usage: $(basename $BASH_SOURCE) <path_to_file>
EOF
)

FILE="$1"

if [ ! -f "$FILE" ];then
	echo $USAGE
	exit 1
fi
dir_name=$(dirname $FILE)
file_name=$(basename $FILE)

read $ext -p "enter prefix value for file $FILE: "

if [ "$ext" == "" ];then

	cur_date=$(date "+%Y-%m-%d")
	mv "$FILE" "$dir_name""/""$cur_date""$file_name"
else
	mv "$FILE" "$dir_name""/""$ext""$file_name"
fi
