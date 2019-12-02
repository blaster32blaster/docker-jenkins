FROM jenkins/jenkins:lts

# install preselected jenkins plugins
COPY ./dock-files/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# switch user for elevated permissions
USER root
# install php and apache
RUN apt-get update && apt-get install -y php7.2 libapache2-mod-php
# install php unit
RUN wget -O phpunit https://phar.phpunit.de/phpunit-8.phar
RUN chmod +x phpunit-8.4.phar
RUN ./phpunit-8.4.phar --version
# switch back to standard user
USER jenkins