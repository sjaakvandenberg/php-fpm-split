FROM ubuntu

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  php-fpm

ADD ./php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD ./pool.d/ /etc/php5/fpm/pool.d

RUN mkdir -p /etc/php5/cli; ln -s /etc/php5/fpm/php.ini /etc/php5/cli/php.ini
RUN sed -i "s/;date.timezone =/date.timezone = Europe\/Berlin/" /etc/php5/fpm/php.ini

ADD app/ /app

EXPOSE 9000

WORKDIR /app

CMD ["php-fpm", "--nodaemonize"]
