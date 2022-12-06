EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 13
Title "LedBar - MainBoard"
Date "2022-12-06"
Rev "2.0"
Comp "Roel Drost"
Comment1 "GNU General Public License v3.0"
Comment2 ""
Comment3 ""
Comment4 "4 channel RGBW LED bar, Arduino compatible with isolated half duplex RS485."
$EndDescr
$Comp
L Driver_LED:PCA9685PW U501
U 1 1 60A0A25E
P 2500 2600
F 0 "U501" H 3000 3450 50  0000 R CNN
F 1 "PCA9685PW" V 2500 2600 50  0000 C CNN
F 2 "Package_SO:TSSOP-28_4.4x9.7mm_P0.65mm" H 2525 1625 50  0001 L CNN
F 3 "http://www.nxp.com/documents/data_sheet/PCA9685.pdf" H 2100 3300 50  0001 C CNN
F 4 "i2c: 0x40" H 2500 2150 50  0000 C CNN "I2C_Address"
	1    2500 2600
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0502
U 1 1 60A0C507
P 2500 1300
F 0 "#PWR0502" H 2500 1150 50  0001 C CNN
F 1 "+5V" H 2515 1473 50  0000 C CNN
F 2 "" H 2500 1300 50  0001 C CNN
F 3 "" H 2500 1300 50  0001 C CNN
	1    2500 1300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C501
U 1 1 60A0D036
P 2750 1500
F 0 "C501" V 2498 1500 50  0000 C CNN
F 1 "0.1uF" V 2589 1500 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 2788 1350 50  0001 C CNN
F 3 "~" H 2750 1500 50  0001 C CNN
	1    2750 1500
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0503
U 1 1 60A0DBA0
P 2500 3800
F 0 "#PWR0503" H 2500 3550 50  0001 C CNN
F 1 "GND" H 2505 3627 50  0000 C CNN
F 2 "" H 2500 3800 50  0001 C CNN
F 3 "" H 2500 3800 50  0001 C CNN
	1    2500 3800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0504
U 1 1 60A0DC0A
P 2900 1500
F 0 "#PWR0504" H 2900 1250 50  0001 C CNN
F 1 "GND" V 2905 1372 50  0000 R CNN
F 2 "" H 2900 1500 50  0001 C CNN
F 3 "" H 2900 1500 50  0001 C CNN
	1    2900 1500
	0    -1   -1   0   
$EndComp
Text HLabel 1000 1900 0    50   Input ~ 0
scl
Text HLabel 1000 2000 0    50   BiDi ~ 0
sda
Text HLabel 1000 2200 0    50   Input ~ 0
~oe~
Wire Wire Line
	2500 3700 2500 3800
Wire Wire Line
	1800 2100 1700 2100
Wire Wire Line
	1700 2800 1800 2800
Connection ~ 1700 2800
Wire Wire Line
	1700 2800 1700 2900
Wire Wire Line
	1700 2900 1800 2900
Connection ~ 1700 2900
Wire Wire Line
	1700 2900 1700 3000
Wire Wire Line
	1700 3000 1800 3000
Connection ~ 1700 3000
Wire Wire Line
	1700 3000 1700 3100
Wire Wire Line
	1700 3100 1800 3100
Connection ~ 1700 3100
Wire Wire Line
	1700 3100 1700 3200
Wire Wire Line
	1700 3200 1800 3200
Connection ~ 1700 3200
Wire Wire Line
	1700 3200 1700 3300
Wire Wire Line
	1700 3300 1800 3300
Connection ~ 1700 3300
Wire Wire Line
	1700 3300 1700 3800
$Comp
L power:GND #PWR0501
U 1 1 608B3662
P 1700 3800
F 0 "#PWR0501" H 1700 3550 50  0001 C CNN
F 1 "GND" H 1705 3627 50  0000 C CNN
F 2 "" H 1700 3800 50  0001 C CNN
F 3 "" H 1700 3800 50  0001 C CNN
	1    1700 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 1900 3750 1900
Wire Wire Line
	3200 2000 3750 2000
Wire Wire Line
	3200 2100 3750 2100
Wire Wire Line
	3200 2200 3750 2200
Wire Wire Line
	3200 2300 3750 2300
Wire Wire Line
	3200 2400 3750 2400
Wire Wire Line
	3200 2500 3750 2500
Wire Wire Line
	3200 2600 3750 2600
Wire Wire Line
	3200 2700 3750 2700
Wire Wire Line
	3200 2800 3750 2800
Wire Wire Line
	3200 2900 3750 2900
Wire Wire Line
	3200 3000 3750 3000
Wire Wire Line
	3200 3100 3750 3100
Wire Wire Line
	3200 3200 3750 3200
Wire Wire Line
	3200 3300 3750 3300
Wire Wire Line
	3200 3400 3750 3400
Text Label 3700 2000 2    50   ~ 0
strip1_g
Text Label 3700 2100 2    50   ~ 0
strip1_b
Text Label 3700 2200 2    50   ~ 0
strip1_w
Text Label 3700 2300 2    50   ~ 0
strip2_r
Text Label 3700 2400 2    50   ~ 0
strip2_g
Text Label 3700 2500 2    50   ~ 0
strip2_b
Text Label 3700 2600 2    50   ~ 0
strip2_w
Text Label 3700 2700 2    50   ~ 0
strip3_r
Text Label 3700 2800 2    50   ~ 0
strip3_g
Text Label 3700 2900 2    50   ~ 0
strip3_b
Text Label 3700 3000 2    50   ~ 0
strip3_w
Text Label 3700 3100 2    50   ~ 0
strip4_r
Text Label 3700 3200 2    50   ~ 0
strip4_g
Text Label 3700 3300 2    50   ~ 0
strip4_b
Text Label 3700 3400 2    50   ~ 0
strip4_w
$Comp
L Connector:TestPoint TP501
U 1 1 608BB8B6
P 1500 2300
F 0 "TP501" H 1442 2320 50  0000 R CNN
F 1 "~pca_oe~" H 1442 2418 50  0000 R CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 1700 2300 50  0001 C CNN
F 3 "~" H 1700 2300 50  0001 C CNN
	1    1500 2300
	1    0    0    1   
$EndComp
Wire Wire Line
	1700 2100 1700 2800
Wire Wire Line
	1500 2200 1500 2300
Connection ~ 1500 2200
Wire Wire Line
	1500 2200 1000 2200
Wire Wire Line
	1500 2200 1800 2200
Wire Wire Line
	2500 1300 2500 1500
Wire Wire Line
	2500 1500 2600 1500
Wire Wire Line
	2500 1500 2500 1600
Connection ~ 2500 1500
Wire Wire Line
	1000 1900 1800 1900
Wire Wire Line
	1000 2000 1800 2000
$Comp
L Connector_Generic:Conn_01x05 J501
U 1 1 608E095F
P 2500 5350
F 0 "J501" H 2650 5450 50  0000 C CNN
F 1 "Left" H 2650 5350 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Horizontal" H 2500 5350 50  0001 C CNN
F 3 "~" H 2500 5350 50  0001 C CNN
	1    2500 5350
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3250 5250 2700 5250
Wire Wire Line
	3250 5350 2700 5350
Wire Wire Line
	3250 5450 2700 5450
Wire Wire Line
	3250 5550 2700 5550
Text Label 3200 5350 2    50   ~ 0
strip1_g_out
Text Label 3200 5250 2    50   ~ 0
strip1_r_out
Text Label 3200 5450 2    50   ~ 0
strip1_b_out
Text Label 3200 5550 2    50   ~ 0
strip1_w_out
Wire Wire Line
	2700 5150 4000 5150
Wire Wire Line
	4000 5150 4000 5350
Wire Wire Line
	4000 5350 3750 5350
$Comp
L Device:C C502
U 1 1 608E5876
P 3750 5600
F 0 "C502" H 3865 5646 50  0000 L CNN
F 1 "0.1uF" H 3865 5555 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 3788 5450 50  0001 C CNN
F 3 "~" H 3750 5600 50  0001 C CNN
	1    3750 5600
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C503
U 1 1 608E5CC5
P 4250 5600
F 0 "C503" H 4368 5646 50  0000 L CNN
F 1 "2200uF/16V" H 4368 5555 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D10.0mm_P5.00mm" H 4288 5450 50  0001 C CNN
F 3 "~" H 4250 5600 50  0001 C CNN
	1    4250 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 5450 3750 5350
Wire Wire Line
	4000 5350 4250 5350
Wire Wire Line
	4250 5350 4250 5450
Connection ~ 4000 5350
Wire Wire Line
	4250 5750 4250 5900
Wire Wire Line
	4250 5900 4000 5900
Wire Wire Line
	3750 5900 3750 5750
Wire Wire Line
	4000 5900 4000 6100
Connection ~ 4000 5900
Wire Wire Line
	4000 5900 3750 5900
$Comp
L Connector_Generic:Conn_02x06_Odd_Even J502
U 1 1 608F02DE
P 6050 5250
F 0 "J502" H 6100 5767 50  0000 C CNN
F 1 "Center" H 6100 5676 50  0000 C CNN
F 2 "RGBW-Bar:perpendicular_pcb_1mm_female_2x6" H 6050 5250 50  0001 C CNN
F 3 "~" H 6050 5250 50  0001 C CNN
	1    6050 5250
	-1   0    0    -1  
$EndComp
Connection ~ 4000 5150
Wire Wire Line
	5750 5250 5000 5250
Wire Wire Line
	5750 5350 5000 5350
Wire Wire Line
	5750 5450 5000 5450
Wire Wire Line
	5750 5550 5000 5550
Text Label 5050 5350 0    50   ~ 0
strip2_g_out
Text Label 3700 1900 2    50   ~ 0
strip1_r
Text Label 5050 5250 0    50   ~ 0
strip2_r_out
Text Label 5050 5450 0    50   ~ 0
strip2_b_out
Text Label 5050 5550 0    50   ~ 0
strip2_w_out
Wire Wire Line
	6250 5250 7000 5250
Wire Wire Line
	6250 5350 7000 5350
Wire Wire Line
	6250 5450 7000 5450
Wire Wire Line
	6250 5550 7000 5550
Wire Wire Line
	7500 5150 7500 5350
Wire Wire Line
	7500 5350 7250 5350
$Comp
L Device:C C504
U 1 1 6090E6BB
P 7250 5600
F 0 "C504" H 7365 5646 50  0000 L CNN
F 1 "0.1uF" H 7365 5555 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 7288 5450 50  0001 C CNN
F 3 "~" H 7250 5600 50  0001 C CNN
	1    7250 5600
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C505
U 1 1 6090E6C1
P 7750 5600
F 0 "C505" H 7868 5646 50  0000 L CNN
F 1 "2200uF/16V" H 7868 5555 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D10.0mm_P5.00mm" H 7788 5450 50  0001 C CNN
F 3 "~" H 7750 5600 50  0001 C CNN
	1    7750 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7250 5450 7250 5350
Wire Wire Line
	7500 5350 7750 5350
Wire Wire Line
	7750 5350 7750 5450
Connection ~ 7500 5350
Wire Wire Line
	7750 5750 7750 5900
Wire Wire Line
	7750 5900 7500 5900
Wire Wire Line
	7250 5900 7250 5750
Wire Wire Line
	7500 5900 7500 6100
Connection ~ 7500 5900
Wire Wire Line
	7500 5900 7250 5900
$Comp
L power:GNDPWR #PWR0516
U 1 1 6090E6D1
P 7500 6100
F 0 "#PWR0516" H 7500 5900 50  0001 C CNN
F 1 "GNDPWR" H 7504 5946 50  0000 C CNN
F 2 "" H 7500 6050 50  0001 C CNN
F 3 "" H 7500 6050 50  0001 C CNN
	1    7500 6100
	1    0    0    -1  
$EndComp
Text Label 6950 5350 2    50   ~ 0
strip3_g_out
Text Label 6950 5250 2    50   ~ 0
strip3_r_out
Text Label 6950 5450 2    50   ~ 0
strip3_b_out
Text Label 6950 5550 2    50   ~ 0
strip3_w_out
$Comp
L Connector_Generic:Conn_01x05 J503
U 1 1 60922189
P 9500 5350
F 0 "J503" H 9580 5392 50  0000 L CNN
F 1 "Right" H 9580 5301 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Horizontal" H 9500 5350 50  0001 C CNN
F 3 "~" H 9500 5350 50  0001 C CNN
	1    9500 5350
	1    0    0    1   
$EndComp
Wire Wire Line
	8750 5250 9300 5250
Wire Wire Line
	8750 5350 9300 5350
Wire Wire Line
	8750 5450 9300 5450
Wire Wire Line
	8750 5550 9300 5550
Text Label 8800 5350 0    50   ~ 0
strip4_g_out
Text Label 8800 5250 0    50   ~ 0
strip4_r_out
Text Label 8800 5450 0    50   ~ 0
strip4_b_out
Text Label 8800 5550 0    50   ~ 0
strip4_w_out
Wire Wire Line
	9300 5150 7500 5150
Connection ~ 7500 5150
$Comp
L Device:Q_NMOS_GSD Q501
U 1 1 609294AA
P 5400 1000
F 0 "Q501" H 5604 1046 50  0000 L CNN
F 1 "Si2302DS" H 5604 955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 5600 1100 50  0001 C CNN
F 3 "~" H 5400 1000 50  0001 C CNN
	1    5400 1000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0507
U 1 1 6092AD65
P 5500 1350
F 0 "#PWR0507" H 5500 1150 50  0001 C CNN
F 1 "GNDPWR" H 5504 1196 50  0000 C CNN
F 2 "" H 5500 1300 50  0001 C CNN
F 3 "" H 5500 1300 50  0001 C CNN
	1    5500 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 1200 5500 1350
Wire Wire Line
	5500 800  6000 800 
Wire Wire Line
	4750 1000 5200 1000
Text Label 4800 1000 0    50   ~ 0
strip1_r
Text Label 5950 800  2    50   ~ 0
strip1_r_out
$Comp
L Device:Q_NMOS_GSD Q505
U 1 1 60938FF1
P 6900 1000
F 0 "Q505" H 7104 1046 50  0000 L CNN
F 1 "Si2302DS" H 7104 955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 7100 1100 50  0001 C CNN
F 3 "~" H 6900 1000 50  0001 C CNN
	1    6900 1000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0511
U 1 1 60938FF7
P 7000 1350
F 0 "#PWR0511" H 7000 1150 50  0001 C CNN
F 1 "GNDPWR" H 7004 1196 50  0000 C CNN
F 2 "" H 7000 1300 50  0001 C CNN
F 3 "" H 7000 1300 50  0001 C CNN
	1    7000 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 1200 7000 1350
Wire Wire Line
	7000 800  7500 800 
Wire Wire Line
	6250 1000 6700 1000
Text Label 6300 1000 0    50   ~ 0
strip1_g
Text Label 7450 800  2    50   ~ 0
strip1_g_out
$Comp
L Device:Q_NMOS_GSD Q509
U 1 1 6093C4A8
P 8400 1000
F 0 "Q509" H 8604 1046 50  0000 L CNN
F 1 "Si2302DS" H 8604 955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 8600 1100 50  0001 C CNN
F 3 "~" H 8400 1000 50  0001 C CNN
	1    8400 1000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0517
U 1 1 6093C4AE
P 8500 1350
F 0 "#PWR0517" H 8500 1150 50  0001 C CNN
F 1 "GNDPWR" H 8504 1196 50  0000 C CNN
F 2 "" H 8500 1300 50  0001 C CNN
F 3 "" H 8500 1300 50  0001 C CNN
	1    8500 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 1200 8500 1350
Wire Wire Line
	8500 800  9000 800 
Wire Wire Line
	7750 1000 8200 1000
Text Label 7800 1000 0    50   ~ 0
strip1_b
$Comp
L Device:Q_NMOS_GSD Q513
U 1 1 609401CA
P 9900 1000
F 0 "Q513" H 10104 1046 50  0000 L CNN
F 1 "Si2302DS" H 10104 955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 10100 1100 50  0001 C CNN
F 3 "~" H 9900 1000 50  0001 C CNN
	1    9900 1000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0521
U 1 1 609401D0
P 10000 1350
F 0 "#PWR0521" H 10000 1150 50  0001 C CNN
F 1 "GNDPWR" H 10004 1196 50  0000 C CNN
F 2 "" H 10000 1300 50  0001 C CNN
F 3 "" H 10000 1300 50  0001 C CNN
	1    10000 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 1200 10000 1300
Wire Wire Line
	10000 800  10500 800 
Wire Wire Line
	9250 1000 9700 1000
Text Label 9300 1000 0    50   ~ 0
strip1_w
Text Label 10450 800  2    50   ~ 0
strip1_w_out
$Comp
L Device:Q_NMOS_GSD Q502
U 1 1 60962BAC
P 5400 2000
F 0 "Q502" H 5604 2046 50  0000 L CNN
F 1 "Si2302DS" H 5604 1955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 5600 2100 50  0001 C CNN
F 3 "~" H 5400 2000 50  0001 C CNN
	1    5400 2000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0508
U 1 1 60962BB2
P 5500 2350
F 0 "#PWR0508" H 5500 2150 50  0001 C CNN
F 1 "GNDPWR" H 5504 2196 50  0000 C CNN
F 2 "" H 5500 2300 50  0001 C CNN
F 3 "" H 5500 2300 50  0001 C CNN
	1    5500 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 2200 5500 2350
Wire Wire Line
	5500 1800 6000 1800
Wire Wire Line
	4750 2000 5200 2000
Text Label 4800 2000 0    50   ~ 0
strip2_r
Text Label 5950 1800 2    50   ~ 0
strip2_r_out
$Comp
L Device:Q_NMOS_GSD Q506
U 1 1 60962BBD
P 6900 2000
F 0 "Q506" H 7104 2046 50  0000 L CNN
F 1 "Si2302DS" H 7104 1955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 7100 2100 50  0001 C CNN
F 3 "~" H 6900 2000 50  0001 C CNN
	1    6900 2000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0512
U 1 1 60962BC3
P 7000 2350
F 0 "#PWR0512" H 7000 2150 50  0001 C CNN
F 1 "GNDPWR" H 7004 2196 50  0000 C CNN
F 2 "" H 7000 2300 50  0001 C CNN
F 3 "" H 7000 2300 50  0001 C CNN
	1    7000 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 2200 7000 2350
Wire Wire Line
	7000 1800 7500 1800
Wire Wire Line
	6250 2000 6700 2000
Text Label 6300 2000 0    50   ~ 0
strip2_g
Text Label 7450 1800 2    50   ~ 0
strip2_g_out
$Comp
L Device:Q_NMOS_GSD Q510
U 1 1 60962BCE
P 8400 2000
F 0 "Q510" H 8604 2046 50  0000 L CNN
F 1 "Si2302DS" H 8604 1955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 8600 2100 50  0001 C CNN
F 3 "~" H 8400 2000 50  0001 C CNN
	1    8400 2000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0518
U 1 1 60962BD4
P 8500 2350
F 0 "#PWR0518" H 8500 2150 50  0001 C CNN
F 1 "GNDPWR" H 8504 2196 50  0000 C CNN
F 2 "" H 8500 2300 50  0001 C CNN
F 3 "" H 8500 2300 50  0001 C CNN
	1    8500 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 2200 8500 2350
Wire Wire Line
	8500 1800 9000 1800
Wire Wire Line
	7750 2000 8200 2000
Text Label 7800 2000 0    50   ~ 0
strip2_b
Text Label 8950 1800 2    50   ~ 0
strip2_b_out
$Comp
L Device:Q_NMOS_GSD Q514
U 1 1 60962BDF
P 9900 2000
F 0 "Q514" H 10104 2046 50  0000 L CNN
F 1 "Si2302DS" H 10104 1955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 10100 2100 50  0001 C CNN
F 3 "~" H 9900 2000 50  0001 C CNN
	1    9900 2000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0522
U 1 1 60962BE5
P 10000 2350
F 0 "#PWR0522" H 10000 2150 50  0001 C CNN
F 1 "GNDPWR" H 10004 2196 50  0000 C CNN
F 2 "" H 10000 2300 50  0001 C CNN
F 3 "" H 10000 2300 50  0001 C CNN
	1    10000 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 2200 10000 2350
Wire Wire Line
	10000 1800 10500 1800
Wire Wire Line
	9250 2000 9700 2000
Text Label 9300 2000 0    50   ~ 0
strip2_w
Text Label 10450 1800 2    50   ~ 0
strip2_w_out
$Comp
L Device:Q_NMOS_GSD Q503
U 1 1 6096DE78
P 5400 3000
F 0 "Q503" H 5604 3046 50  0000 L CNN
F 1 "Si2302DS" H 5604 2955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 5600 3100 50  0001 C CNN
F 3 "~" H 5400 3000 50  0001 C CNN
	1    5400 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0509
U 1 1 6096DE7E
P 5500 3350
F 0 "#PWR0509" H 5500 3150 50  0001 C CNN
F 1 "GNDPWR" H 5504 3196 50  0000 C CNN
F 2 "" H 5500 3300 50  0001 C CNN
F 3 "" H 5500 3300 50  0001 C CNN
	1    5500 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 3200 5500 3350
Wire Wire Line
	5500 2800 6000 2800
Wire Wire Line
	4750 3000 5200 3000
Text Label 4800 3000 0    50   ~ 0
strip3_r
Text Label 5950 2800 2    50   ~ 0
strip3_r_out
$Comp
L Device:Q_NMOS_GSD Q507
U 1 1 6096DE89
P 6900 3000
F 0 "Q507" H 7104 3046 50  0000 L CNN
F 1 "Si2302DS" H 7104 2955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 7100 3100 50  0001 C CNN
F 3 "~" H 6900 3000 50  0001 C CNN
	1    6900 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0513
U 1 1 6096DE8F
P 7000 3350
F 0 "#PWR0513" H 7000 3150 50  0001 C CNN
F 1 "GNDPWR" H 7004 3196 50  0000 C CNN
F 2 "" H 7000 3300 50  0001 C CNN
F 3 "" H 7000 3300 50  0001 C CNN
	1    7000 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 3200 7000 3350
Wire Wire Line
	7000 2800 7500 2800
Wire Wire Line
	6250 3000 6700 3000
Text Label 6300 3000 0    50   ~ 0
strip3_g
Text Label 7450 2800 2    50   ~ 0
strip3_g_out
$Comp
L Device:Q_NMOS_GSD Q511
U 1 1 6096DE9A
P 8400 3000
F 0 "Q511" H 8604 3046 50  0000 L CNN
F 1 "Si2302DS" H 8604 2955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 8600 3100 50  0001 C CNN
F 3 "~" H 8400 3000 50  0001 C CNN
	1    8400 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0519
U 1 1 6096DEA0
P 8500 3350
F 0 "#PWR0519" H 8500 3150 50  0001 C CNN
F 1 "GNDPWR" H 8504 3196 50  0000 C CNN
F 2 "" H 8500 3300 50  0001 C CNN
F 3 "" H 8500 3300 50  0001 C CNN
	1    8500 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 3200 8500 3350
Wire Wire Line
	8500 2800 9000 2800
Wire Wire Line
	7750 3000 8200 3000
Text Label 7800 3000 0    50   ~ 0
strip3_b
Text Label 8950 2800 2    50   ~ 0
strip3_b_out
$Comp
L Device:Q_NMOS_GSD Q515
U 1 1 6096DEAB
P 9900 3000
F 0 "Q515" H 10104 3046 50  0000 L CNN
F 1 "Si2302DS" H 10104 2955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 10100 3100 50  0001 C CNN
F 3 "~" H 9900 3000 50  0001 C CNN
	1    9900 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0523
U 1 1 6096DEB1
P 10000 3350
F 0 "#PWR0523" H 10000 3150 50  0001 C CNN
F 1 "GNDPWR" H 10004 3196 50  0000 C CNN
F 2 "" H 10000 3300 50  0001 C CNN
F 3 "" H 10000 3300 50  0001 C CNN
	1    10000 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 3200 10000 3350
Wire Wire Line
	10000 2800 10500 2800
Wire Wire Line
	9250 3000 9700 3000
Text Label 9300 3000 0    50   ~ 0
strip3_w
Text Label 10450 2800 2    50   ~ 0
strip3_w_out
$Comp
L Device:Q_NMOS_GSD Q504
U 1 1 60992B28
P 5400 4000
F 0 "Q504" H 5604 4046 50  0000 L CNN
F 1 "Si2302DS" H 5604 3955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 5600 4100 50  0001 C CNN
F 3 "~" H 5400 4000 50  0001 C CNN
	1    5400 4000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0510
U 1 1 60992B2E
P 5500 4350
F 0 "#PWR0510" H 5500 4150 50  0001 C CNN
F 1 "GNDPWR" H 5504 4196 50  0000 C CNN
F 2 "" H 5500 4300 50  0001 C CNN
F 3 "" H 5500 4300 50  0001 C CNN
	1    5500 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 4200 5500 4350
Wire Wire Line
	5500 3800 6000 3800
Wire Wire Line
	4750 4000 5200 4000
Text Label 4800 4000 0    50   ~ 0
strip4_r
Text Label 5950 3800 2    50   ~ 0
strip4_r_out
$Comp
L Device:Q_NMOS_GSD Q508
U 1 1 60992B39
P 6900 4000
F 0 "Q508" H 7104 4046 50  0000 L CNN
F 1 "Si2302DS" H 7104 3955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 7100 4100 50  0001 C CNN
F 3 "~" H 6900 4000 50  0001 C CNN
	1    6900 4000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0514
U 1 1 60992B3F
P 7000 4350
F 0 "#PWR0514" H 7000 4150 50  0001 C CNN
F 1 "GNDPWR" H 7004 4196 50  0000 C CNN
F 2 "" H 7000 4300 50  0001 C CNN
F 3 "" H 7000 4300 50  0001 C CNN
	1    7000 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 4200 7000 4350
Wire Wire Line
	7000 3800 7500 3800
Wire Wire Line
	6250 4000 6700 4000
Text Label 6300 4000 0    50   ~ 0
strip4_g
Text Label 7450 3800 2    50   ~ 0
strip4_g_out
$Comp
L Device:Q_NMOS_GSD Q512
U 1 1 60992B4A
P 8400 4000
F 0 "Q512" H 8604 4046 50  0000 L CNN
F 1 "Si2302DS" H 8604 3955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 8600 4100 50  0001 C CNN
F 3 "~" H 8400 4000 50  0001 C CNN
	1    8400 4000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0520
U 1 1 60992B50
P 8500 4350
F 0 "#PWR0520" H 8500 4150 50  0001 C CNN
F 1 "GNDPWR" H 8504 4196 50  0000 C CNN
F 2 "" H 8500 4300 50  0001 C CNN
F 3 "" H 8500 4300 50  0001 C CNN
	1    8500 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 4200 8500 4350
Wire Wire Line
	8500 3800 9000 3800
Wire Wire Line
	7750 4000 8200 4000
Text Label 7800 4000 0    50   ~ 0
strip4_b
Text Label 8950 3800 2    50   ~ 0
strip4_b_out
$Comp
L Device:Q_NMOS_GSD Q516
U 1 1 60992B5B
P 9900 4000
F 0 "Q516" H 10104 4046 50  0000 L CNN
F 1 "Si2302DS" H 10104 3955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 10100 4100 50  0001 C CNN
F 3 "~" H 9900 4000 50  0001 C CNN
	1    9900 4000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0524
U 1 1 60992B61
P 10000 4350
F 0 "#PWR0524" H 10000 4150 50  0001 C CNN
F 1 "GNDPWR" H 10004 4196 50  0000 C CNN
F 2 "" H 10000 4300 50  0001 C CNN
F 3 "" H 10000 4300 50  0001 C CNN
	1    10000 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 4200 10000 4350
Wire Wire Line
	10000 3800 10500 3800
Wire Wire Line
	9250 4000 9700 4000
Text Label 9300 4000 0    50   ~ 0
strip4_w
Text Label 10450 3800 2    50   ~ 0
strip4_w_out
$Comp
L power:+12V #PWR0505
U 1 1 608DA5AE
P 4000 5050
F 0 "#PWR0505" H 4000 4900 50  0001 C CNN
F 1 "+12V" H 4015 5223 50  0000 C CNN
F 2 "" H 4000 5050 50  0001 C CNN
F 3 "" H 4000 5050 50  0001 C CNN
	1    4000 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 5050 4000 5150
$Comp
L power:+12V #PWR0515
U 1 1 608DF9C9
P 7500 5050
F 0 "#PWR0515" H 7500 4900 50  0001 C CNN
F 1 "+12V" H 7515 5223 50  0000 C CNN
F 2 "" H 7500 5050 50  0001 C CNN
F 3 "" H 7500 5050 50  0001 C CNN
	1    7500 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 5050 7500 5150
$Comp
L power:GNDPWR #PWR0506
U 1 1 608E9633
P 4000 6100
F 0 "#PWR0506" H 4000 5900 50  0001 C CNN
F 1 "GNDPWR" H 4004 5946 50  0000 C CNN
F 2 "" H 4000 6050 50  0001 C CNN
F 3 "" H 4000 6050 50  0001 C CNN
	1    4000 6100
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP?
U 1 1 60E72D62
P 9250 1000
AR Path="/608B1159/60E72D62" Ref="TP?"  Part="1" 
AR Path="/608B2A01/60E72D62" Ref="TP502"  Part="1" 
AR Path="/617A8CB5/608B2A01/60E72D62" Ref="TP502"  Part="1" 
F 0 "TP502" V 9150 1200 50  0000 R CNN
F 1 "s1w" V 9300 1200 50  0000 R CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 9450 1000 50  0001 C CNN
F 3 "~" H 9450 1000 50  0001 C CNN
	1    9250 1000
	0    -1   -1   0   
$EndComp
$Comp
L Connector:TestPoint TP?
U 1 1 60E8F95C
P 10500 800
AR Path="/608B1159/60E8F95C" Ref="TP?"  Part="1" 
AR Path="/608B2A01/60E8F95C" Ref="TP504"  Part="1" 
AR Path="/617A8CB5/608B2A01/60E8F95C" Ref="TP504"  Part="1" 
F 0 "TP504" V 10400 1000 50  0000 R CNN
F 1 "s1w_o" V 10500 1000 50  0000 L CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 10700 800 50  0001 C CNN
F 3 "~" H 10700 800 50  0001 C CNN
	1    10500 800 
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP?
U 1 1 60EE1BB4
P 10000 1300
AR Path="/608B1159/60EE1BB4" Ref="TP?"  Part="1" 
AR Path="/608B2A01/60EE1BB4" Ref="TP503"  Part="1" 
AR Path="/617A8CB5/608B2A01/60EE1BB4" Ref="TP503"  Part="1" 
F 0 "TP503" V 9900 1650 50  0000 R CNN
F 1 "gnd" V 10000 1600 50  0000 R CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 10200 1300 50  0001 C CNN
F 3 "~" H 10200 1300 50  0001 C CNN
	1    10000 1300
	0    1    1    0   
$EndComp
Connection ~ 10000 1300
Wire Wire Line
	10000 1300 10000 1350
Wire Wire Line
	4000 5150 5750 5150
Wire Wire Line
	5750 5050 5750 5150
Connection ~ 5750 5150
Wire Wire Line
	6250 5150 6300 5150
Wire Wire Line
	6250 5050 6300 5050
Wire Wire Line
	6300 5050 6300 5150
Connection ~ 6300 5150
Wire Wire Line
	6300 5150 7500 5150
Text Label 8950 800  2    50   ~ 0
strip1_b_out
$EndSCHEMATC
