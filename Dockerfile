FROM centos:centos6
MAINTAINER Alang <alang.hsu@gmail.com>

# Update the CentOS
RUN yum -y update; yum clean all

# Install the packages required
RUN yum -y install epel-release

# Install Mono
RUN yum install -y bison gettext glib2 freetype fontconfig libpng \
    libpng-devel libX11 libX11-devel glib2-devel libgdi* libexif glibc-devel \
    urw-fonts java unzip gcc gcc-c++ automake autoconf libtool make bzip2 wget
RUN cd /root && \
    wget -nv -O mono-2.10.8.tar.gz https://github.com/a-lang/Docker_mindtouch1014/releases/download/2.10.8/mono-2.10.8_for_dekiwiki_only.tar.gz && \
    tar xzPf mono-2.10.8.tar.gz && \
    cd mono-2.10.8/ && ./configure --prefix=/opt/mono-2.10.8 && \
    make clean && \
    make && make install 

# install mysql, httpd
RUN yum install -y mysql-server httpd php-common php php-mysql php-gd \
    php-mbstring php-mcrypt wv links tidy html2ps mod_ssl \
    poppler-utils html2text mod_proxy_html vim-enhanced


# Install Mindtouch
RUN cd /root && \
    wget http://repo.mindtouch.com/CentOS_5/noarch/mindtouch-10.1.4-6.1.noarch.rpm && \
    rpm -ivh mindtouch-*.rpm

# Install Prince
RUN cd /root && \
    wget http://www.princexml.com/download/prince-11.3-1.centos6.x86_64.rpm && \
    rpm -ivh prince*.rpm

# Configure mysql
RUN sed -i 's/\/var\/log\/mysqld.log/\/var\/log\/mysql\/mysqld.log/g' /etc/my.cnf

# Configure Dekiwiki
RUN chkconfig dekiwiki off
RUN rm -f /etc/httpd/conf.d/deki-apache.conf
ADD deki-apache.conf /etc/httpd/conf.d/

# Set the permission
RUN chown -R dekiwiki:apache /var/www/dekiwiki/{attachments,bin}

# Disable the auto start for the daemons
RUN chkconfig httpd off
RUN chkconfig mysqld off

# Clean up the unused files
RUN yum clean all && \
    cd /root && \
    rm -f *.rpm mono-*.tar.gz && \
    rm -rf mono-*/

# Port & Volume
EXPOSE 80 
VOLUME ["/data","/var/lib/mysql","/var/log/mysql","/var/log/httpd","/var/log/dekiwiki","/var/www/dekiwiki/attachments","/var/www/dekiwiki/bin/cache"]

# Script to start services
ADD startup.sh /
RUN chmod 755 /startup.sh
ENTRYPOINT /startup.sh
