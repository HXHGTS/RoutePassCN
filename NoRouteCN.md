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
```
