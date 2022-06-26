EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 13
Title "LedBar - MainBoard"
Date "2022-06-26"
Rev "1.0"
Comp "Roel Drost"
Comment1 "GNU General Public License v3.0"
Comment2 ""
Comment3 ""
Comment4 "4 channel RGBW LED bar, Arduino compatible with isolated half duplex RS485."
$EndDescr
$Sheet
S 2000 1500 1500 1000
U 60858D7F
F0 "Power" 78
F1 "Power.sch" 78
F2 "scl" I R 3500 1600 50 
F3 "sda" B R 3500 1700 50 
$EndSheet
Wire Wire Line
	7000 1600 7000 3600
Wire Wire Line
	7000 3600 6500 3600
Wire Wire Line
	7100 1700 7100 3700
Wire Wire Line
	7100 3700 6500 3700
Wire Wire Line
	6500 3900 7300 3900
Connection ~ 7000 1600
Wire Wire Line
	7000 1600 8000 1600
Wire Wire Line
	7100 1700 8000 1700
Connection ~ 7100 1700
Wire Wire Line
	8000 1950 7300 1950
Wire Wire Line
	7300 1950 7300 3900
$Sheet
S 8000 4500 1500 1000
U 608C0E66
F0 "0-10V" 78
F1 "0-10V.sch" 78
F2 "a_in" I L 8000 4650 50 
$EndSheet
Wire Wire Line
	6500 4650 8000 4650
$Sheet
S 2000 4500 1500 1000
U 6094F41A
F0 "Brown-out" 78
F1 "Brown-out.sch" 78
F2 "~Brown_out~" O R 3500 4650 50 
$EndSheet
Wire Wire Line
	3500 3600 5000 3600
Wire Wire Line
	3500 3700 5000 3700
Wire Wire Line
	3500 3900 5000 3900
Wire Wire Line
	3500 4650 5000 4650
$Comp
L Mechanical:MountingHole H204
U 1 1 61B9622B
P 10000 6000
F 0 "H204" H 10100 6046 50  0000 L CNN
F 1 "MountingHole" H 10100 5955 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4" H 10000 6000 50  0001 C CNN
F 3 "~" H 10000 6000 50  0001 C CNN
	1    10000 6000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H202
U 1 1 61B96485
P 1500 6000
F 0 "H202" H 1600 6046 50  0000 L CNN
F 1 "MountingHole" H 1600 5955 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4" H 1500 6000 50  0001 C CNN
F 3 "~" H 1500 6000 50  0001 C CNN
	1    1500 6000
	-1   0    0    -1  
$EndComp
$Sheet
S 8000 3000 1500 1000
U 61792A36
F0 "Rtc" 78
F1 "Rtc.sch" 78
F2 "scl" I L 8000 3600 50 
F3 "sda" B L 8000 3700 50 
$EndSheet
Wire Wire Line
	7000 3600 8000 3600
Connection ~ 7000 3600
Wire Wire Line
	8000 3700 7100 3700
Connection ~ 7100 3700
$Sheet
S 5000 3500 1500 1550
U 608B1159
F0 "Microcontroller" 78
F1 "Microcontroller.sch" 78
F2 "rxd" I L 5000 3600 50 
F3 "txd" O L 5000 3700 50 
F4 "tx_en" O L 5000 3900 50 
F5 "~pca_oe~" O R 6500 3900 50 
F6 "scl" O R 6500 3600 50 
F7 "sda" B R 6500 3700 50 
F8 "~brown_out~" I L 5000 4650 50 
F9 "a_in" O R 6500 4650 50 
$EndSheet
$Sheet
S 8000 1500 1500 1000
U 608B2A01
F0 "Pca" 78
F1 "Pca.sch" 78
F2 "scl" I L 8000 1600 50 
F3 "sda" B L 8000 1700 50 
F4 "~oe~" I L 8000 1950 50 
$EndSheet
$Sheet
S 2000 3000 1500 1000
U 608655BB
F0 "RS485" 78
F1 "RS485.sch" 78
F2 "txd" I R 3500 3700 50 
F3 "rxd" O R 3500 3600 50 
F4 "tx_en" I R 3500 3900 50 
$EndSheet
Wire Wire Line
	3500 1600 7000 1600
Wire Wire Line
	3500 1700 7100 1700
$Comp
L Mechanical:MountingHole H203
U 1 1 617508E9
P 10000 1000
F 0 "H203" H 10100 1046 50  0000 L CNN
F 1 "MountingHole" H 10100 955 50  0000 L CNN
F 2 "RGBW-Bar:MountingHole_4.3mm_M4_modified1" H 10000 1000 50  0001 C CNN
F 3 "~" H 10000 1000 50  0001 C CNN
	1    10000 1000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H201
U 1 1 6174F005
P 1500 1000
F 0 "H201" H 1600 1046 50  0000 L CNN
F 1 "MountingHole" H 1600 955 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4" H 1500 1000 50  0001 C CNN
F 3 "~" H 1500 1000 50  0001 C CNN
	1    1500 1000
	-1   0    0    -1  
$EndComp
$EndSCHEMATC
