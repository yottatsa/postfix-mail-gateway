postfix-mail-gateway
====================

To run:

    docker run --net=host --name=postfix --restart=always --volume=/etc/letsencrypt/live/mx.yottatsa.name:/etc/postfix/ssl --volume=/etc/letsencrypt/archive:/etc/archive --volume=/dev:/dev --volume=/run/systemd/journal:/run/systemd/journal --volume=/etc/ssl:/etc/ssl --volume=/usr/share/ca-certificates:/usr/share/ca-certificates --volume=/etc/postfix/virtual:/etc/postfix/virtual --volume=/var/mail:/var/mail -d -t yottatsa/postfix-mail-gateway:13

Only one config is needed: `/etc/postfix/virtual`:

    domain.tld domain.tld
    me@domain.tld back@another.tld,me

See also:
 * https://github.com/yottatsa/carclassify
 * https://hub.docker.com/r/yottatsa/postfix-mail-gateway/
 * https://hub.docker.com/r/yottatsa/certbot/
