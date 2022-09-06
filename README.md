# Multithreaded subdomain enumeration script 
 Forked from  https://github.com/cihanmehmet/sub.sh

 Required tools: jq,parallel,wget,goLang,amass,findomain,subfinder and assetfinder

# Updates that I made

* Used name servers for verifying subdomains ınstead of checking 80/443 (httprobe avoided).
* Some ortopedical improvements about outputs (file and screen).
* Updated depricated install method of go.
* Amass runs in passive mode in short scan (-s) otherwise runs in active brute mode.
* VirusTotal removed because of CAPTCHA protection
* CertSpotter API service updated

## Used Services & Tools
```
+ https://crt.sh
+ http://web.archive.org
+ https://dns.bufferover.run
+ https://www.threatcrowd.org
+ https://api.hackertarget.com
+ https://certspotter.com
+ https://jldc.me/
+ https://otx.alienvault.com
+ https://urlscan.io
+ https://api.threatminer.org
+ https://ctsearch.entrust.com
+ https://riddler.io
+ https://dnsdumpster.com
+ https://rapiddns.io
+ Amass
+ Findomain
+ Subfinder
+ Assetfinder
```
## INSTALL
```powershell
git clone https://github.com/enseitankado/sub.sh
cd sub.sh/
./sub.sh -i
```
## USAGES
### Small scan
```powershell
./sub.sh -s example.com
```
```powershell
curl -sL bit.ly/3bUdFHv | bash /dev/stdin -s example.com
```
### Complete scan
```powershell
./sub.sh -a example.com
```
### Command Line Help
```powershell
./sub.sh -h
```
### Usufull tips
```bash
# STEP-1: To enumerate a domain list first eliminate dublicateds (e.g: domain.lst)
cat domains.lst | sort -u > domains-unique.lst
# and supply line by line to sub.sh
for d in $(cat domains-unique.lst); do ./sub.sh -a $d; done
# STEP-2: after enumeration completed first remove all*.txt (if you want backup first)
rm all*.txt
# and collect subdomains list in a file
cat *.txt > all-subs.lst
# then remove dublicateds
cat all-subs.lst | sort -u > all-subs-uniq.lst

```
## Demo
Use this link to test sub.sh directly in your browser. Dont forget install required tools with ./sub.sh -i Now:
###
[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/enseitankado/sub.sh&tutorial=README.md)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
