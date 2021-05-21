#!/bin/sh

USAGE=$(cat <<-EOF
$(basename $BASH_SOURCE) removes contents of all files
from a directory.
usage:
 -p : path (default: /var/log)
EOF
)

DIR="/var/log"

while [ $# -gt 0 ];do
	case "$1" in
		'-h'|'-?' ) echo $USAGE; exit 0;;
		'-p' )
			shift;
			DIR="$1"
			if [ ! -d "$DIR" ]; then
				echo "$1 is not a directory"
				exit 1
			fi
			shift;;
		 * ) echo "Unknown option $1."; exit 2;;
	esac
done

FILES=$(ls -l $DIR|grep ^-|awk '{print $NF}'|tr '\n' ' ')
for file in $FILES;
do
#	echo /dev/null>$file
#	echo '\n'
	echo /dev/null>"$DIR"/"$file"
done
			

