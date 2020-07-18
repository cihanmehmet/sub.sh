#!/bin/bash

#-Metadata----------------------------------------------------#
#  Filename: sub.sh (v1.0.21)   (Update: 2020-05-05)          #
#-Info--------------------------------------------------------#
# Subdomain Detect Script			     	     			  #
#-URL---------------------------------------------------------#
# https://git.io/JesKK                                        #
#-------------------------------------------------------------#

GREEN="\033[1;32m"
BLUE="\033[1;36m"
RED="\033[1;31m"
RESET="\033[0m"

function banner(){
	echo -e "${RED}[i] Subdomain Detect Script ${RESET}"
	echo -e "[t] Twitter => https://twitter.com/cihanmehmets"
	echo -e "[g] Github => https://github.com/cihanmehme/sub.sh"
	echo -e "${GREEN}[#] bash sub.sh -s webscantest.com ${RESET}"
	echo -e "${BLUE}[#] curl -sL https://git.io/JesKK | bash /dev/stdin -a webscantest.com ${RESET}"
	echo -e "█████████████████████████████████████████████████████████████████"
}
#############################################################################################################
function 1crt(){
	curl -s "https://crt.sh/?q=%25.$1&output=json"| jq -r '.[].name_value' 2>/dev/null | sed 's/\*\.//g' | sort -u | grep -o "\w.*$1" > crt_$1.txt
	echo -e "[+] Crt.sh Over => $(wc -l crt_$1.txt|awk '{ print $1}')"
}
function 2warchive(){
	curl -s "http://web.archive.org/cdx/search/cdx?url=*.$1/*&output=text&fl=original&collapse=urlkey" | sort | sed -e 's_https*://__' -e "s/\/.*//" -e 's/:.*//' -e 's/^www\.//' |sort -u > warchive_$1.txt
	echo "[+] Web.Archive.org Over => $(wc -l warchive_$1.txt|awk '{ print $1}')"
}
function 3dnsbuffer(){
	curl -s "https://dns.bufferover.run/dns?q=.$1" | jq -r .FDNS_A[] 2>/dev/null | cut -d ',' -f2 | grep -o "\w.*$1" | sort -u > dnsbuffer_$1.txt
	curl -s "https://dns.bufferover.run/dns?q=.$1" | jq -r .RDNS[] 2>/dev/null | cut -d ',' -f2 | grep -o "\w.*$1" | sort -u >> dnsbuffer_$1.txt 
	curl -s "https://tls.bufferover.run/dns?q=.$1" | jq -r .Results 2>/dev/null | cut -d ',' -f3 |grep -o "\w.*$1"| sort -u >> dnsbuffer_$1.txt 
	sort -u dnsbuffer_$1.txt -o dnsbuffer_$1.txt
	echo "[+] Dns.bufferover.run Over => $(wc -l dnsbuffer_$1.txt|awk '{ print $1}')"
}
function 4threatcrowd(){
	curl -s "https://www.threatcrowd.org/searchApi/v2/domain/report/?domain=$1"|jq -r '.subdomains' 2>/dev/null |grep -o "\w.*$1" > threatcrowd_$1.txt
	echo "[+] Threatcrowd.org Over => $(wc -l threatcrowd_$1.txt|awk '{ print $1}')"
}
function 5hackertarget(){
	curl -s "https://api.hackertarget.com/hostsearch/?q=$1"|grep -o "\w.*$1"> hackertarget_$1.txt
    echo "[+] Hackertarget.com Over => $(wc -l hackertarget_$1.txt | awk '{ print $1}')"
}
function 6certspotter(){
	curl -s "https://certspotter.com/api/v0/certs?domain=$1" | jq -r '.[].dns_names[]' 2>/dev/null | grep -o "\w.*$1" | sort -u > certspotter_$1.txt
	echo "[+] Certspotter.com Over => $(wc -l certspotter_$1.txt | awk '{ print $1}')"
}
function 7anubisdb(){
		curl -s "https://jldc.me/anubis/subdomains/$1" | jq -r '.' 2>/dev/null | grep -o "\w.*$1" > anubisdb_$1.txt
 		echo "[+] Anubis-DB(jonlu.ca) Over => $(wc -l anubisdb_$1.txt|awk '{ print $1}')"
}
function 8virustotal(){
		curl -s "https://www.virustotal.com/ui/domains/$1/subdomains?limit=40"|jq -r '.' 2>/dev/null |grep id|grep -o "\w.*$1"|cut -d '"' -f3|egrep -v " " > virustotal_$1.txt
 		echo "[+] Virustotal Over => $(wc -l virustotal_$1.txt|awk '{ print $1}')"
}
function 9alienvault(){
		curl -s "https://otx.alienvault.com/api/v1/indicators/domain/$1/passive_dns"|jq '.passive_dns[].hostname' 2>/dev/null |grep -o "\w.*$1"|sort -u > alienvault_$1.txt
 		echo "[+] Alienvault(otx) Over => $(wc -l alienvault_$1.txt|awk '{ print $1}')"
}
function 10urlscan(){
	curl -s "https://urlscan.io/api/v1/search/?q=domain:$1"|jq '.results[].page.domain' 2>/dev/null |grep -o "\w.*$1"|sort -u > urlscan_$1.txt
	echo "[+] Urlscan.io Over => $(wc -l urlscan_$1.txt|awk '{ print $1}')"
}

function 11threatminer(){
	curl -s "https://api.threatminer.org/v2/domain.php?q=$1&rt=5" | jq -r '.results[]' 2>/dev/null |grep -o "\w.*$1"|sort -u > threatminer_$1.txt
	echo "[+] Threatminer Over => $(wc -l threatminer_$1.txt|awk '{ print $1}')"
}
function 12entrust(){
	 curl -s "https://ctsearch.entrust.com/api/v1/certificates?fields=subjectDN&domain=$1&includeExpired=false&exactMatch=false&limit=5000" | jq -r '.[].subjectDN' 2>/dev/null |sed 's/cn=//g'|grep -o "\w.*$1"|sort -u > entrust_$1.txt
	echo "[+] Entrust.com Over => $(wc -l entrust_$1.txt|awk '{ print $1}')"
}

function 13riddler() {
    curl -s "https://riddler.io/search/exportcsv?q=pld:$1"| grep -o "\w.*$1"|awk -F, '{print $6}'|sort -u > riddler_$1.txt
	#curl -s "https://riddler.io/search/exportcsv?q=pld:$1"|cut -d "," -f6|grep $1|sort -u >riddler_$1.txt
	echo "[+] Riddler.io Over => $(wc -l riddler_$1.txt|awk '{ print $1}')"
}

function 14dnsdumpster() {
	cmdtoken=$(curl -ILs https://dnsdumpster.com | grep csrftoken | cut -d " " -f2 | cut -d "=" -f2 | tr -d ";")
	curl -s --header "Host:dnsdumpster.com" --referer https://dnsdumpster.com --user-agent "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0" --data "csrfmiddlewaretoken=$cmdtoken&targetip=$1" --cookie "csrftoken=$cmdtoken; _ga=GA1.2.1737013576.1458811829; _gat=1" https://dnsdumpster.com > dnsdumpster.html

	cat dnsdumpster.html|grep "https://api.hackertarget.com/httpheaders"|grep -o "\w.*$1"|cut -d "/" -f7|sort -u > dnsdumper_$1.txt
	rm dnsdumpster.html
	echo "[+] Dnsdumpster Over => $(wc -l dnsdumper_$1.txt|awk '{ print $1}')"
}
function 15findomain() {
    findomain -t $1 -u findomain_$1.txt &>/dev/null
	echo "[+] Findomain Over => $(wc -l findomain_$1.txt | awk '{ print $1}')"
}
function 16subfinder() {
	subfinder -silent -d $1 -o subfinder_$1.txt &>/dev/null
	echo "[+] Subfinder Over => $(wc -l subfinder_$1.txt|awk '{ print $1}')"
}
function 17amass() {
	amass enum -passive -norecursive -noalts -d $1 -o amass_$1.txt &>/dev/null
	echo "[+] Amass Over => $(wc -l amass_$1.txt|awk '{ print $1}')"
}
function 18assetfinder() {
	assetfinder --subs-only $1 > assetfinder_$1.txt
	echo "[+] Assetfinder Over => $(wc -l  assetfinder_$1.txt|awk '{ print $1}')"
}
function 19rapiddns() {
	curl -s "https://rapiddns.io/subdomain/$1?full=1#result" | grep -oaEi "https?://[^\"\\'> ]+" | grep $1 | cut -d "/" -f3 | sort -u >rapiddns_$1.txt
	echo "[+] Rapiddns Over => $(wc -l rapiddns_$1.txt|awk '{ print $1}')"
}
#############################################################################################################
function commonToolInstall(){

	if [ -e ~/go/bin/httprobe ] || [ -e /usr/local/bin/httprobe ] || [ -e ~/go-workspace/bin/httprobe ] || [ -e ~/gopath/bin/httprobe ] ; then
	      echo -e "${BLUE}[!] httprobe already exists \n${RESET}"
	else 
		go get -u github.com/tomnomnom/httprobe
  
		echo -e "${RED}[!] httprobe installed \n${RESET}"
	fi

	if [ -e ~/go/bin/subfinder ] || [ -e /usr/local/bin/subfinder ] || [ -e ~/go-workspace/bin/subfinder ] || [ -e ~/gopath/bin/subfinder ] ; then
	      echo -e "${BLUE}[!] Subfinder already exists \n${RESET}"
	else 
		go get -u -v github.com/projectdiscovery/subfinder/cmd/subfinder
		echo -e "${RED}[!] Subfinder installed \n${RESET}"
	fi

	if [ -e ~/go/bin/assetfinder ] || [ -e /usr/local/bin/assetfinder ] || [ -e ~/go-workspace/bin/assetfinder ] || [ -e ~/gopath/bin/assetfinder ] ; then
	    echo -e "${BLUE}[!] Assetfinder already exists \n${RESET}"
	   
	else 
		go get -u github.com/tomnomnom/assetfinder
		echo -e "${RED}[!] Assetfinder installed \n${RESET}"
	fi

	if [ -e /usr/local/bin/findomain ] ; then
	   
	   echo -e "${BLUE}[!] Findomain already exists \n${RESET}"
	   
	else 
	    case "$(uname -a)" in
	        *Debian*|*Ubuntu*|*Linux*|*Fedora*)
	         	wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux
				sudo chmod +x findomain-linux
				sudo mv findomain-linux /usr/local/bin/findomain
				echo -e "${RED}[!] Findomain installed \n${RESET}"
	            ;;
	        *)
	            echo "OS Not Linux";
	            ;;
	    esac

	fi

	if [ -e /usr/bin/amass ] || [ -e /usr/local/bin/amass ] || [ -e ~/go/bin/amass ] ||  [ -e ~/go-workspace/bin/amass ] || [ -e ~/gopath/bin/amass ] ; then
	   
	   echo -e "${BLUE}[!] Amass already exists \n${RESET}"
	   
	else 
	    case "$(uname -a)" in
	        *Fedora*)
				
				wget https://github.com/OWASP/Amass/releases/download/v3.5.5/amass_v3.5.5_linux_amd64.zip -O /tmp/amass.zip
				unzip /tmp/amass.zip
				sudo mv /tmp/amass_v3.5.5_linux_amd64/amass /usr/local/bin/amass
				sudo chmod +x /usr/local/bin/amass
				rm -rf /tmp/amass_v3.5.5_linux_amd64/ amass.zip
				echo -e "${RED}[!] Amass installed \n${RESET}"
				#git clone https://github.com/OWASP/Amass.git
				#go get -v -u github.com/OWASP/Amass/v3/...
	            ;;
	        *)
	            echo "OS Not Fedora";
	            ;;
	    esac

	fi

}
#############################################################################################################
function installDebian(){ #Kali and Parrot Os
    sudo apt-get update -y
    sudo apt list --upgradable
    sudo apt install jq amass -y;
    sudo apt install parallel -y;
    echo -e "${RED}[!] Debian Tool Installed \n${RESET}"
    commonToolInstall;
    echo -e "${BLUE}[!] Common Tool Installed \n${RESET}"
    source ~/.bashrc ~/.zshrc;
}
function installOSX(){
	brew update
	brew install jq findomain
	brew tap caffix/amass
	brew install amass
	brew install parallel
	echo -e "${GREEN}[!] MAC-OSX Tool Installed \n${RESET}"
	commonToolInstall
	brew cleanup
	source ~/.bashrc ~/.zshrc;
}
function installFedora(){
    sudo yum -y update
    sudo yum install jq;
    sudo yum install parallel;
	commonToolInstall

	source ~/.bashrc ~/.zshrc;
}

function install(){
    case "$(uname -a)" in
        *Debian*|*Ubuntu*|*Linux*)
            installDebian;
            ;;
        *Fedora*)
            installFedora;
            ;;
        *Darwin*)
            installOSX;
            ;;
        *)
            echo "Unable to detect an operating system that is compatible with Sub.sh...";
            ;;
    esac
    echo "  "
    echo "[+] Installation Complete jq,parallel,httprobe,amass,findomain,assetfinder";
}
#############################################################################################################
function subsave(){
	cat no_resolve_$1.txt|httprobe -c 50 > httprobe_$1.txt
	cat httprobe_$1.txt|cut -d "/" -f3|sort -u|tee $1.txt
	#-----------------------------------------------------------------------------------
	echo -e "█████████████████████████████████████████████████████████████████"
	echo -e "[*] Detect Subdomain $(wc -l no_resolve_$1.txt|awk '{ print $1}' )" "=> ${1}"
	echo -e "[+] File Location : "$(pwd)/"no_resolve_$1.txt"
	echo -e "[*] Detect Alive Subdomain $(wc -l $1.txt|awk '{ print $1 }' )" "=> ${1}"
	echo -e "[+] File Location : "$(pwd)/"$1.txt"
	echo -e "${RED}[H] Httprobe File Location : "$(pwd)/"httprobe_$1.txt ${RESET}"
}
#############################################################################################################
while [[ "${#}" -gt 0  ]]; do
args="${1}";
  	case "$( echo ${args} | tr '[:upper:]' '[:lower:]' )" in

		-s|--speed|--small)
			banner
			export -f 1crt  && export -f 2warchive && export -f 3dnsbuffer  && export -f 4threatcrowd  && export -f 5hackertarget  && export -f 6certspotter && export -f 7anubisdb && export -f 8virustotal && export -f 9alienvault && export -f 10urlscan && export -f 11threatminer && export -f 12entrust && export -f 13riddler && export -f 14dnsdumpster && export -f 19rapiddns

			parallel ::: 1crt 2warchive 3dnsbuffer 4threatcrowd 5hackertarget 6certspotter 7anubisdb 8virustotal 9alienvault 10urlscan 11threatminer 12entrust 13riddler 14dnsdumpster 19rapiddns ::: $2	
			
			echo "———————————————————————— $2 SUBDOMAIN—————————————————————————————————"
			cat crt_$2.txt warchive_$2.txt dnsbuffer_$2.txt threatcrowd_$2.txt hackertarget_$2.txt certspotter_$2.txt anubisdb_$2.txt virustotal_$2.txt alienvault_$2.txt urlscan_$2.txt threatminer_$2.txt entrust_$2.txt riddler_$2.txt dnsdumper_$2.txt rapiddns_$2.txt | sort -u | grep -v "@" | egrep -v "//|:|,| |_|\|/"|grep -o "\w.*$2"|tee no_resolve_$2.txt
			echo "- - - - - - - - - - - - - $2 ALIVE SUBDOMAIN - - - - - - - - - - - - -"
			rm crt_$2.txt warchive_$2.txt dnsbuffer_$2.txt threatcrowd_$2.txt hackertarget_$2.txt certspotter_$2.txt anubisdb_$2.txt virustotal_$2.txt alienvault_$2.txt urlscan_$2.txt threatminer_$2.txt entrust_$2.txt riddler_$2.txt dnsdumper_$2.txt rapiddns_$2.txt
			subsave $2
			shift
			;;

		-a|--all)
			banner
			export -f 1crt  && export -f 2warchive && export -f 3dnsbuffer  && export -f 4threatcrowd  && export -f 5hackertarget  && export -f 6certspotter && export -f 7anubisdb && export -f 8virustotal && export -f 9alienvault && export -f 10urlscan && export -f 11threatminer && export -f 12entrust && export -f 13riddler && export -f 14dnsdumpster && export -f 15findomain && export -f 16subfinder && export -f 17amass && export -f 18assetfinder && export -f 19rapiddns 

			parallel ::: 1crt 2warchive 3dnsbuffer 4threatcrowd 5hackertarget 6certspotter 7anubisdb 8virustotal 9alienvault 10urlscan 11threatminer 12entrust 13riddler 14dnsdumpster 15findomain 16subfinder 17amass 18assetfinder 19rapiddns ::: $2	

			echo "———————————————————————— $2 SUBDOMAIN—————————————————————————————————"
			cat crt_$2.txt warchive_$2.txt dnsbuffer_$2.txt threatcrowd_$2.txt hackertarget_$2.txt certspotter_$2.txt anubisdb_$2.txt virustotal_$2.txt alienvault_$2.txt urlscan_$2.txt threatminer_$2.txt entrust_$2.txt riddler_$2.txt dnsdumper_$2.txt findomain_$2.txt subfinder_$2.txt amass_$2.txt assetfinder_$2.txt rapiddns_$2.txt | sort -u| grep -v "@" | egrep -v "//|:|,| |_|\|/"|grep -o "\w.*$2"|tee no_resolve_$2.txt

			echo "- - - - - - - - - - - - - $2 ALIVE SUBDOMAIN - - - - - - - - - - - - -"
			
			rm crt_$2.txt warchive_$2.txt dnsbuffer_$2.txt threatcrowd_$2.txt hackertarget_$2.txt certspotter_$2.txt anubisdb_$2.txt virustotal_$2.txt alienvault_$2.txt urlscan_$2.txt threatminer_$2.txt entrust_$2.txt riddler_$2.txt dnsdumper_$2.txt findomain_$2.txt subfinder_$2.txt amass_$2.txt assetfinder_$2.txt rapiddns_$2.txt

			subsave $2
			shift
			;;

		-i|--install)
			banner
			install
			shift
			;;

		-h|--help|*)
			echo -e "Usage : "
			echo -e "  -i | --install   sub.sh required tool install"
			echo -e "  -s | --small     Crt, Warchive, Dnsbuffer, Threatcrowd, Hackertarget, Certspotter, Abubis-DB, Virustotal,Alienvault, Urlscan, Threatminer, entrust, Riddler, Dnsdumpster Rapiddns"
			echo -e "  -a | --all       Crt, Web-Archive, Dnsbuffer, Threatcrowd, Hackertarget, Certspotter, Anubisdb, Virustotal, Alienvault, Urlscan, Threatminer,  Entrust, Riddler, Dnsdumpster, Findomain, Subfinder, Amass, Assetfinder, Rapiddns"
			echo -e "  bash sub.sh -s testfire.net"
			echo -e "  bash sub.sh -a testfire.net"
			echo -e "  curl -sL https://git.io/JesKK | bash /dev/stdin -s webscantest.com"
			echo -e "  curl -sL https://git.io/JesKK | bash /dev/stdin -a webscantest.com"
			echo -e "  bash sub.sh -h/-help"				
			exit 1
			;;
	esac
	shift
done

# #Function Tree
# banner
## #Subdomain Data Function Name
# 1crt
# 2warchive
# 3dnsbuffer
# 4threatcrowd
# 5hackertarget
# 6certspotter
# 7anubisdb
# 8virustotal
# 9alienvault
# 10urlscan
# 11threatminer
# 12entrust
# 13riddler
# 14dnsdumpster
# 15findomain
# 16subfinder
# 17amass
# 18assetfinder
# 19rapiddns
######################
# commonToolInstall
# installDebian
# installOSX
# installFedora
# install
# subsave

# https://crt.sh
# http://web.archive.org
# https://dns.bufferover.run
# https://www.threatcrowd.org
# https://api.hackertarget.com
# https://certspotter.com
# https://jldc.me/
# https://www.virustotal.com
# https://otx.alienvault.com
# https://urlscan.io
# https://api.threatminer.org
# https://ctsearch.entrust.com
# https://riddler.io
# https://dnsdumpster.com
# http://rapiddns.io/
