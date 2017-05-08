# iSCSI target

`docker pull wtnb75/stgt`

## To Use

```sh
docker run --name stgt -p 3260:3260 -d wtnb75/stgt
docker exec stgt truncate -s 100G /disk1.img
docker exec stgt tgtadm --mode target --op new --tid 1 --targetname tgt1
docker exec stgt tgtadm --mode logicalunit --op new --tid 1 --lun 1 --backing-store /disk1.img
docker exec stgt tgtadm --mode target --op bind --tid 1 --initiator-address 192.168.1.0/24
docker exec stgt tgtadm --mode target --op show
```
