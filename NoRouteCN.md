```
curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep -v '#' | grep 'ipv4' | grep -v 'CN' | grep -v 'summary' > /tmp/Routes.txt
awk -v FS="|" '{printf("%s/%d\n", $4, 32-log($5)/log(2))}' /tmp/Routes.txt > /tmp/Routes.tmp

sed -i 's/\/8/ mask 255.0.0.0/' /tmp/Routes.tmp
sed -i 's/\/9/ mask 255.128.0.0/' /tmp/Routes.tmp
sed -i 's/\/10/ mask 255.192.0.0/' /tmp/Routes.tmp
sed -i 's/\/11/ mask 255.224.0.0/' /tmp/Routes.tmp
sed -i 's/\/12/ mask 255.240.0.0/' /tmp/Routes.tmp
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

cat /tmp/Routes.tmp | sed 's/^/add /' | sed 's/$/ default METRIC default IF default/' > /tmp/AddRoute.txt
cat /tmp/Routes.tmp | sed 's/^/delete /' | sed 's/$/ default METRIC default IF default/' > /tmp/DelRoute.txt
rm -f /tmp/Routes.tmp /tmp/Routes.txt
```

```
curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep -v '#' | grep 'ipv6' | grep -v 'CN' | grep -v '*' > /tmp/Routes6.txt

awk -v FS="|" '{printf("%s/%d\n", $4, 32-log($5)/log(2))}' /tmp/Routes6.txt > /tmp/Routes6.tmp

echo 'set TUNGW6=fe80::1' >  /tmp/AddRoute6.bat

cat /tmp/Routes6.tmp | sed 's/^/route add /' | sed 's/$/ %TUNGW6%/' >> /tmp/AddRoute6.bat

cat /tmp/Routes6.tmp | sed 's/^/route delete /' > /tmp/DelRoute6.bat

rm -f /tmp/Routes6.tmp /tmp/Routes6.txt
```
