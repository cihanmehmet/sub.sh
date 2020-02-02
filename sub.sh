#!/bin/bash

echo "[i] Online Subdomain Detect Script"
echo "[t] Twitter => https://twitter.com/cihanmehmets"
echo "[g] Github => https://github.com/cihanmehmet"
echo "[#] curl -sL https://raw.githubusercontent.com/cihanmehmet/sub.sh/master/sub.sh | bash -s bing.com"
echo "[#] curl -sL https://git.io/JesKK | bash -s tesla.com"
echo "███████████████████████████████████████████████████████████████████████████████████████████████"
# sub.sh version 1.0.4
if [[ $# -eq 0 ]] ;
then
	echo "Usage: bash sub.sh bing.com"
	exit 1
else
	curl -s "https://crt.sh/?q=%25."$1"&output=json"| jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u|grep -o "\w.*$1" > $1.txt

		echo "[+] Crt.sh Over"

	curl -s "http://web.archive.org/cdx/search/cdx?url=*."$1"/*&output=text&fl=original&collapse=urlkey" |sort| sed -e 's_https*://__' -e "s/\/.*//" -e 's/:.*//' -e 's/^www\.//' | uniq >>$1.txt

		echo "[+] Web.Archive.org Over"

	curl -s "https://dns.bufferover.run/dns?q=."$1 | jq -r .FDNS_A[]|cut -d',' -f2|sort -u >>$1.txt

		echo "[+] Dns.bufferover.run Over"

	curl -s "https://www.threatcrowd.org/searchApi/v2/domain/report/?domain=$1"|jq .subdomains|grep -o "\w.*$1" >>$1.txt
		echo "[+] Threatcrowd.org Over"

	curl -s "https://api.hackertarget.com/hostsearch/?q=$1"|grep -o "\w.*$1" >>$1.txt
        echo "[+] Hackertarget.com Over"

	curl -s "https://certspotter.com/api/v0/certs?domain="$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1 >>$1.txt
		echo "[+] Certspotter.com Over"
		echo "[i] Next 3 operations are waiting a bit.(Amass, Subfinder and Findomain)"

	curl -s  -X POST --data "url=$1&Submit1=Submit" https://suip.biz/?act=amass | grep $1 | cut -d ">" -f 2 | awk 'NF' | uniq >>$1.txt

		echo "[+] Suip.biz Amass Over"

	curl -s  -X POST --data "url=$1&Submit1=Submit" https://suip.biz/?act=subfinder | grep $1 | cut -d ">" -f 2 | awk 'NF' | uniq >>$1.txt

		echo "[+] Suip.biz Subfinder Over"
		
    curl -s -X POST --data "url=$1&only_resolved=1&Submit1=Submit" https://suip.biz/?act=findomain| grep $1 | cut -d ">" -f 2 | awk 'NF' |egrep -v "[[:space:]]"|uniq >>$1.txt
                
	    echo "[+] Suip.biz Findomain Over"

	echo "——————————————————————————————————$1 SUBDOMAIN————————————————————————————————————————————"
	#cat $1.txt|sort -u|egrep -v "//|:|,"|tee $1.txt
	cat $1.txt|sort -u|egrep -v "//|:|,| |_|@" |grep -o "\w.*$1"|tee $1.txt
	echo "- - - - - - - - - - - - - - - - - $1 ALIVE SUBDOMAIN - - - - - - - - - - - - - - - - - - -"
        cat $1.txt|httprobe -t 15000 -c 50|cut -d "/" -f3|sort -u |tee alive_$1.txt 
	echo "███████████████████████████████████████████████████████████████████████████████████████████"
	echo "Detect Subdomain $(wc -l $1.txt|awk '{ print $1 }' )" "=> ${1}"
	echo "File Location : "$(pwd)/"$1.txt"
	echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
	echo "Detect Alive Subdomain $(wc -l alive_$1.txt|awk '{ print $1 }' )" "=> ${1}"
	echo "File Location : "$(pwd)/"alive_$1.txt"
	
	#cat $1.txt|python -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > $1.json
        #cat alive_$1.txt|python -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" >live_$1.json

fi
