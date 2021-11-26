# warp-ss
```
docker run -dit --name wireguard --network=z6 --restart=unless-stopped -e TZ="$(cat /etc/timezone)" \
-p 45644:45644/udp \
-p 45666:45666 \
-p 45666:45666/udp \
-v /opt/docker/wireguard:/etc/wireguard \
--cap-add=NET_ADMIN \
--cap-add=SYS_MODULE \
--sysctl="net.ipv6.conf.all.disable_ipv6=0" \
--sysctl="net.ipv4.conf.all.src_valid_mark=1" \
--sysctl="net.ipv4.ip_forward=1" \
--sysctl="net.ipv4.conf.all.proxy_arp=1" \
alpine:edge
```
