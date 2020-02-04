nginx
=====

![](https://badge.imagelayers.io/vimagick/nginx:latest.svg)

[Nginx][1] is an open source reverse proxy server for HTTP, HTTPS, SMTP, POP3, and
IMAP protocols, as well as a load balancer, HTTP cache, and a web server
(origin server).

## Static Website

File: docker-compose.yml

```yaml
nginx:
  image: nginx:alpine
  ports:
    - "80:80"
  volumes:
    - ./data/default.conf:/etc/nginx/default.conf
    - ./data/html:/usr/share/nginx/html
  restart: always
```

## Reverse Proxy

File: docker-compose.yml

```yaml
nginx:
  image: nginx:alpine
  volumes:
    - ./data/default.conf:/etc/nginx/conf.d/default.conf
    - ./data/ssl:/etc/nginx/ssl
    - ./data/htpasswd:/etc/nginx/htpasswd
  net: host
  restart: always
```

> Password file can be generated by:
>> `echo "username:$(openssl passwd -apr1 password)" >> data/htpasswd`

File: nginx.conf

```nginx
user  nginx;
worker_processes  4;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
```

File: default

```nginx
server {
    listen 80 default;
    server_name _;
    return 301 http://blog.foobar.site/;
}

server {
    listen 80;
    server_name blog.foobar.site blog.easypi.info;
    location / {
        proxy_pass http://127.0.0.1:6109;
    }
}

server {
    listen 80;
    server_name wiki.foobar.site wiki.easypi.info;
    location / {
        auth_basic restricted;
        auth_basic_user_file /etc/nginx/htpasswd;
        proxy_pass http://127.0.0.1:8000;
    }
}

server {
    listen 80;
    server_name iot.foobar.site iot.easypi.info;
    location / {
        proxy_pass http://127.0.0.1:1880;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

File: [rtmp][1]

```nginx
rtmp {
    server {
        listen 1935;
        application live {
            live on;
        }
    }
}
```

[1]: http://nginx.org/
[2]: https://github.com/arut/nginx-rtmp-module/wiki/Directives