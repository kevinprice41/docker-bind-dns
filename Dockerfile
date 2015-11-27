FROM ubuntu:14.04
RUN apt-get update \
    && apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive \ 
    && apt-get -y install bind9 bind9utils bind9-doc

ADD conf/named.conf /etc/bind/named.conf
ADD conf/named.conf.options /etc/bind/named.conf.options
ADD conf/named.conf.local /etc/bind/named.conf.local
ADD conf/reverse.price /etc/bind/reverse.price
ADD conf/forward.price /etc/bind/forward.price

RUN chmod -R 755 /etc/bind
RUN chown -R bind:bind /etc/bind

ADD script/dns.sh /usr/local/bind/dns.sh
RUN chmod +x /usr/local/bind/dns.sh

EXPOSE 53
VOLUME /data
ENTRYPOINT ["/usr/local/bind/dns.sh"]
