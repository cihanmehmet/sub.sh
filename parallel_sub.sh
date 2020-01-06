#!/bin/bash

echo "Online Subdomain Detect Script"
echo "Twitter => https://twitter.com/cihanmehmets"
echo "Github => https://github.com/cihanmehmet"
echo "Curl Subdomain Execute =>"
echo "curl -sL https://raw.githubusercontent.com/cihanmehmet/sub.sh/master/parallel_sub.sh | bash -s bing.com"
echo "curl -sL https://git.io/Jebz5 | bash -s bing.com"
echo "████████████████████████████████████████████████████████████████████████████████████████████████"
#https://termbin.com/rze9
if [[ $# -eq 0 ]] ;
then
	echo "Usage: bash sub.sh bing.com"
	#required => jq,parallel,httprobe 
	exit 1
else

	function 1crt() {
		curl -s 'https://crt.sh/?q=%.'$1'&output=json' | jq '.[] | {name_value}' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u |grep "name_value"|cut -d ' ' -f4 >crt_$1.txt
		echo "[+] Crt.sh Over"
	}
	function 2warchive() {
		curl -s "http://web.archive.org/cdx/search/cdx?url=*."$1"/*&output=text&fl=original&collapse=urlkey" |sort| sed -e 's_https*://__' -e "s/\/.*//" -e 's/:.*//' -e 's/^www\.//' | uniq>warchive_$1.txt
		echo "[+] Web.Archive.org Over"
	}
	function 3dnsbuffer() {
		curl -s "https://dns.bufferover.run/dns?q=."$1 | jq -r .FDNS_A[]|cut -d',' -f2|sort -u >dnsbuffer_$1.txt
		echo "[+] Dns.bufferover.run Over"
	}
	function 4threatcrowd() {
		curl -s "https://www.threatcrowd.org/searchApi/v2/domain/report/?domain=$1"|jq .subdomains|grep -o "\w.*$1" >threatcrowd_$1.txt
		echo "[+] Threatcrowd.org Over"
	}
	function 5hackertarget() {
		curl -s "https://api.hackertarget.com/hostsearch/?q=$1"|grep -o "\w.*$1">hackertarget_$1.txt
        echo "[+] Hackertarget.com Over"
	}
	function 6certspotter() {
		curl -s "https://certspotter.com/api/v0/certs?domain="$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1 >certspotter_$1.txt
		echo "[+] Certspotter.com Over"
		echo "[i] Next 3 operations are waiting a bit.(Amass, Subfinder and Findomain)"
	}
	function 7amass() {
		curl -s  -X POST --data "url=$1&Submit1=Submit" https://suip.biz/?act=amass | grep $1 | cut -d ">" -f 2 | awk 'NF' | uniq>amass_$1.txt
		echo "[+] Suip.biz Amass Over"
	}
	function 8subfinder() {
		curl -s  -X POST --data "url=$1&Submit1=Submit" https://suip.biz/?act=subfinder | grep $1 | cut -d ">" -f 2 | awk 'NF' | uniq >subfinder_$1.txt
		echo "[+] Suip.biz Subfinder Over"
	}
	function 9findomain() {
		curl -s -X POST --data "url=$1&only_resolved=1&Submit1=Submit" https://suip.biz/?act=findomain| grep $1 | cut -d ">" -f 2 | awk 'NF' |egrep -v "[[:space:]]"|uniq>findomain_$1.txt
		echo "[+] Suip.biz Findomain Over"
	}
    
	export -f 1crt  && export -f 2warchive && export -f 3dnsbuffer  && export -f 4threatcrowd  && export -f 5hackertarget  && export -f 6certspotter  && export -f 7amass &&  export -f 8subfinder 
export -f 9findomain
	parallel ::: 1crt 2warchive 3dnsbuffer 4threatcrowd 5hackertarget 6certspotter 7amass 8subfinder 9findomain ::: $1
  
	echo "- - - - - - - - - - - - - - - - - DETECT $1 ALIVE SUBDOMAIN - - - - - - - - - - - - - - - - - -"
	cat crt_$1.txt warchive_$1.txt dnsbuffer_$1.txt threatcrowd_$1.txt hackertarget_$1.txt certspotter_$1.txt amass_$1.txt subfinder_$1.txt findomain_$1.txt|egrep -v "//|:|," |sort -u > no_resolve_$1.txt

	rm crt_$1.txt warchive_$1.txt dnsbuffer_$1.txt threatcrowd_$1.txt hackertarget_$1.txt certspotter_$1.txt amass_$1.txt subfinder_$1.txt findomain_$1.txt
	
	cat no_resolve_$1.txt|httprobe -t 15000 -c 50|cut -d "/" -f3|sort -u |tee $1.txt 

	echo "████████████████████████████████████████████████████████████████████████████████████████████████"
	echo "Detect Subdomain $(wc -l no_resolve_$1.txt|awk '{ print $1 }' )" "=> ${1}"
	echo "File Location : "$(pwd)/"no_resolve_$1.txt"
	echo "Detect Alive Subdomain $(wc -l $1.txt|awk '{ print $1 }' )" "=> ${1}"
	echo "File Location : "$(pwd)/"$1.txt"
fi
