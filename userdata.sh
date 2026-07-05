#!/bin/bash

dnf update -y
dnf install -y httpd

systemctl enable httpd
systemctl start httpd

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
-H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
http://169.254.169.254/latest/meta-data/instance-id)

AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
http://169.254.169.254/latest/meta-data/placement/availability-zone)

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Three Tier Web Application</title>
</head>
<body style="font-family: Arial; text-align:center; margin-top:80px;">
<h1>🚀 Three Tier Web Application</h1>
<h2>Terraform + AWS</h2>
<p><strong>Instance ID:</strong> $INSTANCE_ID</p>
<p><strong>Availability Zone:</strong> $AZ</p>
</body>
</html>
EOF