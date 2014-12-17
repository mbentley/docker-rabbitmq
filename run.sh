#!/bin/bash
set -e

#RMQ_USER=${RMQ_USER:-guest}
#RMQ_PASS=${RMQ_PASS:-guest}

chown -R rabbitmq:rabbitmq /var/lib/rabbitmq

if [ ! -f /etc/rabbitmq/rabbitmq.config ]
then
  echo '[{rabbit, [{loopback_users, []}]}].' > /etc/rabbitmq/rabbitmq.config
fi

exec /usr/sbin/rabbitmq-server start
