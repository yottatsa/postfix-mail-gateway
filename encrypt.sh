#!/bin/sh -e

SIGNCERT="/etc/postfix/ssl/cert.pem"
SIGNKEY="/etc/postfix/ssl/privkey.pem"
CERT="/etc/postfix/smime.crt"
SERVERSIGNED="=?utf-8?B?8J+UkA==?="

SENDMAIL="/usr/sbin/sendmail -G -i" # NEVER NEVER NEVER use "-t" here.
export RANDFILE="/tmp/encrypt.rnd"

FROM="$2" 
TO="$4"
EX_TEMPFAIL=75

encrypt () {
        /usr/bin/openssl smime -sign -signer "${SIGNCERT}" -inkey "${SIGNKEY}" |\
        /usr/bin/openssl smime -encrypt -aes256 -from "${FROM}" -to "${TO}" -subject "${SERVERSIGNED}" "${CERT}" |\
        $SENDMAIL "$@"
}

send () {
        $SENDMAIL "$@"
}

if [ -e "${CERT}" ]
then
        TMPFILE="$(mktemp)"
        trap "rm '$TMPFILE'" EXIT
        cat > "$TMPFILE"
        (
        if grep -q application/pgp-encrypted "$TMPFILE"
        then
                send "$@"
                exit $?
        fi
        encrypt "$@"
        exit $?
        ) < "$TMPFILE"
else
        send "$@"
        exit $?
fi

if [ $? -ne 0 ]
then
	exit $EX_TEMPFAIL
fi
