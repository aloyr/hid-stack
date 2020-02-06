#!/bin/bash
sudo ifconfig lo0 alias 172.16.123.45
self=$0
if [ -L $self ]; then
  self=$(readlink $self)
fi
BASE=$(dirname $self)
cd /Users/peter/workspace/hid/docker
echo ""

function dockerLogs() {
  /usr/local/bin/docker-compose -f $BASE/docker-compose.yml $(find $BASE/sites -type f -iname docker-compose.yml | while read file; do echo -ne " -f $file"; done) logs -f -t --tail 1000
}

function dockerComposeAll() {
  /usr/local/bin/docker-compose -f $BASE/docker-compose.yml $(find $BASE/sites -type f -iname docker-compose.yml | while read file; do echo -ne " -f $file"; done) $@ 2> /dev/null
}

if [ "$1" == "add" ]; then
  if [ $# -ne 4 ]; then
    echo "Usage:"
    echo "$self add <sitename> <project root> <docroot relative to projectroot>"
    echo ""
    echo "Example:"
    echo "$self add d8 $HOME/Sites/drupal8 /web"
    exit 1
  else
    echo "all looks ok, proceeding."
    mkdir -p $BASE/sites/$2
    echo "setting up nginx config"
    docroot="${2}${4}"
    cat $BASE/templates/nginx.conf | sed -e "s^##SITENAME##^$2^g" -e "s^##DOCROOT##^$docroot^g"> $BASE/sites/$2/$2.conf
    echo ""
    echo "setting up emtpy db file at $BASE/sites/$2/db.sql.gz"
    echo "replace this file with a db dump of your site and restart the stack to populate the db"
    touch $BASE/sites/$2/db.sql.gz
    echo ""
    echo "creating default settings.d4dd.php file"
    echo "make sure your main settings.php has this at the end:"
    echo ""
    echo "\$d4dd_settings = __DIR__ . '/settings.d4dd.php';"
    echo 'if (file_exists($d4dd_settings)) {'
    echo '  include $d4dd_settings;'
    echo '}'
    cat $BASE/templates/settings.d4dd.php | sed "s^##SITENAME##^$2^g" > $BASE/sites/$2/settings.d4dd.php 
    echo ""
    echo "configuring database"
    mysql -e "create database if not exists $2;"
    sql="grant all on $2.* to drupal@\`%\` identified by 'drupal';"
    mysql -e 'grant all on '$2'.* to drupal@`%` identified by "drupal";'
    echo ""
    echo "configuring docker-compose"
    cat $BASE/templates/docker-compose.yml | sed -e "s^##SITENAME##^$2^g" -e "s^##PROJECTROOT##^$3^g" -e "s^##DOCROOT##^$4^g" > $BASE/sites/$2/docker-compose.yml
    echo "restarting stack"
    dockerComposeAll stop php
    dockerComposeAll stop www
    dockerComposeAll rm -f php
    dockerComposeAll rm -f www
    dockerComposeAll up -d
    exit 0
  fi
fi

if [ "$1" == "list" ]; then
  echo ""
  echo "Sites configured:"
  ls $BASE/sites | while read site; do echo "- $site"; done
  exit 0
fi

echo "acting on the following sites:"
find $BASE/sites -type f -iname docker-compose.yml | while read file; do
  echo "  - $file";
done

echo ""

if [ "$1" == "up" ]; then
  /usr/local/bin/docker-compose -f $BASE/docker-compose.yml $(find $BASE/sites -type f -iname docker-compose.yml | while read file; do echo -ne " -f $file"; done) $@ -d &
  dockerLogs
  exit 0
fi

if [ "$1" == "logs" ]; then
  dockerLogs
  exit 0
fi

/usr/local/bin/docker-compose -f $BASE/docker-compose.yml $(find $BASE/sites -type f -iname docker-compose.yml | while read file; do echo -ne " -f $file"; done) $@


#if [ "a$1" == "aup" ]; then
#  BASE=$(dirname $0)
#  docker-compose -f $BASE/docker-compose.yml $(find $BASE/sites -type f -iname docker-compose.yml | while read file; do echo -ne " -f $file"; done) up
#elif [ "a$1" == "adown" ]; then
#  docker-compose -f $BASE/docker-compose.yml $(find $BASE/sites -type f -iname docker-compose.yml | while read file; do echo -ne " -f $file"; done) down
#fi

