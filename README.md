How to use it?
---------------
1. Build the container
 
 ```
 build -t {image-name} .
 ```
2. Start the container

 ```
 docker run -d -p 80:80 \
 -v /etc/localtime:/etc/localtime:ro \
 -v /docker_vol/data:/data \
 -v /docker_vol/var-lib-mysql:/var/lib/mysql \
 -v /docker_vol/var-log-nginx:/var/log/nginx \
 -v /docker_vol/var-log-dekiwiki:/var/log/dekiwiki \
 -v /docker_vol/var-www-dekiwiki-attachments:/var/www/dekiwiki/attachments \
 --name {container-name} \
 {image-name} \
 /bin/bash
 ```  
Hoping you enjoy it !


