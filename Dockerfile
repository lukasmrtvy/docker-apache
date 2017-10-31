FROM alpine:latest

RUN apk --no-cache update && apk add --no-cache \
        apache2 \
        apache2-ssl \
        apache2-proxy \
        apache2-proxy-html 

RUN mkdir -p  /etc/apache2/sites-enabled/ /etc/apache2/ssl/ /run/apache2 && \
    ln -s /usr/lib/libxml2.so.2 /usr/lib/libxml2.so && \
    echo "LoadModule rewrite_module modules/mod_rewrite.so" > /etc/apache2/conf.d/rewrite.conf \
    echo "LoadModule slotmem_shm_module modules/mod_slotmem_shm.so" >> /etc/apache2/conf.d/rewrite.conf \
    ln -s /dev/stderr /var/log/apache2/error.log \
    ln -s /dev/stdout /var/log/apache2/access.log \

#COPY index.html /var/www/localhost/htdocs/
#COPY custom.conf  /etc/apache2/conf.d/
#COPY server.crt /etc/apache2/ssl/
#COPY server.key /etc/apache2/ssl/

VOLUME /etc/apache2/conf.d/ /var/www/localhost/htdocs/

CMD httpd -DFOREGROUND
