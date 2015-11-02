#! /bin/bash

File_Path="ARP_call.pcap"

while [ "true" ]
do
  tcpreplay -i en0 $File_Path > arp.log 2> arp_error.log
  sleep 1
done