# Saltstack
Saltstack repo for project 2.4

#Cloud.init code
Cloud init code for creating VM on azure and auto connect to Saltstack master

apt-get update -y
curl -L https://bootstrap.saltstack.com/ -o install_salt.sh
sh install_salt.sh
apt-get upgrade -y

sed -i 's/#master: salt/master: 10.0.6.42/' /etc/salt/minion
salt-minion -d

ping 10.0.6.42
systemctl restart salt-minion.service
