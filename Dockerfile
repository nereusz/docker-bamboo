ARG PHP_VERSION="8.0"

ARG HOMEDIR="/home"
ARG APPDIR="$HOMEDIR/app"

FROM php:$PHP_VERSION-cli AS app-with-build-tools

ARG HOMEDIR
ARG APPDIR

RUN set -eux ; \
    apt-get update ; \
    apt-get install -y unzip ; \
    curl https://getcomposer.org/download/2.0.12/composer.phar > $HOMEDIR/composer.phar

WORKDIR $APPDIR
COPY app $APPDIR

RUN set -eux ; \
    php $HOMEDIR/composer.phar install ; \
    php artisan key:generate

CMD ["php", "-S", "0.0.0.0:8080", "-t", "./public/"]
EXPOSE 8080
