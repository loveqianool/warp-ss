FROM alpine:edge
RUN apk add -U wireguard-tools curl tzdata && rm -rf /var/cache/apk/*
RUN sed -i "s:sysctl -q net.ipv4.conf.all.src_valid_mark=1:echo Skipping setting net.ipv4.conf.all.src_valid_mark:" /usr/bin/wg-quick

RUN curl https://developers.cloudflare.com/cloudflare-one/static/documentation/connections/Cloudflare_CA.pem \
 -o /usr/local/share/ca-certificates/Cloudflare_CA.pem \
 && update-ca-certificates

RUN ARCH=$(arch) && \
if [ "$ARCH" == "aarch64" ]; then ARCH=arm64; else ARCH=amd64; fi && \
v2p=https://github.com/zhfreal/v2ray-plugin/releases/download/$(curl -s "https://api.github.com/repos/zhfreal/v2ray-plugin/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/v2ray-plugin_linux_$ARCH.zip && \
curl -sL $v2p -o /tmp/v2p.zip && \
unzip /tmp/v2p.zip -d /usr/local/bin/ && \
rm /tmp/v2p.zip

RUN ss=https://github.com/shadowsocks/shadowsocks-rust/releases/download/$(curl -s "https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/shadowsocks-$(curl -s "https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/').$(arch)-unknown-linux-musl.tar.xz && \
curl -sL $ss -o - | tar -Jxv -C /usr/local/bin

COPY z.sh /z.sh
RUN chmod +x /z.sh

CMD ["sh","-c","/z.sh"]
