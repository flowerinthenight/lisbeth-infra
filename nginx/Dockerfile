FROM nginx

RUN rm /etc/nginx/conf.d/*.conf && mkdir /etc/nginx/snippets/
COPY default.conf /etc/nginx/conf.d/
COPY ssl-lisbeth.conf ssl-params.conf /etc/nginx/snippets/
