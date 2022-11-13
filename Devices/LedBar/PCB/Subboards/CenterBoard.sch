EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 13
Title ""
Date "2022-06-26"
Rev "1.0"
Comp ""
Comment1 "GNU General Public License v3.0"
Comment2 ""
Comment3 ""
Comment4 "4 channel RGBW LED bar, Arduino compatible with isolated half duplex RS485."
$EndDescr
$Comp
L RGBW-Bar:Conn_RGBW J?
U 1 1 61892900
P 7500 3700
AR Path="/618804D0/61892900" Ref="J?"  Part="1" 
AR Path="/6188055C/61892900" Ref="J?"  Part="1" 
AR Path="/6188050F/61892900" Ref="J1203"  Part="1" 
AR Path="/6371587E/61892900" Ref="J1203"  Part="1" 
F 0 "J1203" H 7400 3300 50  0000 L CNN
F 1 "Strip3_RGBW" H 7250 3400 50  0000 L CNN
F 2 "RGBW-Bar:RGBW-wire-solder-pads-L" H 7500 3700 50  0001 C CNN
F 3 "~" H 7500 3700 50  0001 C CNN
	1    7500 3700
	1    0    0    1   
$EndComp
$Comp
L RGBW-Bar:Conn_RGBW J?
U 1 1 6189334E
P 3500 3700
AR Path="/618804D0/6189334E" Ref="J?"  Part="1" 
AR Path="/6188050F/6189334E" Ref="J1201"  Part="1" 
AR Path="/6371587E/6189334E" Ref="J1201"  Part="1" 
F 0 "J1201" H 3418 3275 50  0000 C CNN
F 1 "strip2_RGBW" H 3418 3366 50  0000 C CNN
F 2 "RGBW-Bar:RGBW-wire-solder-pads-R" H 3500 3700 50  0001 C CNN
F 3 "~" H 3500 3700 50  0001 C CNN
	1    3500 3700
	-1   0    0    1   
$EndComp
Wire Wire Line
	3700 3700 4200 3700
Text Label 5000 3500 2    50   ~ 0
strip2_w_out
Text Label 5000 3600 2    50   ~ 0
strip2_b_out
Text Label 5000 3800 2    50   ~ 0
strip2_r_out
Text Label 5000 3700 2    50   ~ 0
strip2_g_out
Text Label 5000 3900 2    50   ~ 0
12V+
Wire Wire Line
	5150 3900 5150 4000
Wire Wire Line
	5150 4150 5850 4150
Wire Wire Line
	5850 4150 5850 4000
Connection ~ 5150 3900
Wire Wire Line
	5150 3900 5250 3900
Wire Wire Line
	5850 4000 5750 4000
Wire Wire Line
	5250 4000 5150 4000
Connection ~ 5150 4000
Wire Wire Line
	5150 4000 5150 4150
Text Label 6050 3500 0    50   ~ 0
strip3_w_out
Text Label 6050 3600 0    50   ~ 0
strip3_b_out
Text Label 6050 3800 0    50   ~ 0
strip3_r_out
Text Label 6050 3700 0    50   ~ 0
strip3_g_out
Text Label 6050 3900 0    50   ~ 0
12V+
Wire Wire Line
	5750 3900 5850 3900
Wire Wire Line
	5850 4000 5850 3900
Connection ~ 5850 4000
Connection ~ 5850 3900
Wire Wire Line
	5850 3900 6600 3900
$Comp
L Mechanical:MountingHole H1204
U 1 1 6189C762
P 5500 3000
F 0 "H1204" H 5400 3250 50  0000 L CNN
F 1 "MountingHole" H 5250 3150 50  0000 L CNN
F 2 "RGBW-Bar:MountingHole_3.2mm_Wall_0.8mm" H 5500 3000 50  0001 C CNN
F 3 "~" H 5500 3000 50  0001 C CNN
	1    5500 3000
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x06_Odd_Even J?
U 1 1 618944C3
P 5450 3800
AR Path="/6187FE9B/618944C3" Ref="J?"  Part="1" 
AR Path="/6188050F/618944C3" Ref="J1202"  Part="1" 
AR Path="/6371587E/618944C3" Ref="J1202"  Part="1" 
F 0 "J1202" H 5500 3400 50  0000 C CNN
F 1 "Conn_02x06_Odd_Even" H 5500 3250 50  0000 C CNN
F 2 "Connector_PinHeader_2.00mm:PinHeader_2x06_P2.00mm_Vertical" H 5450 3800 50  0001 C CNN
F 3 "~" H 5450 3800 50  0001 C CNN
	1    5450 3800
	1    0    0    1   
$EndComp
$Comp
L RGBW-Bar:Conn_RGB J?
U 1 1 618A2D3B
P 3500 4850
AR Path="/618804D0/618A2D3B" Ref="J?"  Part="1" 
AR Path="/6188050F/618A2D3B" Ref="J1204"  Part="1" 
AR Path="/6371587E/618A2D3B" Ref="J1204"  Part="1" 
F 0 "J1204" H 3418 4425 50  0000 C CNN
F 1 "Strip2_BRG" H 3418 4516 50  0000 C CNN
F 2 "RGBW-Bar:BRG-wire-solder-pads-R" H 3500 4850 50  0001 C CNN
F 3 "~" H 3500 4850 50  0001 C CNN
	1    3500 4850
	-1   0    0    1   
$EndComp
Wire Wire Line
	3700 3900 4400 3900
Wire Wire Line
	3700 3800 4300 3800
Wire Wire Line
	4100 4650 3700 4650
Wire Wire Line
	4200 4750 3700 4750
Connection ~ 4300 3800
Wire Wire Line
	4300 4850 3700 4850
Connection ~ 4400 3900
Wire Wire Line
	4400 4950 3700 4950
Wire Wire Line
	4400 3900 5150 3900
Wire Wire Line
	4300 3800 5250 3800
Wire Wire Line
	4300 3800 4300 4850
Wire Wire Line
	4400 3900 4400 4950
Wire Wire Line
	3700 3600 4100 3600
Wire Wire Line
	3700 3500 5250 3500
Wire Wire Line
	4200 3700 4200 4750
Connection ~ 4200 3700
Wire Wire Line
	4200 3700 5250 3700
Wire Wire Line
	4100 3600 4100 4650
Connection ~ 4100 3600
Wire Wire Line
	4100 3600 5250 3600
$Comp
L RGBW-Bar:Conn_RGB J?
U 1 1 618AC9EE
P 7500 4850
AR Path="/618804D0/618AC9EE" Ref="J?"  Part="1" 
AR Path="/6188050F/618AC9EE" Ref="J1205"  Part="1" 
AR Path="/6371587E/618AC9EE" Ref="J1205"  Part="1" 
F 0 "J1205" H 7400 4450 50  0000 L CNN
F 1 "Strip3_BRG" H 7300 4550 50  0000 L CNN
F 2 "RGBW-Bar:BRG-wire-solder-pads-L" H 7500 4850 50  0001 C CNN
F 3 "~" H 7500 4850 50  0001 C CNN
	1    7500 4850
	1    0    0    1   
$EndComp
Wire Wire Line
	6900 4650 7300 4650
Wire Wire Line
	6800 4750 7300 4750
Wire Wire Line
	6700 4850 7300 4850
Wire Wire Line
	6600 4950 7300 4950
Wire Wire Line
	6700 3800 6700 4850
Wire Wire Line
	6600 3900 6600 4950
Wire Wire Line
	6800 3700 6800 4750
Wire Wire Line
	6900 3600 6900 4650
Connection ~ 6900 3600
Wire Wire Line
	6900 3600 7300 3600
Connection ~ 6800 3700
Wire Wire Line
	6800 3700 7300 3700
Connection ~ 6700 3800
Wire Wire Line
	6700 3800 7300 3800
Connection ~ 6600 3900
Wire Wire Line
	6600 3900 7300 3900
Wire Wire Line
	5750 3500 7300 3500
Wire Wire Line
	5750 3600 6900 3600
Wire Wire Line
	5750 3700 6800 3700
Wire Wire Line
	5750 3800 6700 3800
$EndSCHEMATC
