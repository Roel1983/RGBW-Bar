EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 13
Title ""
Date "2022-11-17"
Rev "2.0"
Comp ""
Comment1 "GNU General Public License v3.0"
Comment2 ""
Comment3 ""
Comment4 "4 channel RGBW LED bar, Arduino compatible with isolated half duplex RS485."
$EndDescr
$Comp
L Connector_Generic:Conn_01x05 J1102
U 1 1 6188E385
P 6500 3250
F 0 "J1102" H 6418 2825 50  0000 C CNN
F 1 "Conn_01x05" H 6418 2916 50  0000 C CNN
F 2 "RGBW-Bar:PinHeader_1x05_P2.00mm_Vertical_no_silk" H 6500 3250 50  0001 C CNN
F 3 "~" H 6500 3250 50  0001 C CNN
	1    6500 3250
	1    0    0    1   
$EndComp
Text Label 5500 3050 0    50   ~ 0
strip1_w_out
Text Label 5500 3150 0    50   ~ 0
strip1_b_out
Text Label 5500 3350 0    50   ~ 0
strip1_r_out
Text Label 5500 3250 0    50   ~ 0
strip1_g_out
Text Label 5500 3450 0    50   ~ 0
12V+
$Comp
L RGBW-Bar:Conn_RGBW J1101
U 1 1 618B5913
P 4550 3250
AR Path="/618804D0/618B5913" Ref="J1101"  Part="1" 
AR Path="/6188050F/618B5913" Ref="J?"  Part="1" 
AR Path="/6371595F/618B5913" Ref="J1101"  Part="1" 
F 0 "J1101" H 4468 2825 50  0000 C CNN
F 1 "strip1_RGBW" H 4468 2916 50  0000 C CNN
F 2 "RGBW-Bar:RGBW-wire-solder-pads-R" H 4550 3250 50  0001 C CNN
F 3 "~" H 4550 3250 50  0001 C CNN
	1    4550 3250
	-1   0    0    1   
$EndComp
Wire Wire Line
	4750 3250 5250 3250
$Comp
L RGBW-Bar:Conn_RGB J1103
U 1 1 618B591A
P 4550 4400
AR Path="/618804D0/618B591A" Ref="J1103"  Part="1" 
AR Path="/6188050F/618B591A" Ref="J?"  Part="1" 
AR Path="/6371595F/618B591A" Ref="J1103"  Part="1" 
F 0 "J1103" H 4468 3975 50  0000 C CNN
F 1 "Strip1_BRG" H 4468 4066 50  0000 C CNN
F 2 "RGBW-Bar:BRG-wire-solder-pads-R" H 4550 4400 50  0001 C CNN
F 3 "~" H 4550 4400 50  0001 C CNN
	1    4550 4400
	-1   0    0    1   
$EndComp
Wire Wire Line
	4750 3450 5450 3450
Wire Wire Line
	4750 3350 5350 3350
Wire Wire Line
	5150 4200 4750 4200
Wire Wire Line
	5250 4300 4750 4300
Connection ~ 5350 3350
Wire Wire Line
	5350 4400 4750 4400
Connection ~ 5450 3450
Wire Wire Line
	5450 4500 4750 4500
Wire Wire Line
	5350 3350 6300 3350
Wire Wire Line
	5350 3350 5350 4400
Wire Wire Line
	5450 3450 5450 4500
Wire Wire Line
	4750 3150 5150 3150
Wire Wire Line
	4750 3050 6300 3050
Wire Wire Line
	5250 3250 5250 4300
Connection ~ 5250 3250
Wire Wire Line
	5250 3250 6300 3250
Wire Wire Line
	5150 3150 5150 4200
Connection ~ 5150 3150
Wire Wire Line
	5150 3150 6300 3150
Wire Wire Line
	5450 3450 6300 3450
$Comp
L Mechanical:MountingHole H?
U 1 1 6189EC18
P 6500 2500
AR Path="/6188050F/6189EC18" Ref="H?"  Part="1" 
AR Path="/618804D0/6189EC18" Ref="H1102"  Part="1" 
AR Path="/6371595F/6189EC18" Ref="H1102"  Part="1" 
F 0 "H1102" H 6450 2750 50  0000 L CNN
F 1 "MountingHole" H 6250 2650 50  0000 L CNN
F 2 "RGBW-Bar:MountingHole_3.2mm_Wall_0.8mm" H 6500 2500 50  0001 C CNN
F 3 "~" H 6500 2500 50  0001 C CNN
	1    6500 2500
	1    0    0    -1  
$EndComp
$EndSCHEMATC
