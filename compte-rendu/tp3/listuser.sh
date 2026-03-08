#!/bin/bash

#for line in $(cat /etc/passwd); do
#	uid=$(echo $line | cut -d: -f3)
#	if [ "$uid"-gt 100 ]; then
#		echo $line | cut -d: -f1
#	fi
#done
awk -F: '$3 > 100 { print $1 }' /etc/passwd
