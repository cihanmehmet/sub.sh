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

## Used Services 
```diff
+ https://crt.sh
+ http://web.archive.org
+ https://dns.bufferover.run
+ https://www.threatcrowd.org
+ https://api.hackertarget.com
+ https://certspotter.com
+ https://jldc.me/
+ https://www.virustotal.com
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
## USAGES
### Script usage: Small scan
```powershell
./sub.sh -s example.com
```
```powershell
curl -sL bit.ly/3bUdFHv | bash /dev/stdin -s example.com
```
### Script usage: Complete scan
```powershell
./sub.sh -a example.com
```
## Automatic install of required tools
```powershell
./sub.sh -i
```
### If you already have a GO, you should make the following settings;
```powershell
nano ~/.bashrc or  nano ~/.zshrc             
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
```
```powershell
source ~/.bashrc ; source ~/.zshrc
```
### The following tools working with go language have been installed.
```powershell
go get -u github.com/projectdiscovery/subfinder/cmd/subfinder
go get -u github.com/tomnomnom/assetfinder
go get -v -u github.com/OWASP/Amass/v3/...
```
## Demo
Use this link to test sub.sh directly in your browser. Now:
###
[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/enseitankado/sub.sh&tutorial=README.md)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
## Subdomain detection terminal shortcut function
### nano ~/.zshrc
or
### nano ~/.bashrc

```powershell
function subdomain() { curl -sL bit.ly/3bUdFHv | bash /dev/stdin "$1" "$2" }
```
## Usage
```powershell
subdomain example.com
```
