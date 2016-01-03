#!/bin/bash

# 判断并选择是否初始化数据库
[ ! -e /data/.dbimported ] && php importdb.php ./install/typecho.sql  && touch /data/.dbimported


# 将需要持久化的目录移动到 /data 目录
if [ ! -d /data/usr ];then
  mv /app/usr /data/
  ln -s /data/usr /app/
elif [ -d /app/usr ];then
  rm -rf /app/usr
  ln -s /data/user /app/
fi

# 启动web server
vendor/bin/heroku-php-apache2
