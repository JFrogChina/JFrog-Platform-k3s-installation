
# if uss an external nginx
# the external nginx 443 > k3s's internal nginx with 8443

server {
    listen 443 ssl;
    server_name your.domain.com;

    ssl_certificate     /path/to/fullchain.pem;
    ssl_certificate_key /path/to/privkey.pem;

    location / {
        proxy_pass https://127.0.0.1:8443;
        proxy_ssl_verify off;  # 如果后端证书是自签名，加上这个
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
    }
}
