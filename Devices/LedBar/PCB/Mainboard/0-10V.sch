EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 13
Title "LedBar - MainBoard"
Date "2022-06-26"
Rev "1.0"
Comp "Roel Drost"
Comment1 "GNU General Public License v3.0"
Comment2 ""
Comment3 "Converts PWM into 0-10V."
Comment4 "4 channel RGBW LED bar, Arduino compatible with isolated half duplex RS485."
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
P 7500 3750
F 0 "C601" H 7615 3796 50  0000 L CNN
F 1 "0.1uF" H 7615 3705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 7538 3600 50  0001 C CNN
F 3 "~" H 7500 3750 50  0001 C CNN
	1    7500 3750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0603
U 1 1 608CB4E5
P 7500 4000
F 0 "#PWR0603" H 7500 3750 50  0001 C CNN
F 1 "GND" H 7505 3827 50  0000 C CNN
F 2 "" H 7500 4000 50  0001 C CNN
F 3 "" H 7500 4000 50  0001 C CNN
	1    7500 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 4000 7500 3900
Wire Wire Line
	7500 3500 7500 3600
$Comp
L Connector:TestPoint TP601
U 1 1 608CBD82
P 8000 3000
F 0 "TP601" H 8058 3118 50  0000 L CNN
F 1 "a_out" H 8058 3027 50  0000 L CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 8200 3000 50  0001 C CNN
F 3 "~" H 8200 3000 50  0001 C CNN
	1    8000 3000
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J601
U 1 1 608CCE3C
P 8200 3600
F 0 "J601" H 8280 3592 50  0000 L CNN
F 1 "0-10V(1)" H 8280 3501 50  0000 L CNN
F 2 "RGBW-Bar:15EDGRC-3.5-2P" H 8200 3600 50  0001 C CNN
F 3 "~" H 8200 3600 50  0001 C CNN
	1    8200 3600
	1    0    0    1   
$EndComp
$Comp
L power:GND #PWR0604
U 1 1 608CDA6C
P 8000 4100
F 0 "#PWR0604" H 8000 3850 50  0001 C CNN
F 1 "GND" H 8005 3927 50  0000 C CNN
F 2 "" H 8000 4100 50  0001 C CNN
F 3 "" H 8000 4100 50  0001 C CNN
	1    8000 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 4100 8000 3600
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
	4550 3900 5000 3900
$Comp
L Connector:TestPoint TP602
U 1 1 61F20C57
P 8900 3900
F 0 "TP602" H 8958 4018 50  0000 L CNN
F 1 "gnd" H 8958 3927 50  0000 L CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 9100 3900 50  0001 C CNN
F 3 "~" H 9100 3900 50  0001 C CNN
	1    8900 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0605
U 1 1 61F21EA9
P 8900 4100
F 0 "#PWR0605" H 8900 3850 50  0001 C CNN
F 1 "GND" H 8905 3927 50  0000 C CNN
F 2 "" H 8900 4100 50  0001 C CNN
F 3 "" H 8900 4100 50  0001 C CNN
	1    8900 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8900 4100 8900 3900
$Comp
L Jumper:Jumper_3_Open JP601
U 1 1 63879622
P 7000 3500
F 0 "JP601" V 7046 3587 50  0000 L CNN
F 1 "Jumper_3_Open" V 6955 3587 50  0000 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm" H 7000 3500 50  0001 C CNN
F 3 "~" H 7000 3500 50  0001 C CNN
	1    7000 3500
	0    -1   1    0   
$EndComp
Wire Wire Line
	5000 3900 5000 3000
Connection ~ 5000 3900
Wire Wire Line
	5000 3900 5100 3900
Wire Wire Line
	8000 3000 8000 3500
Connection ~ 8000 3500
Wire Wire Line
	5000 3000 7000 3000
Wire Wire Line
	7000 3000 7000 3250
Wire Wire Line
	7000 3750 7000 4000
Wire Wire Line
	7000 4000 6150 4000
Wire Wire Line
	7150 3500 7500 3500
Connection ~ 7500 3500
Wire Wire Line
	7500 3500 8000 3500
$EndSCHEMATC
