EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 13
Title "LedBar - MainBoard"
Date "2021-09-27"
Rev "0.1"
Comp "Roel Drost"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Notes Line
	6000 2250 6000 2850
$Sheet
S 5000 1000 2000 1000
U 617A8CB5
F0 "Mainboard" 157
F1 "Mainboard.sch" 157
$EndSheet
Wire Notes Line
	7100 1500 8500 1500
Wire Notes Line
	4900 1500 3500 1500
Wire Notes Line
	8500 1500 8500 4700
Wire Notes Line
	6000 4250 6000 4750
$Sheet
S 5500 3000 1000 1000
U 6187FE9B
F0 "Perpendicular" 79
F1 "Perpendicular.sch" 79
$EndSheet
$Sheet
S 3000 5000 1000 1000
U 618804D0
F0 "LeftBoard" 79
F1 "LeftBoard.sch" 79
$EndSheet
$Sheet
S 5500 5000 1000 1000
U 6188050F
F0 "CenterBoard" 79
F1 "CenterBoard.sch" 79
$EndSheet
$Sheet
S 8000 5000 1000 1000
U 6188055C
F0 "RightBoard" 79
F1 "RightBoard.sch" 79
$EndSheet
Wire Notes Line
	3500 1500 3500 4750
$Comp
L RGBW-Bar:MouseBit MB101
U 1 1 618FDB69
P 1450 1000
F 0 "MB101" H 1728 1046 50  0000 L CNN
F 1 "MouseBit" H 1728 955 50  0000 L CNN
F 2 "RGBW-Bar:MouseBit" H 1370 1420 50  0001 C CNN
F 3 "" H 1450 940 50  0001 C CNN
	1    1450 1000
	1    0    0    -1  
$EndComp
$Comp
L RGBW-Bar:MouseBit MB102
U 1 1 61901AE5
P 1450 1300
F 0 "MB102" H 1728 1346 50  0000 L CNN
F 1 "MouseBit" H 1728 1255 50  0000 L CNN
F 2 "RGBW-Bar:MouseBit" H 1370 1720 50  0001 C CNN
F 3 "" H 1450 1240 50  0001 C CNN
	1    1450 1300
	1    0    0    -1  
$EndComp
$Comp
L RGBW-Bar:MouseBit MB103
U 1 1 619021A7
P 1450 1600
F 0 "MB103" H 1728 1646 50  0000 L CNN
F 1 "MouseBit" H 1728 1555 50  0000 L CNN
F 2 "RGBW-Bar:MouseBit" H 1370 2020 50  0001 C CNN
F 3 "" H 1450 1540 50  0001 C CNN
	1    1450 1600
	1    0    0    -1  
$EndComp
$Comp
L RGBW-Bar:MouseBit MB104
U 1 1 61907DC7
P 1450 1900
F 0 "MB104" H 1728 1946 50  0000 L CNN
F 1 "MouseBit" H 1728 1855 50  0000 L CNN
F 2 "RGBW-Bar:MouseBit" H 1370 2320 50  0001 C CNN
F 3 "" H 1450 1840 50  0001 C CNN
	1    1450 1900
	1    0    0    -1  
$EndComp
$Comp
L RGBW-Bar:MouseBit MB105
U 1 1 619FF750
P 1450 2200
F 0 "MB105" H 1728 2246 50  0000 L CNN
F 1 "MouseBit" H 1728 2155 50  0000 L CNN
F 2 "RGBW-Bar:MouseBit_modified1" H 1370 2620 50  0001 C CNN
F 3 "" H 1450 2140 50  0001 C CNN
	1    1450 2200
	1    0    0    -1  
$EndComp
$Comp
L RGBW-Bar:MouseBit MB106
U 1 1 619FFB38
P 1450 2500
F 0 "MB106" H 1728 2546 50  0000 L CNN
F 1 "MouseBit" H 1728 2455 50  0000 L CNN
F 2 "RGBW-Bar:MouseBit" H 1370 2920 50  0001 C CNN
F 3 "" H 1450 2440 50  0001 C CNN
	1    1450 2500
	1    0    0    -1  
$EndComp
$EndSCHEMATC
