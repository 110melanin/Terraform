#! /bin/bash
apt-get update
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "<h1>Deployed Machine via Terraform practice by Justice</h1>" | sudo tee /var/www/html/index.html
