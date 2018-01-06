############################################################
# Dockerfile for YouPHPTube Encoder
# Based on Ubuntu 16.04
# Source: https://github.com/fauria/docker-lamp
# Source: https://github.com/DanielnetoDotCom/YouPHPTube-Encoder/wiki/How-to-install-LAMP,--FFMPEG-and-Git-on-a-fresh-Ubuntu-16.x---For-YouPHPTube-Encoder
############################################################


# Set the base image to Ubuntu 16.04 LTS

FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER josh@hauptj.com

################## Begin Installation ######################

# Update the repository sources list 
RUN apt-get update
RUN apt-get upgrade -y

#COPY debconf.selections /tmp/
#RUN debconf-set-selections /tmp/debconf.selections


# Install packages

RUN apt-get install -y \
	apache2 \
	php7.0 \
	libapache2-mod-php7.0 \
	php7.0-mysql \
	php7.0-curl \
	php7.0-gd \
	php7.0-intl \
	mariadb-server \
	mariadb-client \
	ffmpeg \
	git \
	libimage-exiftool-perl \
	python \
	curl
	
# Install dev and debug packages
RUN apt-get install -y \
	vim \
	nano \
	net-tools

# Set Environment Variables
ENV LOG_STDOUT **Boolean**
ENV LOG_STDERR **Boolean**
ENV LOG_LEVEL warn
ENV ALLOW_OVERRIDE All
ENV DATE_TIMEZONE UTC
#ENV TERM dumb

# Setup Apache2
COPY run-lamp.sh /usr/sbin/
RUN a2enmod rewrite
RUN chmod +x /usr/sbin/run-lamp.sh
RUN chown -R www-data:www-data /var/www/html

# Clone Encoder Repository
WORKDIR /var/www/html
RUN git clone https://github.com/DanielnetoDotCom/YouPHPTube.git

# Create videos directory
RUN mkdir /var/www/html/YouPHPTube/videos
RUN chown www-data:www-data /var/www/html/YouPHPTube/videos && chmod 755 /var/www/html/YouPHPTube/videos 

# Download and install youtube-dl
RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl


	

################## Expose Network ######################

# Apache HTTP
EXPOSE 80
# MariaDB Server
EXPOSE 3306
	