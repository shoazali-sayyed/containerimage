FROM registry.access.redhat.com/ubi9/ubi:latest
ARG HTTP_PORT=8080
ENV APP_PORT=8080
RUN dnf install -y httpd 
RUN dnf clean all 
WORKDIR /var/www/html
COPY /src/index.html /var/www/html
LABEL description="My httpd container application" 
LABEL io.k8s.description="My httpd container application" 
LABEL io.openshift.expose-services="8080:http" 
LABEL io.openshift.tags="httpd, web server, apache, apache2" 
EXPOSE ${APP_PORT}
USER 1001
ENTRYPOINT /usr/sbin/httpd -DFOREGROUND
