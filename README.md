# 🎯🕸📘 Online Subdomain Detect Script [![CMD](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome)

## https://github.com/cihanmehmet/sub.sh

## ‼️ [jq](https://stedolan.github.io/jq/download/) required 📌

## Linux Install (Debian,Kali Linux,Ubuntu) 
```bash
sudo apt-get install jq
```

### MAC OSX Install
```bash
brew install jq
```

## USAGE 💡

### Script Usage 🎯

```bash
bash sub.sh webscantest.com
```

```bash
./sub.sh webscantest.com
```
![image](https://i.ibb.co/qBKPhHS/script.png)

### Curl Usage 🎯
```bash
curl -sL https://raw.githubusercontent.com/cihanmehmet/sub.sh/master/sub.sh | bash -s webscantest.com
```
### 🔖 Curl shortened link usage
```
curl -sL https://git.io/JesKK | bash -s tesla.com
```
![image](https://i.ibb.co/txtRKfq/online.png)

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
function subdomain() { curl -sL https://git.io/JesKK | bash -s $1 
cat $1.txt|httprobe|cut -d "/" -f3|sort -u |tee $1.txt 
echo "██████████████████████████████████████████████████████████████████████████████████████████████████████"
echo "Detect Alive Subdomain $(wc -l $1.txt|awk '{ print $1 }' )" "=> ${1}"
echo "File Location : "$(pwd)/"$1.txt"
}
```
<img width="994" alt="subdomain" src="https://user-images.githubusercontent.com/7144304/67149562-143ef100-f29c-11e9-9ba0-1f2db208fd62.png">

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

## 🧵 Docker Usage
### https://github.com/cihanmehmet/sub.sh/issues/4

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

## :triangular_flag_on_post: 💻 I am open to suggestions for improvement.
