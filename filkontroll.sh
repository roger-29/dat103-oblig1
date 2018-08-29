#!/usr/bin/env bash
file=$1
interval=$2
existed=0
first=1

if [ -f $file ];
then
    sha1=sha1sum $file
fi

while true
    do
        if [ -f $file -a $existed = 0 -a $first = 1 ]; 
            then
                    echo "File $file exists."
                    existed=1
                    first=0

        elif [ -f $file -a $existed = 0 -a $first = 0 ]; 
            then
                echo "File $file was created."
                sleep $interval
                exit
            
        elif [ ! -f $file -a $first = 1 ]; 
            then
                echo "File $file does not exist."
                first=0

        elif [ ! -f $file -a $existed = 1 ];
            then
                echo "File $file was removed."
                sleep $interval
                exit
        fi

        if [ ! "$sha1" = "sha1sum $file" ];
            then
                echo "File $file was modified."
                #sleep $interval
                #exit
        fi

        sleep $interval
done




