#!/bin/sh
yc compute instance create --name reddit-app --hostname reddit-app --memory=4 --create-boot-disk image-id=fd853vb6a9ijivvdmdjj,size=10GB --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --metadata serial-port-enable=1 --metadata-from-file user-data=../config-scripts/startup.yaml
