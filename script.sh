#!/bin/bash
yum update -y
yum install mc vim git httpd cronie -y
service httpd start
systemctl start crond
systemctl enable crond

touch /var/log/sysinfo
touch /usr/local/bin/sysinfo.sh
chmod 777 /usr/local/bin/sysinfo.sh
chmod 644 /var/log/sysinfo
chmod 644 /etc/crontab

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
systemctl restart crond