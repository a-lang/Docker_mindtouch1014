FROM centos:centos5
MAINTAINER A-Lang <alang.hsu@gmail.com>

# Install latest update
ADD CentOS-Base.repo /etc/yum.repos.d/
ADD libselinux.repo /etc/yum.repos.d/
RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-5
RUN yum -y update

# Install MySQL
RUN yum -y install mysql-server 

# Install Apache & PHP
RUN yum -y install epel-release
RUN yum -y install httpd php-common php php-mysql php-mysqlnd php-gd \
    php-mbstring php-mcrypt wv links pdftohtml tidy html2ps mod_ssl

# Install Mono
RUN yum -y install wget bison gettext glib2 freetype fontconfig libpng libpng-devel \
    libX11 libX11-devel glib2-devel libgdi* libexif glibc-devel urw-fonts java unzip \
    gcc gcc-c++ automake autoconf libtool make bzip2
RUN cd /root && \
    wget http://download.mono-project.com/sources/mono/mono-2.10.8.tar.gz && \
    tar xzf mono-2.10.8.tar.gz && \
    cd mono-2.10.8 && ./configure --prefix=/opt/mono-2.10.8 && make && make install

# Install Prince
RUN yum -y install wget
RUN cd /root && \
    wget http://www.princexml.com/download/prince-10r7-1.centos5.x86_64.rpm && \
    rpm -ivh prince*.rpm


# Install Dekiwiki
RUN yum -y install wv links pdftohtml tidy html2ps
ADD mindtouch.repo /etc/yum.repos.d/
RUN yum -y install mindtouch

# Configure MySQL
RUN sed -i 's/\/var\/log\/mysqld.log/\/var\/log\/mysql\/mysqld.log/g' /etc/my.cnf

# Configure Dekiwiki
RUN chkconfig dekiwiki off
RUN rm -f /etc/httpd/conf.d/deki*
ADD deki-apache.conf /etc/httpd/conf.d/
ADD deki-apache-ssl.conf.disabled /etc/httpd/conf.d/

# Port & Volume
EXPOSE 80 443
VOLUME ["/data","/var/lib/mysql","/var/log/mysql","/var/log/httpd","/var/log/dekiwiki","/var/www/dekiwiki/attachments"]

# Script to start services
ADD startup.sh /
RUN chmod 755 /startup.sh
ENTRYPOINT /startup.sh


