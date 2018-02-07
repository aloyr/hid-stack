#!/bin/bash
self=$0
if [ -L $self ]; then
  self=$(readlink $self)
fi
BASE=$(dirname $self)

docker-compose -f $BASE/docker-compose.yml $(find $BASE/sites -type f -iname docker-compose.yml | while read file; do echo -ne " -f $file"; done) $@


#if [ "a$1" == "aup" ]; then
#  BASE=$(dirname $0)
#  docker-compose -f $BASE/docker-compose.yml $(find $BASE/sites -type f -iname docker-compose.yml | while read file; do echo -ne " -f $file"; done) up
#elif [ "a$1" == "adown" ]; then
#  docker-compose -f $BASE/docker-compose.yml $(find $BASE/sites -type f -iname docker-compose.yml | while read file; do echo -ne " -f $file"; done) down
#fi
