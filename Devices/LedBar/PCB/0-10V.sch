EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 13
Title "LedBar - MainBoard"
Date "2021-09-27"
Rev "0.1"
Comp "Roel Drost"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 4550 3900 0    50   Input ~ 0
a_in
$Comp
L Device:R R601
U 1 1 608C7DAC
P 6150 3750
F 0 "R601" H 6220 3796 50  0000 L CNN
F 1 "1k" H 6220 3705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 6080 3750 50  0001 C CNN
F 3 "~" H 6150 3750 50  0001 C CNN
	1    6150 3750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R602
U 1 1 608C8308
P 6150 4250
F 0 "R602" H 6220 4296 50  0000 L CNN
F 1 "10k" H 6220 4205 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 6080 4250 50  0001 C CNN
F 3 "~" H 6150 4250 50  0001 C CNN
	1    6150 4250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R603
U 1 1 608C8747
P 6150 4750
F 0 "R603" H 6220 4796 50  0000 L CNN
F 1 "10k" H 6220 4705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 6080 4750 50  0001 C CNN
F 3 "~" H 6150 4750 50  0001 C CNN
	1    6150 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 4100 5000 4100
Wire Wire Line
	5000 4100 5000 4500
Wire Wire Line
	5000 4500 6150 4500
Wire Wire Line
	6150 4500 6150 4400
Wire Wire Line
	6150 4600 6150 4500
Connection ~ 6150 4500
Wire Wire Line
	5700 4000 6150 4000
Wire Wire Line
	6150 4000 6150 3900
Wire Wire Line
	6150 4100 6150 4000
Connection ~ 6150 4000
$Comp
L power:GND #PWR0602
U 1 1 608C937B
P 6150 5000
F 0 "#PWR0602" H 6150 4750 50  0001 C CNN
F 1 "GND" H 6155 4827 50  0000 C CNN
F 2 "" H 6150 5000 50  0001 C CNN
F 3 "" H 6150 5000 50  0001 C CNN
	1    6150 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 5000 6150 4900
Wire Wire Line
	6150 3500 6150 3600
$Comp
L Device:C C601
U 1 1 608CAF7E
P 6650 4250
F 0 "C601" H 6765 4296 50  0000 L CNN
F 1 "0.1uF" H 6765 4205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 6688 4100 50  0001 C CNN
F 3 "~" H 6650 4250 50  0001 C CNN
	1    6650 4250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0603
U 1 1 608CB4E5
P 6650 4500
F 0 "#PWR0603" H 6650 4250 50  0001 C CNN
F 1 "GND" H 6655 4327 50  0000 C CNN
F 2 "" H 6650 4500 50  0001 C CNN
F 3 "" H 6650 4500 50  0001 C CNN
	1    6650 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 4500 6650 4400
Wire Wire Line
	6150 4000 6650 4000
Wire Wire Line
	6650 4000 6650 4100
$Comp
L Connector:TestPoint TP601
U 1 1 608CBD82
P 6650 3900
F 0 "TP601" H 6708 4018 50  0000 L CNN
F 1 "a_out" H 6708 3927 50  0000 L CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 6850 3900 50  0001 C CNN
F 3 "~" H 6850 3900 50  0001 C CNN
	1    6650 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 3900 6650 4000
Connection ~ 6650 4000
$Comp
L Connector_Generic:Conn_01x02 J601
U 1 1 608CCE3C
P 7800 4100
F 0 "J601" H 7880 4092 50  0000 L CNN
F 1 "0-10V(1)" H 7880 4001 50  0000 L CNN
F 2 "AmbientLight:15EDGRC-3.5-2P" H 7800 4100 50  0001 C CNN
F 3 "~" H 7800 4100 50  0001 C CNN
	1    7800 4100
	1    0    0    1   
$EndComp
$Comp
L power:GND #PWR0604
U 1 1 608CDA6C
P 7600 4600
F 0 "#PWR0604" H 7600 4350 50  0001 C CNN
F 1 "GND" H 7605 4427 50  0000 C CNN
F 2 "" H 7600 4600 50  0001 C CNN
F 3 "" H 7600 4600 50  0001 C CNN
	1    7600 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 4600 7600 4100
$Comp
L power:+12VA #PWR0601
U 1 1 608D28CF
P 6150 3500
F 0 "#PWR0601" H 6150 3350 50  0001 C CNN
F 1 "+12VA" H 6165 3673 50  0000 C CNN
F 2 "" H 6150 3500 50  0001 C CNN
F 3 "" H 6150 3500 50  0001 C CNN
	1    6150 3500
	1    0    0    -1  
$EndComp
$Comp
L Comparator:LM393 U601
U 2 1 608FA3D2
P 5400 4000
F 0 "U601" H 5400 4367 50  0000 C CNB
F 1 "LM393" H 5400 4276 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 5400 4000 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm393.pdf" H 5400 4000 50  0001 C CNN
	2    5400 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 4000 7600 4000
Wire Wire Line
	4550 3900 5100 3900
$Comp
L Connector:TestPoint TP602
U 1 1 61F20C57
P 8500 4400
F 0 "TP602" H 8558 4518 50  0000 L CNN
F 1 "gnd" H 8558 4427 50  0000 L CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 8700 4400 50  0001 C CNN
F 3 "~" H 8700 4400 50  0001 C CNN
	1    8500 4400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0605
U 1 1 61F21EA9
P 8500 4600
F 0 "#PWR0605" H 8500 4350 50  0001 C CNN
F 1 "GND" H 8505 4427 50  0000 C CNN
F 2 "" H 8500 4600 50  0001 C CNN
F 3 "" H 8500 4600 50  0001 C CNN
	1    8500 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 4600 8500 4400
$EndSCHEMATC
