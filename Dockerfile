FROM debian:jessie
MAINTAINER Matt Bentley <mbentley@mbentley.net>

RUN (apt-get update &&\
  apt-get -y install wget &&\
  wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add - &&\
  echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list &&\
  apt-get update &&\
  apt-get -y install rabbitmq-server &&\
  echo "ulimit -n 1024" >> /etc/default/rabbitmq-server &&\
  rabbitmq-plugins enable rabbitmq_management &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/*)

ADD run.sh /usr/local/bin/run

VOLUME ["/var/lib/rabbitmq"]
EXPOSE 5672 15672
CMD ["/usr/local/bin/run"]
