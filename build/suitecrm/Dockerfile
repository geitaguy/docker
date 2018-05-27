FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update \
 && apt-get -qqy install --no-install-recommends \
    apache2 apache2-utils libapache2-mod-php php \
    php-common php-curl php-xml php-json php-mysql \
    php-mbstring php-zip php-imap php-gd libpcre3 \
    libpcre3-dev zlib1g zlib1g-dev sed curl \
    ca-certificates \
 && apt-get -qqy autoremove \
 && apt-get -qqy clean \
 && rm -rf /var/lib/apt/lists/*

RUN php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
 && php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
 && php /tmp/composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('/tmp/composer-setup.php');" \
 && sed -i -e "s/output_buffering\s*=\s*4096/output_buffering = Off/g" \
           -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" \
           -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 1G/g" \
           -e "s/post_max_size\s*=\s*8M/post_max_size = 1G/g" \
           -e "s:;\s*session.save_path\s*=\s*\"N;/path\":session.save_path = /tmp:g" \
        /etc/php/7.0/apache2/php.ini
WORKDIR /var/www/html
RUN curl -fsSL https://github.com/salesagility/SuiteCRM/archive/v7.10.2.tar.gz | tar zx --strip-components=1\
 && composer install \
 && mkdir -p cache/{images,layout,pdf,xml,include/javascript} \
 && chown -R www-data:www-data * \
 && chmod -R 755 *
RUN rm /var/www/html/index.html
EXPOSE 80

CMD apachectl -DFOREGROUND
