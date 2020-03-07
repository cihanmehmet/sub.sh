# 🎯🕸📘 Online Subdomain Detect Script [![CMD](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome)

## ✨ 🔺Sub.sh but without API key 🔻

## https://github.com/cihanmehmet/sub.sh

## ‼️ [jq](https://stedolan.github.io/jq/download/) and [httprobe](https://github.com/tomnomnom/httprobe) required 📌


## Linux Install (Debian,Kali Linux,Ubuntu) 
```bash
sudo apt-get install jq
```

### MAC OSX Install
```bash
brew install jq
```
## 📘 ✅Used Services 
#### https://crt.sh
#### http://web.archive.org
#### https://dns.bufferover.run
#### https://www.threatcrowd.org
#### https://api.hackertarget.com
#### https://certspotter.com
#### [https://suip.biz(Amass,Subfinder,Findomain)](https://suip.biz)

## USAGE 💡

### Script Usage 🎯

```bash
bash sub.sh webscantest.com
```

```bash
./sub.sh webscantest.com
```
![image](https://i.ibb.co/w7rhqbs/sub-sh.png)

### Curl Usage 🎯
```bash
curl -sL https://raw.githubusercontent.com/cihanmehmet/sub.sh/master/sub.sh | bash -s webscantest.com
```
### 🔖 Curl shortened link usage
```
curl -sL https://git.io/JesKK | bash -s tesla.com
```
![image](https://i.ibb.co/WGPmsBx/curl.png)

- - -
# 🧱🔨 Multiprocessing(Parallel) Subdomain Detect 
## ‼️ [jq](https://stedolan.github.io/jq/download/) , [httprobe](https://github.com/tomnomnom/httprobe) and [parallel](https://www.gnu.org/software/parallel/parallel_tutorial.html) required 📌

#### Debian Install `apt install parallel`
#### Mac OSX Install `brew install parallel`

```bash
bash parallel_sub.sh bing.com
```

```bash
curl -sL https://git.io/Jebz5|bash -s bing.com
```

- - -

### Subdomain Alive Check 🎯

```bash
bash sub_alive.sh bing.com
```

```bash
curl -sL https://raw.githubusercontent.com/cihanmehmet/sub.sh/master/sub_alive.sh | bash -s bing.com
```

## ‼️ fping required

![image](https://i.ibb.co/5K7BWbQ/alive.png)

- - -

## 🔓 Nmap -sn (No port scan) scan live IP detection script
```
fping -f ip.txt
```
## Usage ```bash nmap_sn.sh ip.txt```
<img width="437" alt="ping" src="https://user-images.githubusercontent.com/7144304/65437229-f7390e80-de12-11e9-8a7e-a74325432284.png">

```bash
#!/bin/bash

nmap -sn -iL $1 |grep "Nmap scan report for"|grep -Eo "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"|sort -u |tee $1.txt

echo "Detect IP $(wc -l $1.txt|awk '{ print $1 }' )" "=> result_${1}" "saved"
echo "File Location : "$(pwd)/"result_$1"

```
- - -

## 🔑 Other Resources for subdomain Detection
📜 DNSGEN Generates combination of domain names from the provided input.
:cyclone: [dnsgen](https://github.com/ProjectAnte/dnsgen)

### DNSGEN install
```
pip install dnsgen
```
- - -

## 🔖 Sample usage 
### Usage 1(fping)[fping](https://github.com/schweikert/fping) 🎯
```bash
cat domains.txt | dnsgen - |fping|grep "alive"|cut -d " " -f1>resolvers.txt
```
### Usage 2([httprobe](https://github.com/tomnomnom/httprobe) ) 🎯

## Kali Linux httprobe Install 🔑
```bash
wget https://github.com/tomnomnom/httprobe/releases/download/v0.1.2/httprobe-linux-amd64-0.1.2.tgz
```
` bash tar -xvzf httprobe-linux-amd64-0.1.2.tgz `

` cp httprobe /usr/local/bin `

` chmod +x /usr/local/bin/httprobe`

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
## Tool Usage
```bash
cat domains.txt | dnsgen - |httprobe|cut -d "/" -f3|sort -u |tee resolvers.txt
```
```bash
dnsgen domain.txt -w subdomains-10000.txt|httprobe|cut -d "/" -f3|sort -u |tee dnsgen.txt
```
```
pip3 install ludicrousdns 
```
```bash
cat domain.txt|ludicrousdns resolve |cut -d " " -f1
```
<img width="645" alt="resolver" src="https://user-images.githubusercontent.com/7144304/65857924-87c0a300-e36d-11e9-91d8-59d3f5ff50c5.png">

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

## 🔑 📜 Subdomain Detect Terminal Shortcut Function
### nano ~/.zshrc
or
### nano ~/.bashrc

```bash
function subdomain() { curl -sL https://git.io/JesKK | bash -s $1 }
```
## 💡 Usage
```bash
subdomain webscantest.com
```
<img width="994" alt="subdomain" src="https://user-images.githubusercontent.com/7144304/67149562-143ef100-f29c-11e9-9ba0-1f2db208fd62.png">

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

## 🧵 Docker Usage
### https://github.com/cihanmehmet/sub.sh/issues/4

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

## :triangular_flag_on_post: 💻 I am open to suggestions for improvement.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

<table>
  <tr>
    <th><center>CMD</center></th>
  </tr>
  <tr>
    <td>
    <p align="center"><img src="https://avatars0.githubusercontent.com/u/7144304?s=400&u=4f09aca07d60b9dc0825aa5d25615cbe3840621d&v=4" alt="Cihan Mehmet DOĞAN" width="200px"/></p>
    </td>
  </tr>
  <tr>
    <td>
      <div align="center">
        <a href="https://www.linkedin.com/in/cihanmehmet/">
          <img src="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/svgs/fi-social-linkedin.svg" alt="Linkedin" width="40px"/>
        </a>
        <a href="https://twitter.com/cihanmehmets">
          <img src="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/svgs/fi-social-twitter.svg" alt="Twitter" width="40px"/>
        </a>
        <a href="https://canyoupwn.me/author/cmd/">
          <img src="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/svgs/fi-web.svg" alt="Website" width="40px"/>
        </a>
      </div>
    </td>
  </tr>
</table>

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

## :triangular_flag_on_post: 💻 I am open to suggestions for improvement.
