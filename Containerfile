FROM registry.access.redhat.com/ubi9/ubi:latest
ARG HTTP_PORT=8080
ENV APP_PORT=8080
RUN dnf install -y httpd && \
    dnf clean all && \
    sed -i -e "/s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf && \
    chgrp -R 0 /var/run/httpd /var/log/httpd && \
    chmod -R g=u /var/run/httpd /var/log/httpd
WORKDIR /var/www/html
COPY src/index.html /var/www/html
LABEL description="My httpd container application" \ 
      io.k8s.description="My httpd container application" \ 
      io.openshift.expose-services="80:http" \
      io.openshift.tags="httpd, web server, apache, apache2" 
EXPOSE ${APP_PORT}
USER 1001
ENTRYPOINT /usr/sbin/httpd -DFOREGROUND
