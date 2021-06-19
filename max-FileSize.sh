#!/bin/sh

USAGE=$(cat <<-EOF
$(basename $BASH_SOURCE) checks for file for max size in a directory
usage: $(basename $BASH_SOURCE) <directory_path> 
EOF
)
DIR=$HOME

if [ $# -gt 1 ];then
	echo $USAGE
	exit 1
fi

if [ -d "$1" ];then
	DIR="$1"
else
	echo $USAGE
	exit 2
fi

getFilewithMaxSize(){
find $DIR -type f -exec du {} \;|sort -n|tail -n 1
}

getFilewithMaxSize $DIR
