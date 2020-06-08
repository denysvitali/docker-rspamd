FROM alpine:3.12
RUN apk add --no-cache \
      rspamd \
      rspamd-client \
      rspamd-controller \
      rspamd-utils \
      supervisor
COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
