<div align="center">

<img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&weight=700&size=35&duration=3000&pause=1000&color=F70000&center=true&vCenter=true&random=false&width=600&height=70&lines=⚡+TYPHON+DDoS+⚡;🔥+POWERFUL+DDoS+TOOL+🔥;🛡️+MULTI-BYPASS+SYSTEM+🛡️" alt="Typing SVG" />

<p align="center">
  <img src="https://img.shields.io/badge/Version-1.0.0-red?style=for-the-badge&logo=github&logoColor=white" alt="Version"/>
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20Termux-brightgreen?style=for-the-badge&logo=linux&logoColor=white" alt="Platform"/>
  <img src="https://img.shields.io/badge/Language-Python%203.x-blue?style=for-the-badge&logo=python&logoColor=yellow" alt="Language"/>
  <img src="https://img.shields.io/badge/License-MIT-purple?style=for-the-badge" alt="License"/>
</p>

<br/>


<p>
  <b>⚡ Advanced DDoS Attack Tool with Multiple Bypass Capabilities ⚡</b>
</p>

---

## ⚠️ DISCLAIMER ⚠️


> **🚨 IMPORTANT LEGAL NOTICE**
> 
> - ❌ **DO NOT** attack pakistan Government websites or `.pk` domains.
> - ❌ **DO NOT** attack any websites you don't own or have explicit permission to test
> - ⚠️ This tool was created for **EDUCATIONAL PURPOSES ONLY**
> - ⚠️ All responsibilities and consequences of using this program lie with the **USER**
> - ⚠️ The developers assume **NO LIABILITY** and are **NOT RESPONSIBLE** for any misuse or damage
> - 📚 Use this tool only in controlled environments for learning about network security

</div>

---

## 🌟 FEATURES

| 🛡️ Protection Bypass | ⚡ Attack Methods | 🛠️ Utilities |
|:---------------------:|:-----------------:|:------------:|
| Cloudflare UAM | Layer 7 Attacks | DNS Lookup |
| Cloudflare BFM | Layer 4 Attacks | GeoIP Lookup |
| Cloudflare NOSEC | HTTP/2 Support | Subnet Scanner |
| DDoS-Guard | Multi-threading | IP Tools |
| BlazingFast | Proxy Support | Network Info |
| OVH | Custom Headers | Port Scanner |


---

---

## 🛠️ AVAILABLE METHODS

<details open>
<summary><b>🔴 Layer 7 - Application Layer Attacks</b></summary>
<br>

| Method | Command | Description | Bypass |
|--------|---------|-------------|---------|
| `bypass` | `bypass <url>` | Bypass Cloudflare protection | ✅ CF UAM/BMF |
| `flood` | `flood <url> <threads>` | HTTP Flood with high threads | ✅ DDoS-Guard |
| `httpx` | `httpx <url> <threads>` | HTTP/2.0 Request Attack | ✅ CloudFront |
| `spoof` | `spoof <url> <threads>` | Spoofed Request Attack | ✅ NOSEC |
| `get` | `get <url> <threads>` | GET Request Flood | ✅ Standard |
| `post` | `post <url> <threads>` | POST Request Flood | ✅ Standard |
| `head` | `head <url> <threads>` | HEAD Request Flood | ✅ Standard |
| `soc` | `soc <ip> <port> <threads>` | Socket Connection Attack | ✅ TCP Bypass |

</details>

<details open>
<summary><b>🔵 Layer 4 - Transport Layer Attacks</b></summary>
<br>

| Method | Command | Description | Protocol |
|--------|---------|-------------|----------|
| `udp` | `udp <ip> <port> <threads>` | UDP Flood Attack | UDP |
| `tcp` | `tcp <ip> <port> <threads>` | TCP SYN Flood Attack | TCP |

</details>

<details>
<summary><b>🟢 Tools & Utilities</b></summary>
<br>

| Tool | Command | Description |
|------|---------|-------------|
| `dns` | `dns <domain>` | Classic DNS Lookup |
| `geoip` | `geoip <ip>` | Geo IP Address Lookup |
| `subnet` | `subnet <ip>` | Subnet Information Lookup |

</details>

---

## 📦 INSTALLATION

### 🐧 Linux Installation

```
# Update System
sudo apt update && sudo apt upgrade -y
```

### Install Dependencies
```
sudo apt install python3 python3-pip git wget -y
```

### Clone Repository
```
git clone https://github.com/Athexblackhat/TYPHON
```

### Navigate to Directory
```
cd TYPHON/
```

### Install Requirements
```
pip3 install -r requirements.txt
```

### Run TYPHON
```
python3 main.py
```

## 📱 Termux Installation
```
# Update Packages
pkg update && pkg upgrade -y
```
### Install Dependencies
```
pkg install python3 python3-pip git -y
```

### Clone Repository
```
git clone https://github.com/Athexblackhat/TYPHON.git
```
### Navigate to Directory
```
cd TYPHON/
```
### Install Requirements
```
pip3 install -r requirements.txt
```
### Run TYPHON
```
python3 main.py
```
## 🚀 USAGE EXAMPLES
***Basic HTTP Flood Attack***
```
python3 main.py flood https://example.com/ 1000 1000
```

***Cloudflare Bypass Attack***
```
python3 main.py bypass https://target.com/ 500 100
```

***HTTP/2.0 Request Attack***
```
python3 main.py httpx https://target.com/ 800 200
```
***UDP Flood Attack***
```
python3 main.py udp 192.168.1.1 80 1000
```
***DNS Lookup***
```
python3 main.py dns google.com
```

## ⚙️ SYSTEM REQUIREMENTS

- OS: Linux (Ubuntu/Debian) or Android (Termux)

- Python: 3.7 or higher

- RAM: Minimum 512MB (2GB+ recommended)

- Storage: 100MB free space

- Network: Stable internet connection

- Root: Not required (recommended for some features)

## DEVELOPER

***MADE WITH ♥ BY ATHEX BLACK HAT***
