#!/bin/bash

# Update packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Nginx
sudo apt-get install nginx -y

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Start Nginx service
sudo systemctl start nginx

# Create a simple HTML page
echo "<!DOCTYPE html>
<html>
<head>
    <title>Hello</title>
</head>
<body>
    <h1>Hello from Private Subnet</h1>
</body>
</html>" | sudo tee /var/www/html/index.html

# Optional: restart Nginx to ensure changes take effect
sudo systemctl restart nginx

echo "Nginx installation and setup complete!"
