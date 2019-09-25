#!/bin/bash

nmap -sn -iL $1 |grep "Nmap scan report for"|grep -Eo "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"|sort -u |tee $1.txt

echo "Detect IP $(wc -l $1.txt|awk '{ print $1 }' )" "=> result_${1}" "saved"
echo "File Location : "$(pwd)/"result_$1"