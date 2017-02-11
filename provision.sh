#!/bin/bash
RESDIR=/vagrant/resources
NIFI_VERSION=1.1.1
NIFI_FILE=nifi-$NIFI_VERSION-bin.tar.gz
NIFI_URL=http://apache.mirrors.pair.com/nifi/$NIFI_VERSION/$NIFI_FILE

# Update packagse
echo "Updating system"
sudo apt-get -qq -y update

# Install Java
echo "Installing Java"
sudo apt-get install -qq -y default-jre
if [ "x$JAVA_HOME" == "x" ];
then
	sudo printf 'JAVA_HOME=/usr/share/java/default-jre' >> /etc/environment
	source /etc/environment
fi

# set system parameters as per NIFI docs
sudo sysctl -w net.ipv4.ip_local_port_range="10000 65000"
sudo printf '* hard nofile 50000' >> /etc/security/limits.conf
sudo printf '* soft nofile 50000' >> /etc/security/limits.conf
sudo printf '* hard nproc 10000' >> /etc/security/limits.conf
sudo printf '* soft nproc 10000' >> /etc/security/limits.conf
sudo printf '* soft nproc 10000' > /etc/security/limits.d/90-nproc.conf
# does not work on Ubuntu
#sudo modprobe ip_conntrack
#sudo sysctl -w net.ipv4.netfilter.ip_conntrack_tcp_timeout_time_wait="1"

sudo sysctl -w vm.swappiness="0"
sudo sysctl -p

# firewall
sudo ufw allow 8080
sudo ufw allow ssh
sudo ufw --force enable

# MSSQL JDBC
MSSQL_JDBCFILE=$RESDIR/sqljdbc_6.0.8112.100_enu.tar.gz
if [ -f $MSSQL_JDBCFILE ];
then
	echo "Installing MSSQL JDBC Driver"
	sudo tar -xzf $MSSQL_JDBCFILE
	sudo cp sqljdbc_6.0/enu/jre8/sqljdbc42.jar /usr/share/java/
	sudo ln -s /usr/share/java/sqljdbc42.jar /usr/share/java/sqljdbc
	sudo rm -rf sqljdbc_6.0
	echo "**** Done installing MSSQL JDBC Driver at /usr/share/java/sqljdbc42.jar ****"
	echo "Driver class: com.microsoft.sqlserver.jdbc.SQLServerDriver"
	echo "URL: jdbc:sqlserver://localhost:1433;DatabaseName=db"
fi

# download nifi if not present
if [ ! -f $RESDIR/$NIFI_FILE ];
then
	echo "Downloading NIFI"
	sudo wget -O $RESDIR/$NIFI_FILE $NIFI_URL
fi

# install in a linuxy way
echo "Installing NIFI from $RESDIR/$NIFI_FILE"
sudo tar -xzf $RESDIR/$NIFI_FILE
sudo cp -r nifi-$NIFI_VERSION /usr/share/
sudo ln -s /usr/share/nifi-$NIFI_VERSION/bin/nifi.sh /usr/bin/nifi
sudo rm -rf nifi-$NIFI_VERSION
echo "Done installing NIFI"

echo "Starting NIFI"
sudo nifi install
sudo systemctl daemon-reload
sudo systemctl start nifi.service

echo "NIFI listening on port 8080. It may take several minutes for the UI to come up. Keep trying if you get 404's."
