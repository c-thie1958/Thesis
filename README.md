# Thesis

The Detachable Drone Hijacker targets 802.11a/b/g/n drones using 
ddh.sh is the bash executable using a Ubuntu native OS that calls the aircrack-ng tool set (software version 1.7) for targeting 802.11 WiFi drones. For this to work, one must also have an understanding of the OUIs for targeted drones.

May 2, 2022 Experiment Results: https://youtu.be/z3wXflZA0q0

Detachable Drone Hijacker Hardware/Software

Raspberry Pi 4.0: https://www.raspberrypi.com/products/raspberry-pi-4-model-b/

Native Ubuntu OS: https://ubuntu.com/download/raspberry-pi?ref=mceyes.me

Alfa AWUS036ACH Network Card: https://www.alfa.com.tw/products/awus036ach?variant=36473965871176

Persistent Systems Embedded Module: https://www.persistentsystems.com/embedded-module/

Aircrack-ng: https://www.aircrack-ng.org/

OUI Lookup: https://standards-oui.ieee.org/oui/oui.txt

Ground Control Station:

Persistent Systems MPU5: https://www.persistentsystems.com/mpu5/

Personal Laptop Running Ubuntu OS: https://ubuntu.com/download

Caveats:

1. Native Ubuntu is not required.
2. Future development shouldl incorporate more capable PC boards and radios (e.g., USRP B205 for miniaturization) to increase capability of the DDH.
3. Using the WaveRelay MPU5 Embedded Module enabled persistent virtual network connection from the ground control station to the DDH payload.
