ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime
echo 'SOLIDVPN Script'
echo -e ""
echo -e " Choose VPN Server installation type:"
echo -e " [1] Premium Server"
echo -e " [2] VIP Server"
echo -e " [3] Private Server"
until [[ "$opts" =~ ^[1-3]$ ]]; do
read -rp " Choose from [1-3]: " -e opts
yum install wget -y
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum install epel-release-6-8.noarch.rpm -y
yum install unzip -y
yum update -y
yum install vixie-cron crontabs httpd git zip unzip epel-release -y
yum install php php-pdo php-mysqli php-mysql php-gd php-mbstring.x86_64 -y
yum install php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap curl curl-devel -y
rm /etc/sysctl.conf
case $opts in
    1)
        wget -O /etc/openvpn.zip "https://raw.githubusercontent.com/devdevan18/SolidVPN4in1/main/premium.zip"
    ;;
    2)
        wget -O /etc/openvpn.zip "https://raw.githubusercontent.com/devdevan18/SolidVPN4in1/main/vip.zip"
    ;;
    3)
        wget -O /etc/openvpn.zip "hhttps://raw.githubusercontent.com/devdevan18/SolidVPN4in1/main/private.zip"
    ;;
esac
cd /etc/
unzip openvpn.zip
cd
wget -O /var/var.zip "https://raw.githubusercontent.com/devdevan18/SolidVPN4in1/main/var.zip"
cd /var/
unzip var.zip
cd
cd /var/www/html
mkdir stat
sysctl -p
yum install mysql  dos2unix  nano squid openvpn easy-rsa httpd -y
cd /etc/openvpn/login
dos2unix auth_vpn
chmod 755 auth_vpn
cd /etc/openvpn/
chmod 755 disconnect.sh
echo "acl Denied_ports port 1025-65535
http_access deny Denied_ports
acl to_vpn dst `curl ipinfo.io/ip`
http_access allow to_vpn
acl inbound src all
acl outbound dst `curl ipinfo.io/ip`/32
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
echo "#!/bin/bash
. /etc/rc.d/init.d/functions
[ -f /etc/sysconfig/dropbear ] && . /etc/sysconfig/dropbear
RETVAL=0
prog="dropbear"
KEYGEN=/usr/bin/dropbearkey
DROPBEAR=/usr/sbin/dropbear
RSA_KEY=/etc/dropbear/dropbear_rsa_host_key
DSS_KEY=/etc/dropbear/dropbear_dss_host_key
PID_FILE=/var/run/dropbear.pid
OPTIONS="-p 442"
runlevel=$(set -- $(runlevel); eval "echo \$$#" )
do_rsa_keygen() {
if [ ! -s $RSA_KEY ]; then
echo -n $"Generating dropbear RSA host key: "
if $KEYGEN -t rsa -f $RSA_KEY >&/dev/null; then
chmod 600 $RSA_KEY
success $"RSA key generation"
echo
else
failure $"RSA key generation"
echo
exit 1
fi
fi
}
do_dss_keygen() {
if [ ! -s $DSS_KEY ]; then
echo -n $"Generating dropbear DSS host key: "
if $KEYGEN -t dss -f $DSS_KEY >&/dev/null; then
chmod 600 $DSS_KEY
success $"DSS key generation"
echo
else
failure $"DSS key generation"
echo
exit 1
fi
fi
}
start()
{
if [ "x${AUTOCREATE_SERVER_KEYS}" != xNO ]; then
do_rsa_keygen
do_dss_keygen
fi
echo -n $"Starting $prog: "
$DROPBEAR $OPTIONS && success || failure
RETVAL=$?
[ "$RETVAL" = 0 ] && touch /var/lock/subsys/dropbear
echo
}
stop()
{
echo -n $"Stopping $prog: "
if [ -n "`pidfileofproc $DROPBEAR`" ] ; then
killproc $DROPBEAR
else
failure $"Stopping $prog"
fi
RETVAL=$?
if [ "x$runlevel" = x0 -o "x$runlevel" = x6 ] ; then
killall $prog 2>/dev/null
fi
[ "$RETVAL" = 0 ] && rm -f /var/lock/subsys/dropbear
echo
}
case "$1" in
start)
start
;;
stop)
stop
;;
restart)
stop
start
;;
reload)
stop
start
;;
condrestart)
if [ -f /var/lock/subsys/dropbear ] ; then
stop
sleep 3
start
fi
;;
status)
status $DROPBEAR
RETVAL=$?
;;
*)
echo $"Usage: $0 {start|stop|restart|reload|condrestart|status}"
RETVAL=1
esac
exit $RETVAL"| sudo tee /etc/dropbear
sudo /sbin/iptables -L -nsudo /sbin/iptables -L -n
sudo /sbin/iptables -L -n
/sbin/iptables -L -n
/etc/init.d/iptables save
/etc/init.d/iptables stop
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
service network restart
echo 0 > /selinux/enforce
SELINUX=enforcing
SELINUX=disabled
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o venet0 -j SNAT --to-source `curl ipinfo.io/ip`
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to-source `curl ipinfo.io/ip`
iptables -t nat -A POSTROUTING -s 10.9.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o venet0 -j SNAT --to-source `curl ipinfo.io/ip`
iptables -t nat -A POSTROUTING -s 10.9.0.0/24 -j SNAT --to-source `curl ipinfo.io/ip`
iptables -A LOGDROP -j DROP
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
wget -O /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/devdevan18/SolidVPN4in1/main/stunnel.conf"
wget -O /etc/stunnel/stunnel.pem "https://raw.githubusercontent.com/devdevan18/SolidVPN4in1/main/stunnel.pem"
chown nobody:nobody /var/run/stunnel
wget -O /etc/rc.d/init.d/stunnel "https://raw.githubusercontent.com/devdevan18/SolidVPN4in1/main/stunnel"
chmod 744 /etc/rc.d/init.d/stunnel
SEXE=/usr/bin/stunnel
SEXE=/usr/sbin/stunnel
chmod +x /etc/rc.d/init.d/stunnel
/sbin/chkconfig --add stunnel
rpm -Uvh http://ftp-stud.hs-esslingen.de/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum install dropbear -y
wget -O /etc/init.d/dropbear "https://raw.githubusercontent.com/devdevan18/SolidVPN4in1/main/dropbear"
service httpd restart
service stunnel start
service dropbear start
service openvpn restart
service squid start
crontab -r
mkdir /usr/sbin/kpn
case $opts in
    1)
        wget -O /usr/sbin/kpn/connection.php "https://raw.githubusercontent.com/devdevan18/SolidVPN4in1/main/premiumconnection.sh"
    ;;
    2)
        wget -O /usr/sbin/kpn/connection.php "https://raw.githubusercontent.com/devdevan18/SolidVPN4in1/main/vipconnection.sh"
    ;;
    3)
        wget -O /usr/sbin/kpn/connection.php "https://raw.githubusercontent.com/devdevan18/SolidVPN4in1/main/privateconnection.sh"
    ;;
esac
echo "*/5 * * * * /usr/bin/php /usr/sbin/kpn/connection.php >/dev/null 2>&1
*/5 * * * * /bin/bash /usr/sbin/kpn/active.sh >/dev/null 2>&1
*/5 * * * * /bin/bash /usr/sbin/kpn/inactive.sh >/dev/null 2>&1" | tee -a /var/spool/cron/root
service httpd restart
service stunnel start
service openvpn restart
service squid start
service crond restart
service dropbear restart
echo ''
rm solidvip.sh &> /dev/null
echo 'Installation Complete'
case $opts in
    1)
        echo 'Premium Script Installed'
    ;;
    2)
        echo 'VIP Script Installed'
    ;;
    3)
        echo 'Private Script Installed'
    ;;
esac
echo 'Setup Done by SOLID VPN'
