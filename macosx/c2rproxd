#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Run it as root user"
	exit 1
fi

if [ "$1" == "start" ]; then
	pid=$(pgrep -f c2rprox)
	
	if [ "$pid" != "" ]; then 
		echo "Daemon already running, pid : $pid"; 
		exit 1
	fi

	nohup ./c2rprox &> ./output.log &
	
	pid=$(pgrep -f c2rprox)
	
	if [ "$pid" != "" ]; then 
		echo "Daemon running, pid : $pid"; 
		else
		echo "Problem : daemon not running"
	fi
	
fi

if [ "$1" == "stop" ]; then
	pid=$(pgrep -f c2rprox)
	
	if [ "$pid" != "" ]; then 
			kill -9 $pid
			sleep 2
		else
			echo "Daemon already stopped"
			exit 1
	fi
	
	pid=$(pgrep -f c2rprox)
	if [ "$pid" != "" ]; then 
	kill -9 $pid
			echo "Problem : daemon not stopped, pid : $pid"
		else
			echo "Daemon stopped"
	fi
	
	
fi