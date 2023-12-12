#!/bin/bash
sudo yum update -y
sudo yum install mc vim git httpd cronie -y
sudo service httpd start
sudo systemctl start crond
sudo systemctl enable crond

sudo touch /var/log/sysinfo
sudo touch /usr/local/bin/sysinfo.sh
sudo chmod 777 /usr/local/bin/sysinfo.sh
sudo chmod 644 /var/log/sysinfo
sudo chmod 644 /etc/crontab

cat << 'EOF' > /usr/local/bin/sysinfo.sh
#!/bin/bash
{
  w
  sudo free -m
  df -h
  ss -tulpn
  ping -c1 -w1 ukr.net
  find / -perm /4000 2>/dev/null
} >> /var/log/sysinfo
EOF

echo "* * * * 1-5 root sudo bash -c "/usr/local/bin/sysinfo.sh"" >> /etc/crontab
sudo systemctl restart crond