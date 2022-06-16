#!/bin/sh -ex

if [ ! -f "/etc/wireguard/wg0.conf" ]; then
 echo warp 配置文件不存在
else
 echo 启动warp
wg-quick up wg0
sleep 3
fi

if [ ! -f "/etc/shadowsocks-rust/config.json" ]; then
 echo ss 配置文件不存在
else
 echo 启动ss
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
 echo 启动xray
xray run -c /etc/xray/config.json &
fi

sleep infinity & wait
