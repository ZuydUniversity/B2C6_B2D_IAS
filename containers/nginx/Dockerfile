FROM nginx:latest
WORKDIR /app

# install Nginx configuration
COPY default_https.conf /etc/nginx/conf.d/default.conf
COPY cert.pem /etc/ssl/certs/server.pem
COPY key.pem /etc/ssl/private/server.key

EXPOSE 80
