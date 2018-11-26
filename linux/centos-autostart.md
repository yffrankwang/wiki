# auto start
#
echo "sudo -u xxx /opt/some-cmd" | sudo tee -a /etc/rc.d/rc.local 
sudo chattr -i /etc/sudoers
echo 'Defaults:root !requiretty' | sudo tee -a /etc/sudoers
sudo chattr +i /etc/sudoers
