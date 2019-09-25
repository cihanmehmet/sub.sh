#!/bin/bash

echo "Online Subdomain Detect Script"
echo "Twitter => https://twitter.com/cihanmehmets"
echo "Github => https://github.com/cihanmehmet"
echo "CURL Subdomain Execute => curl -s -L https://raw.githubusercontent.com/cihanmehmet/sub.sh/master/sub.sh | bash -s bing.com"
echo "████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████"

if [[ $# -eq 0 ]] ;
then
	echo "Usage: bash sub.sh bing.com"
	exit 1
else
	curl 'https://crt.sh/?q=%.'$1'&output=json' | jq '.[] | {name_value}' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u |grep "name_value"|cut -d ' ' -f4 > $1.txt

		echo "[+] Crt.sh Over"

	curl -s "http://web.archive.org/cdx/search/cdx?url=*."$1"/*&output=text&fl=original&collapse=urlkey" |sort| sed -e 's_https*://__' -e "s/\/.*//" -e 's/:.*//' -e 's/^www\.//' | uniq >>$1.txt

		echo "[+] Web.Archive.org Over"

	curl -s "https://dns.bufferover.run/dns?q=."$1 | jq -r .FDNS_A[]|cut -d',' -f2|sort -u >>$1.txt

		echo "[+] Dns.bufferover.run Over"

	curl -s "https://certspotter.com/api/v0/certs?domain="$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1 >>$1.txt

		echo "[+] Certspotter.com Over"
		echo "[i] Next 2 operations are waiting a bit.(Amass and Subfinder)"

	curl -s  -X POST --data "url=$1&Submit1=Submit" https://suip.biz/?act=amass | grep $1 | cut -d ">" -f 2 | awk 'NF' | uniq >>$1.txt

		echo "[+] Suip.biz Amass Over"

	curl -s  -X POST --data "url=$1&Submit1=Submit" https://suip.biz/?act=subfinder | grep $1 | cut -d ">" -f 2 | awk 'NF' | uniq >>$1.txt

		echo "[+] Suip.biz Subfinder Over"

	#sort -u $1.txt|cat
	cat $1.txt|sort|sort -u|egrep -v "^http$|https$"|tee $1.txt

	echo "██████████████████████████████████████████████████████████████████████████████████████████████████████"
	echo "Detect Subdomain $(wc -l $1.txt|awk '{ print $1 }' )" "=> ${1}"
	echo "File Location : "$(pwd)/"$1.txt"
	echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
	echo " "
	echo "[+] Checking Accessibility of Detected Domains"
	echo "  "
	fping -f $1.txt|grep "is alive"|cut -d " " -f1>$1_alive.txt
	
	echo "██████████████████████████████████████████████████████████████████████████████████████████████████████"
	echo "Detect Alive Subdomain $(wc -l $1_alive.txt|awk '{ print $1 }' )" "=> ${1}"
	echo "File Location : "$(pwd)/"$1_alive.txt"	
fi
