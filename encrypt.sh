#!/bin/sh -e

FROM="$2"
TO="$4"
CERT="/etc/postfix/smime.crt"
SENDMAIL="/usr/sbin/sendmail -G -i" # NEVER NEVER NEVER use "-t" here.
OPENSSL="/usr/bin/openssl smime -encrypt -from ${FROM} -to ${TO} -subject encrypted -aes256 ${CERT}"
export RANDFILE="/tmp/encrypt.rnd"

if [ -e "${CERT}" ]
then
	$OPENSSL | $SENDMAIL "$@"
else
	$SENDMAIL "$@"
fi

exit $?
