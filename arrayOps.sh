#!/bin/sh

#./arrayOps.sh man cat dog horse cow goat
array=( $@ )

#man cat dog horse cow goat
echo ${array[@]}

#horse
echo ${array[3]}

#cat dog horse cow goat
echo ${array[@]:1}

#6
echo ${#array[@]}

#cat dog horse
echo ${array[@]:1:3}


