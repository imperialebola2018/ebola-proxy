FROM nginx:1.13

RUN apt-get update && apt-get install -y apache2-utils

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.ebola2018.conf /etc/nginx/conf.d/ebola2018.conf.template
COPY index.html /usr/share/nginx/html/index.html
COPY configure_proxy add_user /usr/local/bin/
RUN rm /etc/nginx/conf.d/default.conf

WORKDIR /app
COPY entrypoint.sh .

ENTRYPOINT ["/app/entrypoint.sh"]
