#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="Asyhiqin"
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/${GitUser}/cintaku/main/ipvps.conf | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo "Only For Premium Users"
exit 0
fi
clear
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

IP=$(wget -qO- icanhazip.com);
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn3="$(cat ~/log-install.txt | grep -w "OVPN" | cut -d: -f2|sed 's/ //g')"
ovpn4="$(cat ~/log-install.txt | grep -w "SSL" | cut -d: -f2|sed 's/ //g')"
ohpssh="$(cat ~/log-install.txt | grep -w "SSH" | cut -d: -f2|sed 's/ //g')"
ohpdrop="$(cat ~/log-install.txt | grep -w "OHP Dropbear" | cut -d: -f2|sed 's/ //g')"
sleep 1
echo Ping Host
echo Cek Hak Akses...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Membuat Akun: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
harini=`date -d "0 days" +"%Y-%m-%d"`
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
exp1=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "Thank You For Using Our Services"
echo -e "SSH & OpenVPN Account Info"
echo -e "=============================="
echo -e "Username      : $Login "
echo -e "Password      : $Pass"
echo -e "=============================="
echo -e "Domain        : $domain"
echo -e "IP/Host       : $MYIP"
echo -e "OpenSSH       : 22"
echo -e "Dropbear      : 442, 109"
echo -e "SSL/TLS       :$ssl"
echo -e "WS-Dropbear   : 2081"
echo -e "WS-Stunnel    : 2082"
echo -e "WS-OpenSSH    : 2085"
echo -e "OHP Dropbear  : $ohpdrop"
echo -e "OHP OpenSSH   : $ohpssh"
echo -e "OHP OVPN      : $ovpn3"
echo -e "Port Squid    :$sqd"
echo -e "Badvpn        : 7100-7300"
echo -e "=============================="
echo -e "DOWNLOAD CONFIG OVPN BELOW :"
echo -e "---------------------------"
echo -e "OpenVPN TCP : $ovpn http://$MYIP:81/client-tcp-$ovpn.ovpn"
echo -e "OpenVPN UDP : $ovpn2 http://$MYIP:81/client-udp-$ovpn2.ovpn"
echo -e "OpenVPN SSL : $ovpn4 http://$MYIP:81/client-tcp-ssl.ovpn"
echo -e "OpenVPN OHP : $ovpn3 http://$MYIP:81/client-tcp-ohp1194.ovpn"
echo -e "=============================="
echo -e "Payload Websocket : GET / HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "----------------------"
echo -e "Created   : $harini"
echo -e "Expired   : $exp1"
echo -e "----------------------"
echo -e "Script by Virtual"
