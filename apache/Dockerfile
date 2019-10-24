FROM httpd:2.4.39
RUN apt-get update && apt-get install -y --no-install-recommends vim
RUN mkdir /usr/local/apache2/conf/conf.d && chown root:www-data /usr/local/apache2/conf/conf.d
#COPY --chown=root:www-data ./conf/vhosts /usr/local/apache2/conf/conf.d
#COPY --chown=root:www-data ./conf/httpd.conf /usr/local/apache2/conf/httpd.conf
EXPOSE 80 443