#SenseHat logging script for measuring temp, pressure,humidity

import csv
import gpiozero
import psutil

from csv import writer
from sense_hat import SenseHat
from datetime import datetime
from gpiozero import CPUTemperature, PingServer
from time import sleep, strftime, time

sense = SenseHat()
cpu = CPUTemperature()
#zephyr = PingServer('google.com')


def get_sense_data():
    sense_data = []
    sense_data.append(datetime.now())
    sense_data.append(sense.get_temperature())
    sense_data.append(sense.get_pressure())
    sense_data.append(sense.get_humidity())
    
    sense_data.append(CPUTemperature())
    sense_data.append(psutil.cpu_percent(percpu=True))
    sense_data.append(psutil.cpu_freq())
    sense_data.append(psutil.getloadavg())
    
    orientation = sense.get_orientation()
    sense_data.append(orientation["yaw"])
    sense_data.append(orientation["pitch"])
    sense_data.append(orientation["roll"])
    
    mag = sense.get_compass_raw()
    sense_data.append(mag["x"])
    sense_data.append(mag["y"])
    sense_data.append(mag["z"])
    
    acc = sense.get_accelerometer_raw()
    sense_data.append(acc["x"])
    sense_data.append(acc["y"])
    sense_data.append(acc["z"])
    
    gyro=sense.get_gyroscope_raw()
    sense_data.append(gyro["x"])
    sense_data.append(gyro["y"])
    sense_data.append(gyro["z"])

    return sense_data

with open('log_thesis.csv','w',newline='') as file1:
    data_writer = writer(file1)
    data_writer.writerow(['datetime','airtemp','pres','hum','cputemp','cpupercent',
                          'cpufreq','cpuloadavg','orientation_yaw','orientation_pitch',
                          'orientation_roll','compass_raw_x','compass_raw_y', 'compass_raw_z',
                          'accelerometer_x','accelerometer_y', 'accelerometer_z',
                          'gyroscope_raw_x','gyroscope_raw_y','gyroscope_raw_z'])

    while True:
        print(get_sense_data())
        data = get_sense_data()
        data_writer.writerow(data)
        
