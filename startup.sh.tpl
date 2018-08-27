#!/bin/bash

apt-get update
apt-get install -y nginx

cd /var/www/html
wget https://wallpaperbrowse.com/media/images/3848765-wallpaper-images-download.jpg

cat > /var/www/html/index.nginx-debian.html <<'EOF'

<!DOCTYPE html>
<html>
<head>
<title>Welcome to ClearScore DevOps Test! </title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>Lorem Ipsum</p>
<img src="3848765-wallpaper-images-download.jpg" style="width:500px;height:600px;" alt="lorem ipsum">
</body>
</html>
EOF

systemctl enable nginx
systemctl restart nginx
