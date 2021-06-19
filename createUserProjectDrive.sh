#!/bin/bash

USAGE=$(cat<<-EOF
$(basename $0) creates a user and it's project drive.
usage: $(basename $0) -u <username>
EOF
)

if [ $# -lt 1 ];then
	echo $USAGE
	exit
fi

USER=""
PROJECT="project"

function addProject(){
        mkdir -p "/home/""$1""/""$PROJECT"
        chmod u+t "/home/""$1""/""$PROJECT"
}


while [ $# -gt 0 ];
do
	case "$1" in
		'-h' ) echo $USAGE;
			exit 0;;
		'-u' ) shift; USER="$1"
			getent passwd "$USER"
			[ $? -eq 0 ] && echo "$USER already exists" && exit 1
	       		if [ $USER == "" ];then
				echo "No username provided \n"
				exit 1
			fi
			shift;;
		 * ) echo "unkown option ""$1";
		 	exit 2;;
	esac
done	

useradd $USER
addProject $USER
