FROM alpine:edge
RUN apk add -U wireguard-tools curl tzdata && rm -rf /var/cache/apk/*
RUN sed -i "s:sysctl -q net.ipv4.conf.all.src_valid_mark=1:echo Skipping setting net.ipv4.conf.all.src_valid_mark:" /usr/bin/wg-quick

RUN curl https://developers.cloudflare.com/cloudflare-one/static/documentation/connections/Cloudflare_CA.pem \
 -o /usr/local/share/ca-certificates/Cloudflare_CA.pem \
 update-ca-certificates

##RUN wget https://github.com/shadowsocks/shadowsocks-rust/releases/latest/download/shadowsocks-v1.11.1.aarch64-unknown-linux-musl.tar.xz
##RUN tar xf shadowsocks-v1.11.1.aarch64-unknown-linux-musl.tar.xz

COPY z.sh /z.sh
RUN chmod +x /z.sh

CMD ["sh","-c","/z.sh"]
