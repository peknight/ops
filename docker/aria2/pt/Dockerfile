FROM debian:8
RUN groupadd -r -g 1000 server && useradd -r -g server -m -d /home/server -u 1000 server && mkdir -p /home/server/.aria2 && chown -R server:server /home/server
RUN apt-get update \
	&& apt-get install -y aria2 busybox curl unzip \
	&& rm -rf /var/lib/apt/lists/*
ADD ./docs /webui-aria2
RUN GITHUB_REPO="https://github.com/tianon/gosu" \
  && LATEST=`curl -s  $GITHUB_REPO"/releases/latest" | grep -Eo "[0-9].[0-9]*"` \
  && curl -L $GITHUB_REPO"/releases/download/"$LATEST"/gosu-amd64" > /usr/local/bin/gosu \
  && chmod +x /usr/local/bin/gosu
RUN GITHUB_REPO="https://github.com/mattn/goreman" \
  && LATEST=`curl -s  $GITHUB_REPO"/releases/latest" | grep -Eo "v[0-9]*.[0-9]*.[0-9]*"` \
  && curl -L $GITHUB_REPO"/releases/download/"$LATEST"/goreman_linux_amd64.zip" > goreman.zip \
  && unzip goreman.zip && mv /goreman /usr/local/bin/goreman && rm -R goreman*
RUN echo "web: gosu server /bin/busybox httpd -f -p 39100 -h /webui-aria2\nbackend: gosu server /usr/bin/aria2c --enable-rpc --rpc-listen-all --dir=/data" > Procfile
VOLUME /data
EXPOSE 36800/tcp
EXPOSE 39100/tcp
EXPOSE 35600-35699/tcp 35600-35699/udp
CMD ["start"]
ENTRYPOINT ["/usr/local/bin/goreman"]
