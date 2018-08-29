#!/bin/bash

fil=$1

read -p "Hvilken hendelse? " hendelse

resultat="$(grep "$hendelse" $fil | cut -f2 -d$'\t')"
echo $resultat
