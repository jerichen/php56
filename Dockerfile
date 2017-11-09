FROM php:5.6-fpm
MAINTAINER JeriChen<jeri.chen0110@gmail.com>

ENV TZ=Asia/Taipei

ENV TZ=Asia/Taipei

ADD ./vim/.vimrc /root/.vimrc
ADD ./vim/.vim/colors/Dev_Delight.vim /root/.vim/colors/Dev_Delight.vim 
ADD ./vim/.vim/colors/molokai.vim /root/.vim/colors/molokai.vim 
ADD ./vim/.vim/colors/pyte.vim /root/.vim/colors/pyte.vim

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
        git \
        vim \
    && docker-php-ext-install -j$(nproc) iconv mcrypt mysqli pdo_mysql soap zip sockets \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
WORKDIR /root
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;";php composer-setup.php;php -r "unlink('composer-setup.php');";

