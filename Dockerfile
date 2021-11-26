FROM alpine:edge
RUN apk add -U wireguard-tools
RUN sed -i "s:sysctl -q net.ipv4.conf.all.src_valid_mark=1:echo Skipping setting net.ipv4.conf.all.src_valid_mark:" /usr/bin/wg-quick
##RUN wget https://github.com/shadowsocks/shadowsocks-rust/releases/latest/download/shadowsocks-v1.11.1.aarch64-unknown-linux-musl.tar.xz
##RUN tar xf shadowsocks-v1.11.1.aarch64-unknown-linux-musl.tar.xz
##CMD ["sh","-c","z.sh"]

CMD ["wg-quick","up","wg0"]
