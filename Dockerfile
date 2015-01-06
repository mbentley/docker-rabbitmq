FROM debian:jessie
MAINTAINER Matt Bentley <mbentley@mbentley.net>
RUN (echo "deb http://http.debian.net/debian/ jessie main contrib non-free" > /etc/apt/sources.list && echo "deb http://http.debian.net/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list)
RUN apt-get update

RUN (DEBIAN_FRONTEND=noninteractive apt-get -y install wget &&\
	wget --quiet --no-check-certificate -O - http://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add - &&\
	echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list &&\
	apt-get update &&\
	DEBIAN_FRONTEND=noninteractive apt-get -y install rabbitmq-server &&\
	echo "ulimit -n 1024" >> /etc/default/rabbitmq-server &&\
	rabbitmq-plugins enable rabbitmq_management)

ADD run.sh /usr/local/bin/run

VOLUME ["/var/lib/rabbitmq"]
EXPOSE 5672
EXPOSE 15672
CMD ["/usr/local/bin/run"]
