#!/bin/bash

USAGE=$(cat <<-EOF
printAscii [-h] [-s] [star_val] [-e] [end_val]

-h: help
-s: decimal corresponding to the ascii
-e: decimal corresponding to ascii upto which we have to print
EOF
)

START=33
END=125

while [ "$1" != "" ];
do
	case "$1" in
		'-h') echo $USAGE;
			exit 0;;
		'-s') shift;
			START="$1"
			if [ $START -gt 125 ];then
				echo "start value greater than 125 is not valid"
				exit 1
			elif [ "$START" == "" ];then
				echo "no input value for start provided"
				exit 2
			fi
			shift;;
		'-e') shift;
			END="$1"
			if [ $END -lt 33 ];then
				echo "end value cannot be less than 33"
				exit 3
			elif [ "$END" == "" ];then
				echo "no input value for end provided"
				exit 4
			fi
			shift;;
		*) echo "unkown option :""$1"
			exit 5;;
	esac 
done
i=$START
while [ $i -lt $END ];
do
	echo $i | awk '{printf("  %3d               %c\n", $1, $1)}'
	i=$(( i + 1 ))
done
