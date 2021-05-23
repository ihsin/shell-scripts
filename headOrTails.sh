#!/bin/sh

USAGE=$(cat <<-EOF
headOrTails.sh -t argument

t: no of throws of coin(default: 20)
EOF
)

THROWS=20
head=0
tails=0

echo '\n'
if [ $# -gt 2 ]; then
	echo $USAGE
fi

if [ "$1" == "-t" ];then
	shift;
	THROWS="$1"
elif [ "$1" == "" ];then
	echo "taking default value of throws: 20"
else
	echo "unkown option :""$1"
fi

printResult(){
echo "Heads count is :""$head"
echo "Tails count is :""$tails"
}

#0=HEADS
#1=TAILS

increaseCount(){
case $1 in
	0) head=$(( head + 1 ));;
	1) tails=$(( tails + 1 ));;
esac
}
i=0
while [ $i -lt $THROWS ];
do
	increaseCount $((RANDOM%2))
	i=$(( i + 1 ))
done

printResult
