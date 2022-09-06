#!/bin/bash

#-Metadata----------------------------------------------------#
#  Filename: sub.sh (v1.0.21)   (Update: 2020-05-05)          #
#  Updated by https://github.com/enseitankado/ (2022-07)      #
#-Info--------------------------------------------------------#
# Subdomain Detect Script			     	      #
#-URL---------------------------------------------------------#
# https://git.io/JesKK                                        #
# https://github.com/enseitankado/sub.sh                      #
#-------------------------------------------------------------#

GREEN="\033[1;32m"
BLUE="\033[1;36m"
RED="\033[1;31m"
WHITE="\033[1;97m"
RESET="\033[0m"


function banner(){
	echo -e ""
	echo -e "${BLUE}:'######:::::'##::::'##::::'########::::::::::::::'######:::::'##::::'##:${RESET}"
	echo -e "${BLUE}'##... ##:::: ##:::: ##:::: ##.... ##::::::::::::'##... ##:::: ##:::: ##:${RESET}"
	echo -e "${BLUE} ##:::..::::: ##:::: ##:::: ##:::: ##:::::::::::: ##:::..::::: ##:::: ##:${RESET}"
	echo -e "${BLUE}. ######::::: ##:::: ##:::: ########:::::::::::::. ######::::: #########:${RESET}"
	echo -e "${BLUE}:..... ##:::: ##:::: ##:::: ##.... ##:::::::::::::..... ##:::: ##.... ##:${RESET}"
	echo -e "${BLUE}'##::: ##:::: ##:::: ##:::: ##:::: ##::::'###::::'##::: ##:::: ##:::: ##:${RESET}"
	echo -e "${BLUE}. ######:::::. #######::::: ########::::: ###::::. ######::::: ##:::: ##:${RESET}"
	echo -e "${BLUE}:......:::::::.......::::::........::::::...::::::......::::::..:::::..::${RESET}"
	echo -e ""
	echo -e "${WHITE}[i] Subdomain reconnaissance and enumeration script started for ${1} ${RESET}"
	echo -e "[t] Original Author: => https://twitter.com/cihanmehmets"
	echo -e "[g] Original Author: => https://github.com/cihanmehme/sub.sh"
	echo -e "[t] Updated by https://twitter.com/OzgurKoca2"
	echo -e "[g] Fixed version at https://github.com/enseitankado/sub.sh"
	echo -e "${GREEN}[#] Usage: ./sub.sh -h ${RESET}"
	echo -e "${BLUE}[#] Usage: curl -sL https://bit.ly/3bUdFHv | bash /dev/stdin -a example.com ${RESET}"
	echo -e "-------------------------------------------------------------------------"
}
#############################################################################################################
function 1crt(){
	curl -s "https://crt.sh/?q=%25.$1&output=json"| jq -r '.[].name_value' 2>/dev/null | sed 's/\*\.//g' | sort -u | grep -o "\w.*$1" > crt_$1.txt
	echo -e "[+] Querying Crt.sh => $(wc -l crt_$1.txt|awk '{ print $1}')"
}
function 2warchive(){
	curl -s "http://web.archive.org/cdx/search/cdx?url=*.$1/*&output=text&fl=original&collapse=urlkey" | sort | sed -e 's_https*://__' -e "s/\/.*//" -e 's/:.*//' -e 's/^www\.//' |sort -u > warchive_$1.txt
	echo "[+] Querying Web.Archive.org => $(wc -l warchive_$1.txt|awk '{ print $1}')"
}
function 3dnsbuffer(){
	curl -s "https://dns.bufferover.run/dns?q=.$1" | jq -r .FDNS_A[] 2>/dev/null | cut -d ',' -f2 | grep -o "\w.*$1" | sort -u > dnsbuffer_$1.txt
	curl -s "https://dns.bufferover.run/dns?q=.$1" | jq -r .RDNS[] 2>/dev/null | cut -d ',' -f2 | grep -o "\w.*$1" | sort -u >> dnsbuffer_$1.txt 
	curl -s "https://tls.bufferover.run/dns?q=.$1" | jq -r .Results 2>/dev/null | cut -d ',' -f3 |grep -o "\w.*$1"| sort -u >> dnsbuffer_$1.txt 
	sort -u dnsbuffer_$1.txt -o dnsbuffer_$1.txt
	echo "[+] Querying Dns.bufferover.run => $(wc -l dnsbuffer_$1.txt|awk '{ print $1}')"
}
function 4threatcrowd(){
	curl -s "https://www.threatcrowd.org/searchApi/v2/domain/report/?domain=$1"|jq -r '.subdomains' 2>/dev/null |grep -o "\w.*$1" > threatcrowd_$1.txt
	echo "[+] Querying Threatcrowd.org => $(wc -l threatcrowd_$1.txt|awk '{ print $1}')"
}
function 5hackertarget(){
	curl -s "https://api.hackertarget.com/hostsearch/?q=$1"|grep -o "\w.*$1"> hackertarget_$1.txt
    echo "[+] Querying Hackertarget.com => $(wc -l hackertarget_$1.txt | awk '{ print $1}')"
}
function 6certspotter(){
	curl -s "https://api.certspotter.com/v1/issuances?domain=$1&include_subdomains=true&expand=dns_names" | jq -r '.[].dns_names[]' 2>/dev/null | grep -o "\w.*$1" | sort -u > certspotter_$1.txt
	echo "[+] Querying Certspotter.com => $(wc -l certspotter_$1.txt | awk '{ print $1}')"
}
function 7anubisdb(){
	curl -s "https://jldc.me/anubis/subdomains/$1" | jq -r '.' 2>/dev/null | grep -o "\w.*$1" > anubisdb_$1.txt
	echo "[+] Querying Anubis-DB(jonlu.ca) => $(wc -l anubisdb_$1.txt|awk '{ print $1}')"
}
function 8virustotal(){
# Removed at 13.8.22 because of CAPTCHA protection
#	curl -s "https://www.virustotal.com/ui/domains/$1/subdomains?limit=40"|jq -r '.' 2>/dev/null |grep id|grep -o "\w.*$1"|cut -d '"' -f3|egrep -v " " > virustotal_$1.txt
#	echo "[+] Querying VirusTotal => $(wc -l virustotal_$1.txt|awk '{ print $1}')"
#	echo "[+] Querying VirusTotal => Failed. CAPTCHA protection"
	echo "" > virustotal_$1.txt
}
function 9alienvault(){
	curl -s "https://otx.alienvault.com/api/v1/indicators/domain/$1/passive_dns"|jq '.passive_dns[].hostname' 2>/dev/null |grep -o "\w.*$1"|sort -u > alienvault_$1.txt
	echo "[+] Querying Alienvault(otx) => $(wc -l alienvault_$1.txt|awk '{ print $1}')"
}
function 10urlscan(){
	curl -s "https://urlscan.io/api/v1/search/?q=domain:$1"|jq '.results[].page.domain' 2>/dev/null |grep -o "\w.*$1"|sort -u > urlscan_$1.txt
	echo "[+] Querying Urlscan.io => $(wc -l urlscan_$1.txt|awk '{ print $1}')"
}

function 11threatminer(){
	curl -s "https://api.threatminer.org/v2/domain.php?q=$1&rt=5" | jq -r '.results[]' 2>/dev/null |grep -o "\w.*$1"|sort -u > threatminer_$1.txt
	echo "[+] Querying Threatminer => $(wc -l threatminer_$1.txt|awk '{ print $1}')"
}
function 12entrust(){
	 curl -s "https://ctsearch.entrust.com/api/v1/certificates?fields=subjectDN&domain=$1&includeExpired=false&exactMatch=false&limit=5000" | jq -r '.[].subjectDN' 2>/dev/null |sed 's/cn=//g'|grep -o "\w.*$1"|sort -u > entrust_$1.txt
	echo "[+] Querying Entrust.com => $(wc -l entrust_$1.txt|awk '{ print $1}')"
}

function 13riddler() {
    curl -s "https://riddler.io/search/exportcsv?q=pld:$1"| grep -o "\w.*$1"|awk -F, '{print $6}'|sort -u > riddler_$1.txt
	#curl -s "https://riddler.io/search/exportcsv?q=pld:$1"|cut -d "," -f6|grep $1|sort -u >riddler_$1.txt
	echo "[+] Querying Riddler.io => $(wc -l riddler_$1.txt|awk '{ print $1}')"
}

function 14dnsdumpster() {
	cmdtoken=$(curl -ILs https://dnsdumpster.com | grep csrftoken | cut -d " " -f2 | cut -d "=" -f2 | tr -d ";")
	curl -s --header "Host:dnsdumpster.com" --referer https://dnsdumpster.com --user-agent "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0" --data "csrfmiddlewaretoken=$cmdtoken&targetip=$1" --cookie "csrftoken=$cmdtoken; _ga=GA1.2.1737013576.1458811829; _gat=1" https://dnsdumpster.com > dnsdumpster.html

	cat dnsdumpster.html|grep "https://api.hackertarget.com/httpheaders"|grep -o "\w.*$1"|cut -d "/" -f7|sort -u > dnsdumper_$1.txt
	rm dnsdumpster.html
	echo "[+] Querying Dnsdumpster => $(wc -l dnsdumper_$1.txt|awk '{ print $1}')"
}
function 15findomain() {
	findomain -t $1 -u findomain_$1.txt &>/dev/null
	echo "[+] Running Findomain => $(wc -l findomain_$1.txt | awk '{ print $1}')"
}
function 16subfinder() {
	subfinder -silent -d $1 -o subfinder_$1.txt &>/dev/null
	echo "[+] Running Subfinder => $(wc -l subfinder_$1.txt|awk '{ print $1}')"
}
function 17amass_passive() {
	amass enum -passive -norecursive -noalts -d $1 -o amass_$1.txt &>/dev/null
	echo "[+] Running Amass (passive) => $(wc -l amass_$1.txt|awk '{ print $1}')"
}
function 17amass_active_brute() {
	amass enum -brute -min-for-recursive 2 -d $1 -o amass_$1.txt &>/dev/null
	echo "[+] Runningn Amass (active+brute) => $(wc -l amass_$1.txt|awk '{ print $1}')"
}

function 18assetfinder() {
	assetfinder --subs-only $1 > assetfinder_$1.txt
	echo "[+] Running Assetfinder => $(wc -l  assetfinder_$1.txt|awk '{ print $1}')"
}
function 19rapiddns() {
	curl -s "https://rapiddns.io/subdomain/$1?full=1#result" | grep -oaEi "https?://[^\"\\'> ]+" | grep $1 | cut -d "/" -f3 | sort -u >rapiddns_$1.txt
	echo "[+] Running Rapiddns => $(wc -l rapiddns_$1.txt|awk '{ print $1}')"
}

#############################################################################################################

function commonToolInstall(){

	if [ -e ~/go/bin/subfinder ] || [ -e /usr/local/bin/subfinder ] || [ -e ~/go-workspace/bin/subfinder ] || [ -e ~/gopath/bin/subfinder ] ; then
	      echo -e "${BLUE}[!] Subfinder already exists \n${RESET}"
	else 
		go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
		echo -e "${RED}[!] Subfinder installed \n${RESET}"
	fi

	if [ -e ~/go/bin/assetfinder ] || [ -e /usr/local/bin/assetfinder ] || [ -e ~/go-workspace/bin/assetfinder ] || [ -e ~/gopath/bin/assetfinder ] ; then
	    echo -e "${BLUE}[!] Assetfinder already exists \n${RESET}"
	else
		go install github.com/tomnomnom/assetfinder@latest
		echo -e "${RED}[!] Assetfinder installed \n${RESET}"
	fi

	if [ -e /usr/local/bin/findomain ] ; then
	   echo -e "${BLUE}[!] Findomain already exists \n${RESET}"
	else
	    case "$(uname -a)" in
	        *Debian*|*Ubuntu*|*Linux*|*Fedora*)
			curl -LO https://github.com/findomain/findomain/releases/latest/download/findomain-linux-i386.zip
			unzip findomain-linux-i386.zip
			chmod +x findomain
			sudo mv findomain /usr/bin/findomain
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
    echo "[+] Installation Complete jq,parallel,amass,findomain,assetfinder";
}
#############################################################################################################
function subsave(){

	echo -e ""
	echo -e "${WHITE}Validating NS records...${RESET}"
	echo -e ""
	rm -rf $1.txt
	for i in `cat all_$1.txt`
	do
		# Checking for the resolved IP address from the end of the command output. Refer
		# the normal command output of nslookup to understand why.
		resolvedIP=$(nslookup $i | awk -F':' '/^Address: / { matched = 1 } matched { print $2}' | xargs)

		# Deciding the lookup status by checking the variable has a valid IP string
		! [[ -z "$resolvedIP" ]] && echo $i >> $1.txt
	done
	echo -e ""
	echo -e "-------------------------------------------------------------------------"


	allCount=$(wc -l all_$1.txt|awk '{ print $1}')
	if [ $allCount -ne 0 ]; then
		echo -e "[*] ${WHITE}#${allCount}${RESET} subdomains detected for ${1}"
		echo -e "[+] Saved to "$(pwd)/"all_$1.txt"
	else
	        echo -e "[*] Not detected any subdomains for ${1}"
		rm -rf $(pwd)/"all_$1.txt"
	fi


	if [[ -f $1.txt ]]; then
		validCount=$(wc -l $1.txt|awk '{ print $1 }')
		echo -e ""
		echo -e "[*] ${WHITE}#${validCount}${RESET} subdomains verified live for ${1}"
		echo -e "[+] Saved to "$(pwd)/"$1.txt"
	fi
}
#############################################################################################################
while [[ "${#}" -gt 0  ]]; do
args="${1}";
  	case "$( echo ${args} | tr '[:upper:]' '[:lower:]' )" in

		-s|--speed|--small)
			banner $2
			export -f 1crt  && export -f 2warchive && export -f 3dnsbuffer  && export -f 4threatcrowd  && export -f 5hackertarget  && export -f 6certspotter && export -f 7anubisdb && export -f 8virustotal && export -f 9alienvault && export -f 10urlscan && export -f 11threatminer && export -f 12entrust && export -f 13riddler && export -f 14dnsdumpster && export -f 17amass_passive && export -f 19rapiddns

			parallel ::: 1crt 2warchive 3dnsbuffer 4threatcrowd 5hackertarget 6certspotter 7anubisdb 8virustotal 9alienvault 10urlscan 11threatminer 12entrust 13riddler 14dnsdumpster 17amass_passive 19rapiddns ::: $2

			echo -e ""
			cat crt_$2.txt warchive_$2.txt dnsbuffer_$2.txt threatcrowd_$2.txt hackertarget_$2.txt certspotter_$2.txt anubisdb_$2.txt virustotal_$2.txt alienvault_$2.txt urlscan_$2.txt threatminer_$2.txt entrust_$2.txt riddler_$2.txt dnsdumper_$2.txt amass_$2.txt rapiddns_$2.txt | sort -u | grep -v "@" | egrep -v "//|:|,| |_|\|/"|grep -o "\w.*$2"|tee all_$2.txt
			rm crt_$2.txt warchive_$2.txt dnsbuffer_$2.txt threatcrowd_$2.txt hackertarget_$2.txt certspotter_$2.txt anubisdb_$2.txt virustotal_$2.txt alienvault_$2.txt urlscan_$2.txt threatminer_$2.txt entrust_$2.txt riddler_$2.txt dnsdumper_$2.txt amass_$2.txt rapiddns_$2.txt

			subsave $2
			shift
			;;

		-a|--all)
			banner $2
			export -f 1crt  && export -f 2warchive && export -f 3dnsbuffer  && export -f 4threatcrowd  && export -f 5hackertarget  && export -f 6certspotter && export -f 7anubisdb && export -f 8virustotal && export -f 9alienvault && export -f 10urlscan && export -f 11threatminer && export -f 12entrust && export -f 13riddler && export -f 14dnsdumpster && export -f 15findomain && export -f 16subfinder && export -f 17amass_active_brute && export -f 18assetfinder && export -f 19rapiddns 

			parallel ::: 1crt 2warchive 3dnsbuffer 4threatcrowd 5hackertarget 6certspotter 7anubisdb 8virustotal 9alienvault 10urlscan 11threatminer 12entrust 13riddler 14dnsdumpster 15findomain 16subfinder 17amass_active_brute 18assetfinder 19rapiddns ::: $2	

			echo -e ""
			cat crt_$2.txt warchive_$2.txt dnsbuffer_$2.txt threatcrowd_$2.txt hackertarget_$2.txt certspotter_$2.txt anubisdb_$2.txt virustotal_$2.txt alienvault_$2.txt urlscan_$2.txt threatminer_$2.txt entrust_$2.txt riddler_$2.txt dnsdumper_$2.txt findomain_$2.txt subfinder_$2.txt amass_$2.txt assetfinder_$2.txt rapiddns_$2.txt | sort -u| grep -v "@" | egrep -v "//|:|,| |_|\|/"|grep -o "\w.*$2"|tee all_$2.txt
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
			echo -e "  -i | --install   installs required tools"
			echo -e "  -s | --small     Crt, Warchive, Dnsbuffer, Threatcrowd, Hackertarget, Certspotter, Abubis-DB, Alienvault, Urlscan, Threatminer, entrust, Riddler, Dnsdumpster Rapiddns"
			echo -e "  -a | --all       Crt, Web-Archive, Dnsbuffer, Threatcrowd, Hackertarget, Certspotter, Anubisdb, Alienvault, Urlscan, Threatminer,  Entrust, Riddler, Dnsdumpster, Findomain, Subfinder, Amass, Assetfinder, Rapiddns"
			echo -e "  bash sub.sh -s example.com"
			echo -e "  bash sub.sh -a example.com"
			echo -e "  curl -sL https://bit.ly/3bUdFHv | bash /dev/stdin -s example.com"
			echo -e "  curl -sL https://bit.ly/3bUdFHv | bash /dev/stdin -a example.com"
			echo -e "  bash sub.sh -h/-help"
			exit 1
			;;
	esac
	shift
done
