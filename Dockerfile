FROM alpine:3.7

ENV VERSION 2.4.33-r0
ENV URL https://github.com/apache/httpd

RUN apk --no-cache update && apk add --no-cache \
        apache2==${VERSION} \
        apache2-ssl \
        apache2-proxy \
        apache2-proxy-html \
        tzdata

RUN mkdir -p  /etc/apache2/sites-enabled/ /etc/apache2/ssl/ /run/apache2 && \
    ln -s /usr/lib/libxml2.so.2 /usr/lib/libxml2.so && \
    echo "LoadModule rewrite_module modules/mod_rewrite.so" > /etc/apache2/conf.d/rewrite.conf && \
    echo "LoadModule slotmem_shm_module modules/mod_slotmem_shm.so" >> /etc/apache2/conf.d/rewrite.conf && \
    ln -s /dev/stderr /var/log/apache2/error.log && \
    ln -s /dev/stdout /var/log/apache2/access.log 

# VOLUME /etc/apache2/conf.d/

EXPOSE 80 443

#USER apache

LABEL version=${VERSION}
LABEL url=${URL}

CMD httpd -DFOREGROUND
