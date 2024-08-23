 #!/bin/bash
    # Update the system packages
    yum update -y
    
    # Install Apache HTTP Server
    yum install -y httpd
    
    # Enable Apache to start at boot
    systemctl enable httpd
    
    # Start Apache
    systemctl start httpd
    
    # Create a simple web page
    echo "<html><h1>Welcome to the Web Server running on Amazon Linux 2023</h1></html>" > /var/www/html/index.html
  