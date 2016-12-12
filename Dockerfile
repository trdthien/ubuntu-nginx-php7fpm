FROM ubuntu
MAINTAINER Thien Trinh <thien.trinh@8bitrockr.com>
RUN apt-get -y update

RUN apt-get -y install nginx \
	php7.0-fpm php7.0-curl php7.0-dev \
	php7.0-mcrypt php7.0-dom php7.0-mbstring \
	php7.0-intl php7.0-zip \
	git nano wget supervisor curl pkg-config dialog

COPY ./configs/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./configs/supervisor/conf.d/ /etc/supervisor/conf.d/
COPY ./configs/php/php.ini /etc/php/7.0/fpm/php.ini
COPY ./configs/php/php.ini /etc/php/7.0/cli/php.ini
COPY ./configs/php/pool.d/www.conf /etc/php/7.0/fpm/pool.d/www.conf

COPY ./configs/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./configs/nginx/sites-enabled/ /etc/nginx/sites-enabled/
COPY ./configs/nginx/conf.d/ /etc/nginx/conf.d/

VOLUME ["/var/www/html", "/etc/nginx/conf.d", "/etc/nginx/sites-enabled"]

CMD ["/usr/bin/supervisord"]


EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
CMD ["php7.0-fpm"]
