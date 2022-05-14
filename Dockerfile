FROM alpine:edge
RUN apk add -U wireguard-tools curl tzdata && rm -rf /var/cache/apk/*
RUN sed -i "s:sysctl -q net.ipv4.conf.all.src_valid_mark=1:echo Skipping setting net.ipv4.conf.all.src_valid_mark:" /usr/bin/wg-quick

RUN curl https://developers.cloudflare.com/cloudflare-one/static/documentation/connections/Cloudflare_CA.pem \
 -o /usr/local/share/ca-certificates/Cloudflare_CA.pem \
 && update-ca-certificates

RUN ss=https://github.com/shadowsocks/shadowsocks-rust/releases/download/$(curl -s "https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/shadowsocks-$(curl -s "https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/').$(arch)-unknown-linux-musl.tar.xz && \
curl -sL $ss -o - | tar -Jxv -C /usr/local/bin

RUN ARCH=$(arch) && \
if [ "$ARCH" == "aarch64" ]; then ARCH=arm64-v8a; else ARCH=64; fi && \
v2=https://github.com/v2fly/v2ray-core/releases/download/$(curl -s "https://api.github.com/repos/v2fly/v2ray-core/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/v2ray-linux-$ARCH.zip && \
curl -sL $v2 -o /tmp/v2.zip && \
unzip /tmp/v2.zip v2ray -d /usr/local/bin/ && \
mkdir /usr/local/share/v2ray && \
curl -sL https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -o /usr/local/share/v2ray/geoip.dat && \
curl -sL https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -o /usr/local/share/v2ray/geosite.dat && \
rm /tmp/v2.zip

RUN ARCH=$(arch) && \
if [ "$ARCH" == "aarch64" ]; then ARCH=arm64; else ARCH=amd64; fi && \
v2p=https://github.com/zhfreal/v2ray-plugin/releases/download/$(curl -s "https://api.github.com/repos/zhfreal/v2ray-plugin/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/v2ray-plugin_linux_$ARCH.zip && \
curl -sL $v2p -o /tmp/v2p.zip && \
unzip /tmp/v2p.zip -d /usr/local/bin/ && \
mv /usr/local/bin/v2ray-plugin_* /usr/local/bin/v2ray-plugin && \
rm /tmp/v2p.zip

COPY z.sh /z.sh
RUN chmod +x /z.sh

CMD ["sh","-c","/z.sh"]
