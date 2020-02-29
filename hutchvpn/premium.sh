MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0'`;
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime
yum install wget -y
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum install epel-release-6-8.noarch.rpm -y
yum install unzip -y
yum update -y
yum install vixie-cron crontabs httpd git zip unzip epel-release -y
yum install php php-pdo php-mysqli php-mysql php-gd php-mbstring.x86_64 -y
yum install php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap curl curl-devel -y
rm /etc/sysctl.conf
wget -O /etc/openvpn.zip "https://raw.githubusercontent.com/devdevan18/SolidVPN3n1/master/hutchvpn/premium.zip"
cd /etc/
unzip openvpn.zip
cd
wget -O /var/var.zip "https://raw.githubusercontent.com/devdevan18/SolidVPN3n1/master/var.zip"
cd /var/
unzip var.zip
cd
sysctl -p
yum install mysql-server  dos2unix  nano squid openvpn easy-rsa httpd -y
cd /etc/openvpn/login
dos2unix auth_vpn
chmod 755 auth_vpn
cd /etc/openvpn/
chmod 755 disconnect.sh
$MYIP
echo "acl Denied_ports port 1025-65535
http_access deny Denied_ports
acl to_vpn dst $MYIP
http_access allow to_vpn
acl inbound src all
acl outbound dst $MYIP/32
http_access allow inbound outbound
http_access deny all
http_port 8080 transparent
http_port 8888 transparent
http_port 3128 transparent
http_port 8000 transparent
http_port 1111 transparent
http_port 2222 transparent
visible_hostname Topspeed VPN
cache_mgr gaming"| sudo tee /etc/squid/squid.conf
sudo /sbin/iptables -L -nsudo /sbin/iptables -L -nc
sudo /sbin/iptables -L -n
ip -6 routeip -6 route
ip -6 route
iptables -I INPUT -s 0/0 -p tcp --dport 5666 -j ACCEPTiptables -I INPUT -s 0/0 -p tcp --dport 5666 -j ACCEPT
/sbin/iptables -L -n
/etc/init.d/iptables save
/etc/init.d/iptables stop
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -I NRPE -s 0/0 -p tcp --dport 5666 -j ACCEPT
echo 169.254.0.0/16 dev eth0 >> /etc/sysconfig/network-scripts/route-eth0
service network restartecho 169.254.0.0/16 dev eth0 >> /etc/sysconfig/network-scripts/route-eth0
service network restart
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o venet0 -j SNAT --to-source $MYIP
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to-source $MYIP
iptables -N LOGDROP > /dev/null 2> /dev/null
iptables -F LOGDROP
cd
cd
service iptables save
service iptables restart
echo 0 > /selinux/enforce
SELINUX=enforcing
SELINUX=disabled
service openvpn restart
service squid restart
chmod 777 /var/www/html/stat/status.log.txt
cd
yum install stunnel -y
wget -O /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/devdevan18/SolidVPN3n1/master/stunnel.conf"
wget -O /etc/stunnel/stunnel.pem "https://raw.githubusercontent.com/devdevan18/SolidVPN3n1/master/stunnel.pem"
chown nobody:nobody /var/run/stunnel
wget -O /etc/rc.d/init.d/stunnel "https://raw.githubusercontent.com/devdevan18/SolidVPN3n1/master/stunnel"
chmod 744 /etc/rc.d/init.d/stunnel
SEXE=/usr/bin/stunnel
SEXE=/usr/sbin/stunnel
chmod +x /etc/rc.d/init.d/stunnel
/sbin/chkconfig --add stunnel
rpm -Uvh http://ftp-stud.hs-esslingen.de/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum install dropbear -y
wget -O /etc/init.d/dropbear "https://raw.githubusercontent.com/devdevan18/SolidVPN3n1/master/dropbear"
service httpd restart
service stunnel start
service dropbear start
service openvpn restart
service squid start
crontab -r
mkdir /usr/sbin/kpn
wget -O /usr/sbin/kpn/connection.php "https://raw.githubusercontent.com/devdevan18/SolidVPN3n1/master/hutchvpn/premiumconnection.sh"
echo "*/3 * * * * /usr/bin/php /usr/sbin/kpn/connection.php >/dev/null 2>&1
*/3 * * * * /bin/bash /usr/sbin/kpn/active.sh >/dev/null 2>&1
*/3 * * * * /bin/bash /usr/sbin/kpn/inactive.sh >/dev/null 2>&1" | tee -a /var/spool/cron/root
/sbin/chkconfig crond on
/sbin/service crond start
/etc/init.d/crond start
service crond restart
echo ''
rm prembeta.sh &> /dev/null
echo 'Installation Complete'
echo 'Setup Done by Kenjie'
