FROM alpine:latest
MAINTAINER Dimitrios Tzortzis

RUN apk add --update \
        bash \
        curl \
    && rm -rf /var/cache/apk/*

ADD CheckWANIP.sh entrypoint.sh /
ADD trigger_check /etc/periodic/15min

RUN chmod +x /CheckWANIP.sh /entrypoint.sh \
 && chmod a+x /etc/periodic/15min/trigger_check

ENTRYPOINT ["/entrypoint.sh"]
CMD crond -l 2 -f
