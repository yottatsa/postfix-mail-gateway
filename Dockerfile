FROM alpine:latest
RUN apk add --no-cache postfix postfix-pcre openssl
RUN echo "postmaster: root" > /etc/postfix/aliases
ADD run.sh /
ADD encrypt.sh /
ADD main.cf /etc/postfix
ADD master.cf /etc/postfix
ADD sender /etc/postfix
ADD virtual /etc/postfix
VOLUME /var/spool/postfix/private
CMD exec /run.sh
