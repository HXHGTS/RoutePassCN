# RoutePassCN

修改Windows路由表，实现VPN类软件分流(类似于游戏加速器)

仅对WireGuard OpenVPN L2TP PPTP SSTP AnyConnect等VPN协议有效！Socks5代理不适合此方法！
```
curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep -v '#' | grep 'ipv4' | grep 'CN' > /tmp/Routes.txt

awk -v FS="|" '{printf("%s/%d\n", $4, 32-log($5)/log(2))}' /tmp/Routes.txt > /tmp/Routes.tmp

cat /tmp/Routes.tmp | sed 's/^/add /' | sed 's/$/ default METRIC default IF default/' > /tmp/AddRoutes.txt

cat /tmp/Routes.tmp | sed 's/^/delete /' | sed 's/$/ default METRIC default IF default/' > /tmp/DelRoutes.txt

rm -f /tmp/Routes.tmp /tmp/Routes.txt
```
