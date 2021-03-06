FROM jenkins/jenkins:latest

# install preselected jenkins plugins
COPY ./dock-files/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# switch user for elevated permissions
USER root

# install php and apache
RUN apt-get update && apt-get install -y \
    php7.0 \
    php7.0-cli \
    php7.0-mbstring \
    libapache2-mod-php

# install php unit
RUN  wget https://phar.phpunit.de/phpunit-6.phar -O phpunit
RUN chmod +x phpunit
RUN ./phpunit --version

#install phpstan
RUN wget https://github.com/phpstan/phpstan/releases/download/0.9.2/phpstan.phar -O phpstan
RUN chmod +x phpstan

# switch back to standard user
USER jenkins

#@todo : needed to get an old php version to jive with the debian version... fix this
#@todo : seems to be a problem with the sonarqube container / image... throwing a memory leak error
#@todo : need to work out a jenkinfile that will create our pipelines /jobs for us on create
#@todo : prometheus has been added / but not tested
#@todo : prometheus needs the config to link up to jenkins on create
#@todo : grafana has been added / but not tested
#@todo : need to auto config the data source from prometheus on create
#@todo : need to work out additional plugins needed to add to the auto install