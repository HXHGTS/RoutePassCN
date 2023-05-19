# RoutePassCN

修改Windows路由表，实现VPN类软件分流(类似于游戏加速器)

仅对WireGuard OpenVPN L2TP PPTP SSTP AnyConnect等VPN协议有效！Socks5代理不适合此方法！

```
curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep -v '#' | grep 'ipv4' | grep 'CN' > /tmp/Routes.txt

awk -v FS="|" '{printf("%s/%d\n", $4, 32-log($5)/log(2))}' /tmp/Routes.txt > /tmp/Routes.tmp

sed -i 's/\/13/ mask 255.248.0.0/' /tmp/Routes.tmp
sed -i 's/\/14/ mask 255.252.0.0/' /tmp/Routes.tmp
sed -i 's/\/15/ mask 255.254.0.0/' /tmp/Routes.tmp
sed -i 's/\/16/ mask 255.255.0.0/' /tmp/Routes.tmp
sed -i 's/\/17/ mask 255.255.128.0/' /tmp/Routes.tmp
sed -i 's/\/18/ mask 255.255.192.0/' /tmp/Routes.tmp
sed -i 's/\/19/ mask 255.255.224.0/' /tmp/Routes.tmp
sed -i 's/\/20/ mask 255.255.240.0/' /tmp/Routes.tmp
sed -i 's/\/21/ mask 255.255.248.0/' /tmp/Routes.tmp
sed -i 's/\/22/ mask 255.255.252.0/' /tmp/Routes.tmp
sed -i 's/\/23/ mask 255.255.254.0/' /tmp/Routes.tmp
sed -i 's/\/24/ mask 255.255.255.0/' /tmp/Routes.tmp

cat /tmp/Routes.tmp | sed 's/^/add /' | sed 's/$/ default METRIC default IF default/' > /tmp/AddRoutes.txt

cat /tmp/Routes.tmp | sed 's/^/delete /' | sed 's/$/ default METRIC default IF default/' > /tmp/DelRoutes.txt

rm -f /tmp/Routes.tmp /tmp/Routes.txt
```
