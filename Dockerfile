FROM unit:php8.4

RUN apt-get update && apt-get install -y gettext-base git unzip netcat-traditional nano iputils-ping procps sudo supervisor \
	&& curl --fail -sSL https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& curl --fail -sOL https://git.appsdevteam.com/adt/sendmail/raw/v2.2.2/bin/sendmail && chmod +x sendmail && mv sendmail /usr/local/bin/sendmail \
	&& curl --fail -sOL https://git.appsdevteam.com/adt/docker-utils/raw/v1.0/bin/eoh && chmod +x eoh && mv eoh /usr/local/bin/eoh

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions intl pdo_mysql sockets

RUN echo "HISTFILE=/dev/null" >> /etc/profile
