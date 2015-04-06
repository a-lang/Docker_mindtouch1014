############################################################
# Dockerfile to build Mindtouch 10.1.4
# Based on the image alang/centos5-lamp_php51
############################################################
FROM alang/centos5-lamp_php51
MAINTAINER A-Lang <alang.hsu@gmail.com>

RUN yum -y install wget
RUN rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-5
RUN cd /root && \
    wget http://mirror01.idc.hinet.net/EPEL/5/i386/epel-release-5-4.noarch.rpm && \
    rpm -ivh epel-release-5-4.noarch.rpm
RUN yum -y install bison gettext glib2 freetype fontconfig libpng libpng-devel libX11 libX11-devel glib2-devel libgdi* libexif glibc-devel urw-fonts java unzip gcc gcc-c++ automake autoconf libtool make bzip2

RUN cd /root && \
    wget http://download.mono-project.com/sources/mono/mono-2.10.8.tar.gz && \
    tar xzf mono-2.10.8.tar.gz && \
    cd mono-2.10.8 && ./configure --prefix=/opt/mono-2.10.8 && make && make install

RUN rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
RUN cd /root && \
    wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el5.rf.i386.rpm && \
    rpm -ivh rpmforge-release-0.5.3-1.el5.rf.i386.rpm && \
    yum -y install wv links pdftohtml tidy html2ps

RUN cd /etc/yum.repos.d && \
    wget http://repo.mindtouch.com/CentOS_5/home:mindtouch.repo -O mindtouch.repo && \
    yum -y install dekiwiki

ADD ./deki-apache.conf /etc/httpd/conf.d/deki-apache.conf
ADD ./mindtouch.deki.startup.xml /etc/dekiwiki/mindtouch.deki.startup.xml
ADD ./mindtouch.host.conf /etc/dekiwiki/mindtouch.host.conf

