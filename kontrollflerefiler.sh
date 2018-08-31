#!/bin/bash

# Statuskoder
# 0 -> fil eksisterer ikke
# 1 -> fil eksisterer

i=0
echo -n "Overvåker følgende filer: "
for arg
do
    echo -n "$arg "
	status[$i]=0
	i=$((i+1))
done
echo

status=
file_time=

i=0
for arg
do
	if [ -f $arg ]
	then
		echo "Filen $arg eksisterer allerede."
		status[$i]=1
		file_time[$i]=$(stat -f "%m" $arg)
	else
		echo "Filen $arg eksisterer ikke."
		status[$i]=0
		file_time[$i]=-1
	fi

	i=$((i+1))
done

while true
do	
	i=0
	for arg
	do

		#echo "$i $arg ${status[$i]} ${file_time[$i]}"

		if [ -f $arg ] && [ "${status[$i]}" == 0 ]
		then 
			echo "Filen $arg ble opprettet."
			file_time[$i]=$(stat -f "%m" $arg)
			status[$i]=1
			
			i=$((i+1))
			continue
		fi

		if [ ! -f $arg ] && [ ${status[$i]} == 1 ]
		then
			echo "Filen $arg ble slettet."
			file_time[$i]=-1
			status[$i]=0
			
			i=$((i+1))
			continue	
		fi
		
		if [ ${status[$i]} = 1 ] && [ "${file_time[$i]}" != "$(stat -f "%m" $arg)" ] 
		then
			echo "Filen $arg ble endret."
			file_time[$i]=$(stat -f "%m" $arg)
			status[$i]=1

			i=$((i+1))
			continue
       	fi

		i=$((i+1))
	done
	
	sleep 60
done
