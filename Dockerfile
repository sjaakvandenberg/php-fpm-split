FROM ubuntu

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  php-fpm

ADD ./php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
ADD ./pool.d/ /etc/php/7.0/fpm/pool.d

RUN mkdir -p /etc/php/7.0/cli; ln -s /etc/php/7.0/fpm/php.ini /etc/php/7.0/cli/php.ini
RUN sed -i "s/;date.timezone =/date.timezone = Europe\/Berlin/" /etc/php/7.0/fpm/php.ini

ADD app/ /app

EXPOSE 9000

WORKDIR /app

CMD ["php-fpm7.0", "--nodaemonize"]
