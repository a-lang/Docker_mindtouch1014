How to use it?
---------------
1. Build the container

 ```
 build -t {image-name} .
 ```
2. Create the directories

```
mkdir vol/{data,var-lib-mysql,var-log-httpd,var-log-dekiwiki,var-www-dekiwiki-attachments,var-www-dekiwiki-bin-cache}
```
3. Start the container

 ```
docker run -d -p 80:80 \
-v /etc/localtime:/etc/localtime:ro \
-v $PWD/vol/data:/data \
-v $PWD/vol/var-lib-mysql:/var/lib/mysql \
-v $PWD/vol/var-log-httpd:/var/log/httpd \
-v $PWD/vol/var-log-dekiwiki:/var/log/dekiwiki \
-v $PWD/vol/var-www-dekiwiki-attachments:/var/www/dekiwiki/attachments \
-v $PWD/vol/var-www-dekiwiki-bin-cache:/var/www/dekiwiki/bin/cache \
--name {container-name} \
{image-name} \
/bin/bash
 ```
Hoping you enjoy it !


