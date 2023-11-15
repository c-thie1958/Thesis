# Thesis

The Detachable Drone Hijacker targets 802.11a/b/g/n drones using 
ddh.sh is the bash executable using a Ubuntu native OS that calls the aircrack-ng tool set (software version 1.7) for targeting 802.11 WiFi drones. For this to work, one must also have an understanding of the OUIs for targeted drones. Additional files in this repo are for logging and the udp/tcp flood bash scripts were experimental tests for broadcasting TCP/UDP packets targeting multiple drones at once. The TCP/UDP bash scripts were partially successful, but not immediately repeatable, resulting in the reliance on a drones OUI that is broadcasted using 802.11 beacon frames for targeting purposes.

May 2, 2022 Experiment Results: https://youtu.be/z3wXflZA0q0

Detachable Drone Hijacker Hardware/Software

1. Raspberry Pi 4.0: https://www.raspberrypi.com/products/raspberry-pi-4-model-b/
2. Native Ubuntu OS: https://ubuntu.com/download/raspberry-pi?ref=mceyes.me
3. Alfa AWUS036ACH Network Card: https://www.alfa.com.tw/products/awus036ach?variant=36473965871176
4. Persistent Systems Embedded Module: https://www.persistentsystems.com/embedded-module/
5. Aircrack-ng: https://www.aircrack-ng.org/
6. OUI Lookup: https://standards-oui.ieee.org/oui/oui.txt

Ground Control Station:
1. Persistent Systems MPU5: https://www.persistentsystems.com/mpu5/
2. Personal Laptop Running Ubuntu OS: https://ubuntu.com/download

Caveats:

1. Native Ubuntu is not required.
2. Future development shouldl incorporate more capable PC boards and radios (e.g., USRP B205 for miniaturization) to increase capability of the DDH.
3. Using the WaveRelay MPU5 Embedded Module enabled persistent virtual network connection from the ground control station to the DDH payload.

DSP_Docs holds the basic README for Gnu Radio Companion (GRC) raw signal capture, demodulation, and decoding of several popular drone FHSS signals. Further analysis needed to analyze and develop a transmitter that exploits vulnerabilities.
