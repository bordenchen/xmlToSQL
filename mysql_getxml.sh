#!/bin/bash


meinong_xml=($(python3.6 ~/python_code/meinong_xml.py 2>&1 |  tr -d "[] '"| tr "," " " ))
pingtung_xml=($(python3.6 ~/python_code/pingtung_xml.py 2>&1 |  tr -d "[] '"| tr "," " " ))


meinong=($(python3.6 ~/python_code/meinong.getAQI.0515.py 2>&1 |  tr -d "[] '"| tr "," " " ))
pingtung=($(python3.6 ~/python_code/pingtung.getAQI.0515.py 2>&1 |  tr -d "[] '"| tr "," " " ))

DATE=$(date +%Y-%m-%d-%H-%M)

mysql -u borden -pwufunchen1996 <<EOFMYSQL
USE AQI_data;
INSERT INTO meinong(PM25,PM10,CO,SO2,O3,WindDirection,WindSpeed,Publishtime, TEMP, HUMD, PRES, SUN, H_24R, H_FX, H_XD, H_FXT)
VALUES (${meinong[0]},${meinong[1]},${meinong[2]},${meinong[3]},${meinong[4]},${meinong[5]},${meinong[6]},'${meinong[7]}',${meinong_xml[0]},${meinong_xml[1]},${meinong_xml[2]},${meinong_xml[3]},${meinong_xml[4]},${meinong_xml[5]},${meinong_xml[6]},${meinong_xml[7]});
INSERT INTO pingtung(PM25,PM10,CO,SO2,O3,WindDirection,WindSpeed,Publishtime,TEMP, HUMD, PRES, SUN, H_24R, H_FX, H_XD, H_FXT)
VALUES (${pingtung[0]},${pingtung[1]},${pingtung[2]},${pingtung[3]},${pingtung[4]},${pingtung[5]},${pingtung[6]},'${pingtung[7]}', ${pingtung_xml[0]},${pingtung_xml[1]},${pingtung_xml[2]},${pingtung_xml[3]},${pingtung_xml[4]},${pingtung_xml[5]},${pingtung_xml[6]},${pingtung_xml[7]});

EOFMYSQL
