#FROM alpine:edge
#RUN apk add -U wireguard-tools curl tzdata && rm -rf /var/cache/apk/*
FROM debian:testing

RUN apt update && apt install -y \
wireguard curl tzdata unzip xz-utils \
&& apt clean \
&& rm -rf /var/lib/apt/lists/*

RUN sed -e "s/^#precedence ::ffff:0:0\/96\s\s100\$/precedence ::ffff:0:0\/96 100/g" -i /etc/gai.conf

RUN sed -i "s:sysctl -q net.ipv4.conf.all.src_valid_mark=1:echo Skipping setting net.ipv4.conf.all.src_valid_mark:" /usr/bin/wg-quick \
 && curl https://developers.cloudflare.com/cloudflare-one/static/documentation/connections/Cloudflare_CA.pem \
 -o /usr/local/share/ca-certificates/Cloudflare_CA.pem \
 && chmod 644 /usr/local/share/ca-certificates/Cloudflare_CA.pem \
 && update-ca-certificates

RUN ss=https://github.com/shadowsocks/shadowsocks-rust/releases/download/$(curl -s "https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/shadowsocks-$(curl -s "https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/').$(arch)-unknown-linux-musl.tar.xz && \
curl -sL $ss -o - | tar -Jxv -C /usr/local/bin \
&& ARCH=$(arch) && \
if [ "$ARCH" == "aarch64" ]; then ARCH=arm64; else ARCH=amd64; fi && \
v2p=https://github.com/teddysun/v2ray-plugin/releases/download/$(curl -s "https://api.github.com/repos/teddysun/v2ray-plugin/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/v2ray-plugin-linux-$ARCH-$(curl -s "https://api.github.com/repos/teddysun/v2ray-plugin/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/').tar.gz && \
curl -sL $v2p -o - | tar -zxv -C /usr/local/bin && \
mv /usr/local/bin/v2ray-plugin_* /usr/local/bin/v2ray-plugin

RUN ARCH=$(arch) && \
if [ "$ARCH" == "aarch64" ]; then ARCH=arm64-v8a; else ARCH=64; fi && \
v2=https://github.com/v2fly/v2ray-core/releases/download/$(curl -s "https://api.github.com/repos/v2fly/v2ray-core/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/v2ray-linux-$ARCH.zip && \
xr=https://github.com/XTLS/Xray-core/releases/download/$(curl -s "https://api.github.com/repos/XTLS/Xray-core/releases" | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/Xray-linux-$ARCH.zip && \
curl -sL $v2 -o /tmp/v2.zip && \
curl -sL $xr -o /tmp/xr.zip && \
unzip /tmp/v2.zip v2ray -d /usr/local/bin/ && \
unzip /tmp/xr.zip xray -d /usr/local/bin/ && \
mkdir /usr/local/share/v2ray && \
mkdir /usr/local/share/xray && \
curl -sL https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -o /usr/local/share/v2ray/geoip.dat && \
curl -sL https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -o /usr/local/share/v2ray/geosite.dat && \
ln -s /usr/local/share/v2ray/geoip.dat /usr/local/share/xray && \
ln -s /usr/local/share/v2ray/geosite.dat /usr/local/share/xray && \
rm /tmp/*.zip

COPY z.sh /z.sh
RUN chmod +x /z.sh

CMD ["sh","-c","/z.sh"]
