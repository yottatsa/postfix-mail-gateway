#!/bin/sh -e
newaliases
postmap /etc/postfix/virtual
exec /usr/lib/postfix/master -d
