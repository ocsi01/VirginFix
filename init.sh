#! /bin/bash

File_Path="ARP_call.pcap"
Config_File_Path="Arp.conf"
Router_IP="192.168.0.1"
Flood_period_in_Seconds="1"
SSID_Check_intervall="5"

echo "Default IP for Router: $Router_IP"

Mac_Address="$(ifconfig en0 | grep ether | cut -d ' ' -f 2)"
echo "Your wifi adaptors MAC address: $Mac_Address"

IP_Address="$(ifconfig en0 | grep 'inet ' | cut -d ' ' -f 2)"
echo "Your wifi adaptors IP Address: $IP_Address"

MySSID="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')"
echo "your wifi SSID is: $MySSID"
echo "# The SSID of your home network" > $Config_File_Path
echo "UPS_SSID=$MySSID" >> $Config_File_Path
echo "# Time delay in seconds between ARP calls" >> $Config_File_Path
echo "Flood_period=$Flood_period_in_Seconds" >> $Config_File_Path
echo "# Time delay in seconds between SSID Checks" >> $Config_File_Path
echo "SSID_Check_intervall=$SSID_Check_intervall" >> $Config_File_Path

echo "Generating ARP call as hexadecimal file."

#Frame - Static part
echo -n -e "\xd4\xc3\xb2\xa1\x02\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x01\x00\x00\x00\xd5\x1c\x0b\x56\x55\x86\x0e\x00\x2a\x00\x00\x00\x2a\x00\x00\x00\xff\xff\xff\xff\xff\xff" > $File_Path

# #Print MAC address as hexadecimal
echo -n -e `echo $Mac_Address | sed 's/:/\\\\x/g' | awk '{print "\\\\x"$1}'` >> $File_Path

#ARP header - Static hexdump -
echo -n -e "\x08\x06\x00\x01\x08\x00\x06\x04\x00\x01" >>  $File_Path

#Print MAC address as hexadecimal
#echo -n -e `ifconfig en0 | grep ether | cut -d ' ' -f 2 | sed 's/:/\\\\x/g' | awk '{print "\\\\x"$1}'` >> $File_Path
echo -n -e `echo $Mac_Address | sed 's/:/\\\\x/g' | awk '{print "\\\\x"$1}'` >> $File_Path

#Print fource IP as hexadecimal
for i in {1..4}
do
	DIGIT=`echo $IP_Address | cut -d '.' -f $i`
    echo -n -e `echo "obase=16; $DIGIT" | bc | awk '{print "\\\\x"$1}'` >> $File_Path
done

echo -n -e "\x00\x00\x00\x00\x00\x00" >> $File_Path

#Print Router IP as hexadecimal
for i in {1..4}
do
	DIGIT=`echo $Router_IP | cut -d '.' -f $i`
    echo -n -e `echo "obase=16; $DIGIT" | bc | awk '{print "\\\\x"$1}'` >> $File_Path
done
