#!/bin/bash

file=$1
interval=$2
file_time=-1
status=0

# Statuskoder
# 0 -> fil eksisterer ikke
# 1 -> fil eksisterer

echo "Overvåker filen $file"

if [ -f $file ]
then
	echo "Filen $file eksisterer allerede."
	status=1
	file_time=$(stat -f "%m" $file)
else
	echo "Filen $file eksisterer ikke."
	status=0
	file_time=-1
fi

while true
do	
	if [ -f $file ] && [ $status == 0 ]
	then 
		echo "Filen $file ble opprettet."
		file_time=$(stat -f "%m" $file)
		status=1
		continue
	fi

	if [ ! -f $file ] && [ $status == 1 ]
	then
		echo "Filen $file ble slettet."
		file_time=-1
		status=0
		continue	
	fi
	
	if [ $status = 1 ] && [ $file_time != $(stat -f "%m" $file) ] 
	then
		echo "Filen $file ble endret."
		file_time=$(stat -f "%m" $file)
		status=1
		continue
	fi
	
	sleep $interval
done
