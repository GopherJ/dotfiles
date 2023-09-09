server {
    listen 80;
    server_name data.alexcj96.com;
    rewrite ^(.*) https://$server_name$1 permanent;
}

server {
    listen 80;
    server_name static.alexcj96.com;
    rewrite ^(.*) https://$server_name$1 permanent;
}

upstream data {
        server 127.0.0.1:51122;
}

upstream static {
        server 127.0.0.1:51123;
}

server {
        listen 443 ssl;
        listen [::]:443 ssl;
        ssl_certificate   /etc/letsencrypt/live/data.alexcj96.com/fullchain.pem;
        ssl_certificate_key   /etc/letsencrypt/live/data.alexcj96.com/privkey.pem;

        server_name data.alexcj96.com;

        location / {
            try_files /nonexistent @$http_upgrade;
        }

        location @websocket {
                # switch off logging
                access_log off;

                # redirect all HTTP traffic to localhost:8080
                proxy_pass http://data;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header Host $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

                # WebSocket support (nginx 1.4)
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                #proxy_read_timeout 86400;
                #proxy_redirect off;
        }

        location @ {
                # switch off logging
                access_log off;

                proxy_pass http://data;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header Host $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

                client_max_body_size 1024m;
                client_body_timeout 1m;
                proxy_connect_timeout 60s;
                proxy_read_timeout 1m;
                proxy_send_timeout 1m;
        }
}

server {
        listen 443 ssl;
        listen [::]:443 ssl;
        ssl_certificate   /etc/letsencrypt/live/static.alexcj96.com/fullchain.pem;
        ssl_certificate_key   /etc/letsencrypt/live/static.alexcj96.com/privkey.pem;

        server_name static.alexcj96.com;

        location / {
            try_files /nonexistent @$http_upgrade;
        }

        location @websocket {
                # switch off logging
                access_log off;

                # redirect all HTTP traffic to localhost:8080
                proxy_pass http://static;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header Host $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

                # WebSocket support (nginx 1.4)
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                #proxy_read_timeout 86400;
                #proxy_redirect off;
        }

        location @ {
                # switch off logging
                access_log off;

                proxy_pass http://static;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header Host $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

                client_max_body_size 1024m;
                client_body_timeout 1m;
                proxy_connect_timeout 60s;
                proxy_read_timeout 1m;
                proxy_send_timeout 1m;
        }
}
