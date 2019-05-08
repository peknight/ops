FROM alpine:3.9.3
MAINTAINER peknight <JKpeknight@gmail.com>

RUN apk add privoxy

EXPOSE 8118 

ENTRYPOINT ["privoxy", "--no-daemon", "/etc/privoxy/config"]
