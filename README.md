# warp-ss
```
docker run -dit --name warp --network=z6 --restart=unless-stopped -e TZ="$(cat /etc/timezone)" \
-p 45644:45644/udp \
-p 45655:45655 \
-p 45655:45655/udp \
-p 45666:45666 \
-p 45666:45666/udp \
-v /opt/docker/wireguard:/etc/wireguard \
-v /opt/docker/wireguard/resolv.conf:/etc/resolv.conf:ro \
-v /lib/modules:/lib/modules:ro \
-v /opt/docker/v2ray/warp.json:/etc/v2ray/config.json \
-v /opt/docker/shadowsocks/warp.json:/etc/shadowsocks-rust/config.json \
--cap-add=NET_ADMIN \
--cap-add=SYS_MODULE \
--sysctl="net.ipv6.conf.all.disable_ipv6=0" \
--sysctl="net.ipv6.conf.all.forwarding=1" \
--sysctl="net.ipv6.conf.default.forwarding=1" \
--sysctl="net.ipv6.conf.all.proxy_ndp=1" \
--sysctl="net.ipv4.conf.all.src_valid_mark=1" \
--sysctl="net.ipv4.ip_forward=1" \
--sysctl="net.ipv4.conf.all.proxy_arp=1" \
loveqianool/warp
```
