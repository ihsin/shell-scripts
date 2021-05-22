#!/bin/sh


for id in $(docker ps -a -q);
do
	HOSTNAME=$(docker inspect -f '{{.Config.Hostname}}' $id)
	NAME=$(docker inspect -f '{{.Name}}' $id)
	IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $id)
	STATUS=$(docker inspect -f '{{.State.Status}}' $id)
	
	echo "###################################"
	echo "\n"
	echo "Container Name: ""$NAME"
	echo "Hostname      : ""$HOSTNAME"
	echo "IP Address    : ""$IP"
	echo "Status        : ""$STATUS"	
done
