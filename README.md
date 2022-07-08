# Multithreaded Subdomain Detection Script 
Forked from  https://github.com/cihanmehmet/sub.sh
Required tools: jq,parallel,wget,goLang,amass,findomain,subfinder and assetfinder

# UPDATES MADE by ME

* httprobe tool avoided. Used name servers for verifying subdomains ınstead of checking 80/443. 
* Some ogical improvements to file and output to screen.
* From Go version 1.18 'go get' command will no longer install the packages. Make use of 'go install' instead.


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
## Used Passive/Active Scan Tool
+ Amass
+ Findomain
+ Subfinder
+ Assetfinder
```
## USAGES
### Script usage: Small Scan
```powershell
./sub.sh -s example.com
```
```powershell
curl -sL bit.ly/3bUdFHv | bash /dev/stdin -s example.com
```
### Script usage: All Scan
```powershell
./sub.sh -a example.com
```
##  🔸 Required tool automatic install
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
go get -u github.com/tomnomnom/httprobe
go get -u github.com/projectdiscovery/subfinder/cmd/subfinder
go get -u github.com/tomnomnom/assetfinder
go get -v -u github.com/OWASP/Amass/v3/...
```
## Demo
Use this link to test Sub.sh directly in your browser:
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
## 💡 Usage
```powershell
subdomain example.com
```
