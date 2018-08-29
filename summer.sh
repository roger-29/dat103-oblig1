#!/bin/bash

echo "Skriv en sekvens av tall avsluttet med Ctrl+D"

sum=0
while read number
do
	sum=$(($sum+$number))
done

echo "Summen er $sum."
