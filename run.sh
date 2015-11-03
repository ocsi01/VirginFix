#! /bin/bash

File_Path="ARP_call.pcap"
Config_File_Path="Arp.conf"
i=1

echo "Reading config...."
source $Config_File_Path


echo "SSID: $UPS_SSID"
echo "ARP call intervall: $Flood_period s"
echo "SSID Check intervall: $SSID_Check_intervall s"

while [ "true" ]
do
  MySSID="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')"
  if [ $MySSID == $UPS_SSID ]
  then
    tcpreplay -i en0 $File_Path > arp.log 2> arp_error.log
    if [ $i -eq 1 ]
    then
      echo -n "ARP sent."
    else
      echo -n "."
    fi
    
    if [ $i -eq 10 ]
    then
      i=1
      echo -n $'\r'"                                  "$'\r'
    else
      i=$((i+1))
    fi
    
    sleep 1
  else
    echo -n "Not the configured WiFi network "$'\r'
    sleep $SSID_Check_intervall
  fi
done