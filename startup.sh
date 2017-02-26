#!/usr/bin/env bash
#===============================================================================
#
# AUTHOR: A-Lang <alang.hsu@gmail.com>
#
#===============================================================================
echo "" >> /etc/bashrc
echo "# This is required for the command top" >> /etc/bashrc
echo "export TERM=xterm" >> /etc/bashrc

chown -R dekiwiki:apache /var/www/dekiwiki

echo "Starting mysql..."
service mysqld start

echo "Starting httpd..."
service httpd start

echo "Starting Dekiwiki..."
service dekiwiki start

echo "=> The container is now Running..."
echo " * Ctrl-c to exit the container."
/bin/sh -c "while true; do sleep 10; done"
