#!/bin/bash

echo "[i] Online Subdomain Detect Script"
echo "[t] Twitter => https://twitter.com/cihanmehmets"
echo "[g] Github => https://github.com/cihanmehmet"
echo "[#] curl -sL https://raw.githubusercontent.com/cihanmehmet/sub.sh/master/sub_alive.sh | bash -s bing.com"
echo "[#] curl -sL https://git.io/JesKK | bash -s tesla.com"
echo "████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████"

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

	curl -s "https://certspotter.com/api/v0/certs?domain="$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1 >>$1.txt

		echo "[+] Certspotter.com Over"
		echo "[i] Next 3 operations are waiting a bit.(Amass, Subfinder and Findomain)"

	curl -s  -X POST --data "url=$1&Submit1=Submit" -H 'User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.1) Gecko/20100122 firefox/3.6.1' "https://suip.biz/?act=amass"|grep -o "\w*.$1"| uniq >>$1.txt

	echo "[+] Suip.biz Amass Over"

	curl -s  -X POST --data "url=$1&Submit1=Submit" -H 'User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.1) Gecko/20100122 firefox/3.6.1' "https://suip.biz/?act=subfinder"|grep -o "\w*.$1"|cut -d ">" -f 2|egrep -v " "| uniq >>$1.txt
	
	echo "[+] Suip.biz Subfinder Over"

	curl -s -X POST --data "url=$1&Submit1=Submit" -H 'User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.1) Gecko/20100122 firefox/3.6.1' "https://suip.biz/?act=findomain"|grep -o "\w.*$1"|egrep -v " "| uniq >>$1.txt
	echo "[+] Suip.biz Findomain Over"

	
	cat $1.txt|sort -u|egrep -v "//|:|,| |_|\|@" |grep -o "\w.*$1"|tee $1.txt

	echo "██████████████████████████████████████████████████████████████████████████████████████████████████████"
	echo "Detect Subdomain $(wc -l $1.txt|awk '{ print $1 }' )" "=> ${1}"
	echo "File Location : "$(pwd)/"$1.txt"
	echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
	echo " "
	echo "[+] Checking Accessibility of Detected Domains"
	echo "  "
        #fping -f $1.txt|grep "is alive"|cut -d " " -f1>$1_alive.txt
	fping -a -f $1.txt 2>/dev/null |tee alive_$1.txt
	echo "██████████████████████████████████████████████████████████████████████████████████████████████████████"
	echo "Detect Alive Subdomain $(wc -l $1_alive.txt|awk '{ print $1 }' )" "=> ${1}"
	echo "File Location : "$(pwd)/"$1_alive.txt"	
fi
