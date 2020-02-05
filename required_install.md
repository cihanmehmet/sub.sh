# 💎💡 jq, parallel, httprobe Install

## 🍪 jq Install Debian(Kali) 🐧
```bash
apt install jq 
```
##  🍪 jq Install Mac OSX 💻
```bash
brew install jq 
```
## 🛠 Parallel Install Debian(Kali) 🐧
```bash
apt install parallel 
```
## 🛠 Parallel Install Mac OSX 💻
```bash
brew install parallel 
```

## 🌐 httprobe Install Debian(Kali) 🐧
```bash
apt install golang
go get -u github.com/tomnomnom/httprobe
cp ~/go/bin/httprobe /usr/local/bin
```
or
```bash
wget https://github.com/tomnomnom/httprobe/releases/download/v0.1.2/httprobe-linux-amd64-0.1.2.tgz
tar -xvzf httprobe-linux-amd64-0.1.2.tgz
cp httprobe /usr/local/bin
chmod +x /usr/local/bin/httprobe
```

## 🌐 httprobe Install Mac OSX 💻
```bash
brew install golang
go get -u github.com/tomnomnom/httprobe
cp  ~/go-workspace/bin/httprobe /usr/local/bin
```
or 
```bash
wget https://github.com/tomnomnom/httprobe/releases/download/v0.1.2/httprobe-darwin-amd64-0.1.2.tgz
tar -xvzf httprobe-linux-amd64-0.1.2.tgz
cp httprobe /usr/local/bin
```
