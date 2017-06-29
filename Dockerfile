FROM alpine:latest
RUN apk add --no-cache postfix postfix-pcre openssl
RUN echo "postmaster: root" > /etc/postfix/aliases
ADD encrypt.sh /
ADD main.cf /etc/postfix
ADD master.cf /etc/postfix
CMD newaliases; postmap /etc/postfix/virtual; exec /usr/lib/postfix/master -d
