apt install chrony -y


sudo echo "server NTP_SERVER iburst " >> /etc/chrony/chrony.conf
sudo echo "allow "$1"" >> /etc/chrony/chrony.conf
service chrony restart
