#!/bin/sh

USAGE=$(cat <<-EOF
$(basename $BASH_SOURCE) changes name of all directories inside a directoy to [upper]/[lower]case.
usage:
	-h: prints this message
	-p: path to directory(default: $HOME)
	-c: case(s:small, l:large, default:s)
EOF
)
DIR=$HOME
c="s"

while [ $# -gt 0 ];
do
	case "$1" in
		'-h'|'-?' ) echo $USAGE; exit 0;;
		'-p' ) shift;
			DIR="$1"
			if [ ! -d "$DIR" ];then
				echo "$DIR is not a directory"
				exit 1
			fi
			shift;;
		'-c' ) shift;
			c="$1"
			if [[ "$c" != "s" && "$c" != "l" ]];then
				echo "unkown option for -c specified"
				exit 2
			fi
			shift;;
		 * ) shift;
			echo "Unkown Option $1"
			exit 3
	esac
done

FOLDERS=$(ls -l $DIR|grep ^d|awk '{print $NF}'|tr '\n' ' ')

for FOLDER in $FOLDERS;
do
	if [ "$c" == "l" ];then
		newCaseName=$(echo $FOLDER|tr a-z A-Z)
	else
		newCaseName=$(echo $FOLDER|tr A-Z a-z)
	fi
	mv "$DIR"/"$FOLDER" "$DIR"/"$newCaseName"
done

