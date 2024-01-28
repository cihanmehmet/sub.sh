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
git clone https://github.com/tomnomnom/httprobe.git
cd httprobe/
go build
sudo mv httprobe /usr/local/bin/
```
or
```bash
wget https://github.com/tomnomnom/httprobe/releases/download/v0.2/httprobe-linux-amd64-0.2.tgz
tar -xvzf httprobe-linux-amd64-0.2.tgz
cp httprobe /usr/local/bin
chmod +x /usr/local/bin/httprobe
```

## 🌐 httprobe Install Mac OSX 💻
```bash
brew install golang
git clone https://github.com/tomnomnom/httprobe.git
cd httprobe/
go build
sudo cp httprobe /usr/local/bin/
```
or 
```bash
wget https://github.com/tomnomnom/httprobe/releases/download/v0.2/httprobe-darwin-amd64-0.2.tgz
tar -xvzf httprobe-darwin-amd64-0.2.tgz
cp httprobe /usr/local/bin
```
