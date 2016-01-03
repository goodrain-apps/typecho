#!/bin/bash

# 判断并选择是否初始化数据库
if [ ! -f /data/.dbimported ];then
  php importdb.php ./install/createdb.sql  
  touch /data/.dbimported
fi


# 配置 usr 目录到持久化 /data 目录
if [ ! -d /data/usr ];then
  mv /app/usr /data/
  ln -s /data/usr /app/
elif [ -d /app/usr ];then
  rm -rf /app/usr
  ln -s /data/user /app/
fi

# 配置 var 目录到持久化 /data 目录
if [ ! -d /data/var ];then
  mv /app/var /data/
  ln -s /data/var /app/
elif [ -d /app/var ];then
  rm -rf /app/var
  ln -s /data/var /app/
fi

# 启动web server
vendor/bin/heroku-php-apache2
