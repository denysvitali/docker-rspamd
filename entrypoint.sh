#!/bin/sh

RSPAMD_CONTROLLER_PASSWORD=${RSPAMD_CONTROLLER_PASSWORD:-change-me}
# Set Controller password

RSPAMD_PASSWORD=$(rspamadm pw -p "$RSPAMD_CONTROLLER_PASSWORD")

cat << EOF >> /etc/rspamd/local.d/worker-controller.inc
password = "${RSPAMD_PASSWORD}";
enable_password = "${RSPAMD_PASSWORD}";
bind_socket = "*v4:11334";
EOF


if [ "$RSPAMD_MILTER_EXTENDED_SPAM_HEADERS" != "" ]; then
cat << EOF >> /etc/rspamd/local.d/milter_headers.conf
extended_spam_headers = $RSPAMD_MILTER_EXTENDED_SPAM_HEADERS;
EOF
fi

cat << EOF > /etc/rspamd/local.d/logging.inc
type = console
level = debug
log_buffer = 1024
EOF

supervisord -n -c /etc/supervisord.conf
