#!/bin/sh

if [ "$ipv6" = "yes" ]; then
echo ipv6 优先
else
sed -e "s/^#precedence ::ffff:0:0\/96\s\s100\$/precedence ::ffff:0:0\/96 100/g" -i /etc/gai.conf
echo ipv4 优先
fi

if [ ! -f "/etc/wireguard/wg0.conf" ]; then
 echo warp 配置文件不存在
else
 echo 启动 warp
chmod 600 /etc/wireguard/*.conf
wg-quick up wg0
sleep 3
fi

if [ ! -f "/etc/shadowsocks-rust/config.json" ]; then
 echo ss 配置文件不存在
else
 echo 启动 ss
ssserver -c /etc/shadowsocks-rust/config.json &
fi

if [ ! -f "/etc/v2ray/config.json" ]; then
 echo v2 配置文件不存在
else
 echo 启动v2
v2ray run -c /etc/v2ray/config.json &
fi

if [ ! -f "/etc/xray/config.json" ]; then
 echo xray 配置文件不存在
else
 echo 启动 xray
xray run -c /etc/xray/config.json &
fi

sleep infinity & wait
