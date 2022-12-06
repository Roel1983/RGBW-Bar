EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 12 13
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
L RGBW-Bar:Conn_RGBW J?
U 1 1 618BFD61
P 6450 3250
AR Path="/618804D0/618BFD61" Ref="J?"  Part="1" 
AR Path="/6188055C/618BFD61" Ref="J1302"  Part="1" 
AR Path="/6188050F/618BFD61" Ref="J?"  Part="1" 
AR Path="/637158E2/618BFD61" Ref="J1302"  Part="1" 
F 0 "J1302" H 6350 2850 50  0000 L CNN
F 1 "Strip4_RGBW" H 6200 2950 50  0000 L CNN
F 2 "RGBW-Bar:RGBW-wire-solder-pads-R" H 6450 3250 50  0001 C CNN
F 3 "~" H 6450 3250 50  0001 C CNN
	1    6450 3250
	1    0    0    1   
$EndComp
$Comp
L RGBW-Bar:Conn_RGB J?
U 1 1 618BFD6C
P 6450 4400
AR Path="/618804D0/618BFD6C" Ref="J?"  Part="1" 
AR Path="/6188050F/618BFD6C" Ref="J?"  Part="1" 
AR Path="/6188055C/618BFD6C" Ref="J1303"  Part="1" 
AR Path="/637158E2/618BFD6C" Ref="J1303"  Part="1" 
F 0 "J1303" H 6350 4000 50  0000 L CNN
F 1 "Strip4_BRG" H 6250 4100 50  0000 L CNN
F 2 "RGBW-Bar:BRG-wire-solder-pads-R" H 6450 4400 50  0001 C CNN
F 3 "~" H 6450 4400 50  0001 C CNN
	1    6450 4400
	1    0    0    1   
$EndComp
Wire Wire Line
	5850 4200 6250 4200
Wire Wire Line
	5750 4300 6250 4300
Wire Wire Line
	5650 4400 6250 4400
Wire Wire Line
	5550 4500 6250 4500
Wire Wire Line
	5650 3350 5650 4400
Wire Wire Line
	5550 3450 5550 4500
Wire Wire Line
	5750 3250 5750 4300
Wire Wire Line
	5850 3150 5850 4200
Wire Wire Line
	5550 3450 6250 3450
Wire Wire Line
	5650 3350 6250 3350
Wire Wire Line
	5750 3250 6250 3250
Wire Wire Line
	5850 3150 6250 3150
$Comp
L Mechanical:MountingHole H?
U 1 1 6189E531
P 4500 2500
AR Path="/6188050F/6189E531" Ref="H?"  Part="1" 
AR Path="/6188055C/6189E531" Ref="H1301"  Part="1" 
AR Path="/637158E2/6189E531" Ref="H1301"  Part="1" 
F 0 "H1301" H 4450 2750 50  0000 L CNN
F 1 "MountingHole" H 4250 2650 50  0000 L CNN
F 2 "RGBW-Bar:MountingHole_3.2mm_Wall_0.8mm" H 4500 2500 50  0001 C CNN
F 3 "~" H 4500 2500 50  0001 C CNN
	1    4500 2500
	1    0    0    -1  
$EndComp
Text Label 5000 3450 0    50   ~ 0
12V+
Text Label 5000 3250 0    50   ~ 0
strip4_g_out
Text Label 5000 3350 0    50   ~ 0
strip4_r_out
Text Label 5000 3150 0    50   ~ 0
strip4_b_out
Text Label 5000 3050 0    50   ~ 0
strip4_w_out
$Comp
L Connector_Generic:Conn_01x05 J?
U 1 1 61891AC0
P 4500 3250
AR Path="/618804D0/61891AC0" Ref="J?"  Part="1" 
AR Path="/6188055C/61891AC0" Ref="J1301"  Part="1" 
AR Path="/637158E2/61891AC0" Ref="J1301"  Part="1" 
F 0 "J1301" H 4500 2850 50  0000 C CNN
F 1 "Conn_01x05" H 4500 2950 50  0000 C CNN
F 2 "RGBW-Bar:PinHeader_1x05_P2.00mm_Vertical_no_silk" H 4500 3250 50  0001 C CNN
F 3 "~" H 4500 3250 50  0001 C CNN
	1    4500 3250
	-1   0    0    1   
$EndComp
Connection ~ 5550 3450
Wire Wire Line
	4700 3450 5550 3450
Connection ~ 5650 3350
Wire Wire Line
	4700 3350 5650 3350
Connection ~ 5750 3250
Wire Wire Line
	4700 3250 5750 3250
Connection ~ 5850 3150
Wire Wire Line
	4700 3150 5850 3150
Wire Wire Line
	4700 3050 6250 3050
$EndSCHEMATC
