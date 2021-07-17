#!/bin/bash

USAGE=$(cat <<-EOF
$(dirname $BASH_SOURCE) changes the current directory as root directory.
EOF
)



if [ $UID -ne 0 ];then
	echo "Only root can execute this script."
	echo $USAGE
	exit 1
fi

arr=( "$(ldd $(which sh)|cut -d '>' -f 2|awk '{print $1}' |tr '\n' ' ')" )

SH=$(which sh)
mkdir bin
cp $SH ./bin/ 

for lib in $arr
do
	stat $lib 1>/dev/null 2>&1
	[ $? -ne 0 ] && continue
	DIR=$(dirname $lib)
	mkdir -p ".""$DIR"
	cp $lib ".""$DIR"
done

chroot .
