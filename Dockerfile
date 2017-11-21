FROM howtoadhd/php-base:latest-cli

ENV COMPOSER_URL https://getcomposer.org/download/1.5.1/composer.phar
ENV COMPOSER_ALLOW_SUPERUSER 1

ENV WORDPRESS_ROOT /var/www/wordpress

RUN curl -L -o /usr/bin/composer "${COMPOSER_URL}" \
    && chmod +x /usr/bin/composer \
\
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
                php7-pcntl \
\
    && composer create-project \
			--stability=dev \
			--prefer-dist \
			--no-dev \
			humanmade/cavalcade-runner \
			/opt/cavalcade \
			dev-master \
	&& ln -s /opt/cavalcade/bin/cavalcade /usr/bin/cavalcade \
	&& rm -rf /usr/bin/composer /root/.composer/

COPY ./fs /

CMD ["/start-container"]
