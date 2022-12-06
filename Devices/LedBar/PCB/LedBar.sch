EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 13
Title "LedBar - MainBoard"
Date "2022-12-06"
Rev "2.0"
Comp "Roel Drost"
Comment1 "GNU General Public License v3.0"
Comment2 ""
Comment3 ""
Comment4 "4 channel RGBW LED bar, Arduino compatible with isolated half duplex RS485."
$EndDescr
Wire Notes Line
	7100 1500 8500 1500
Wire Notes Line
	4900 1500 3500 1500
Wire Notes Line
	8500 1500 8500 4700
Wire Notes Line
	6000 4250 6000 4750
Wire Notes Line
	3500 1500 3500 4750
Wire Notes Line
	6000 2250 6000 2750
$Sheet
S 5000 1000 2000 1000
U 617A8CB5
F0 "Mainboard" 118
F1 "Mainboard/Mainboard.sch" 79
$EndSheet
$Sheet
S 2500 5000 2000 1000
U 618804D0
F0 "LeftBoard" 118
F1 "Subboards/LeftBoard.sch" 79
$EndSheet
$Sheet
S 5000 5000 2000 1000
U 6188050F
F0 "CenterBoard" 118
F1 "Subboards/CenterBoard.sch" 79
$EndSheet
$Sheet
S 7500 5000 2000 1000
U 6188055C
F0 "RightBoard" 118
F1 "Subboards/RightBoard.sch" 79
$EndSheet
$Sheet
S 5000 3000 2000 1000
U 6187FE9B
F0 "Perpendicular" 118
F1 "Subboards/Perpendicular.sch" 79
$EndSheet
$Comp
L RGBW-Bar:MouseBit MB101
U 1 1 6372AD1D
P 1500 1500
F 0 "MB101" H 1778 1546 50  0000 L CNN
F 1 "MouseBit" H 1778 1455 50  0000 L CNN
F 2 "RGBW-Bar:MouseBit" H 1500 1730 50  0001 C CNN
F 3 "" H 1500 1440 50  0001 C CNN
	1    1500 1500
	1    0    0    -1  
$EndComp
$Comp
L RGBW-Bar:MouseBit MB102
U 1 1 6372B2F8
P 1500 2000
F 0 "MB102" H 1778 2046 50  0000 L CNN
F 1 "MouseBit" H 1778 1955 50  0000 L CNN
F 2 "RGBW-Bar:MouseBit" H 1500 2230 50  0001 C CNN
F 3 "" H 1500 1940 50  0001 C CNN
	1    1500 2000
	1    0    0    -1  
$EndComp
$Comp
L RGBW-Bar:MouseBit MB103
U 1 1 6372BAB7
P 1500 2500
F 0 "MB103" H 1778 2546 50  0000 L CNN
F 1 "MouseBit" H 1778 2455 50  0000 L CNN
F 2 "RGBW-Bar:MouseBit" H 1500 2730 50  0001 C CNN
F 3 "" H 1500 2440 50  0001 C CNN
	1    1500 2500
	1    0    0    -1  
$EndComp
$Comp
L RGBW-Bar:MouseBit MB104
U 1 1 6372BCA3
P 1500 3000
F 0 "MB104" H 1778 3046 50  0000 L CNN
F 1 "MouseBit" H 1778 2955 50  0000 L CNN
F 2 "RGBW-Bar:MouseBit" H 1500 3230 50  0001 C CNN
F 3 "" H 1500 2940 50  0001 C CNN
	1    1500 3000
	1    0    0    -1  
$EndComp
$Comp
L RGBW-Bar:MouseBit MB105
U 1 1 6372BED5
P 1550 3500
F 0 "MB105" H 1828 3546 50  0000 L CNN
F 1 "MouseBit" H 1828 3455 50  0000 L CNN
F 2 "RGBW-Bar:MouseBit_modified1" H 1550 3730 50  0001 C CNN
F 3 "" H 1550 3440 50  0001 C CNN
	1    1550 3500
	1    0    0    -1  
$EndComp
$Comp
L RGBW-Bar:MouseBit MB106
U 1 1 6372C14D
P 1550 4000
F 0 "MB106" H 1828 4046 50  0000 L CNN
F 1 "MouseBit" H 1828 3955 50  0000 L CNN
F 2 "RGBW-Bar:MouseBit" H 1550 4230 50  0001 C CNN
F 3 "" H 1550 3940 50  0001 C CNN
	1    1550 4000
	1    0    0    -1  
$EndComp
$EndSCHEMATC
