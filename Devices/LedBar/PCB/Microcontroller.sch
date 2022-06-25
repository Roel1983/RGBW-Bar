EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 7 13
Title "LedBar - MainBoard"
Date "2021-09-27"
Rev "0.1"
Comp "Roel Drost"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L AmbientLight:ATmega48PV-10AU-arduino U701
U 1 1 608B13AD
P 2500 3000
F 0 "U701" H 3000 4450 50  0000 R CNN
F 1 "ATmega48PV-10AU-arduino" V 1900 3000 50  0000 C CNN
F 2 "Package_QFP:TQFP-32_7x7mm_P0.8mm" H 2450 3000 50  0001 C CIN
F 3 "" H 2500 3000 50  0001 C CNN
	1    2500 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0703
U 1 1 608B3273
P 2500 4600
F 0 "#PWR0703" H 2500 4350 50  0001 C CNN
F 1 "GND" H 2505 4427 50  0000 C CNN
F 2 "" H 2500 4600 50  0001 C CNN
F 3 "" H 2500 4600 50  0001 C CNN
	1    2500 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 4600 2500 4500
$Comp
L power:+5V #PWR0704
U 1 1 608B44A4
P 2550 1000
F 0 "#PWR0704" H 2550 850 50  0001 C CNN
F 1 "+5V" H 2565 1173 50  0000 C CNN
F 2 "" H 2550 1000 50  0001 C CNN
F 3 "" H 2550 1000 50  0001 C CNN
	1    2550 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 1500 2500 1350
Wire Wire Line
	2500 1000 2550 1000
Wire Wire Line
	2600 1500 2600 1350
Wire Wire Line
	2600 1000 2550 1000
Connection ~ 2550 1000
$Comp
L Device:C C703
U 1 1 608B5F95
P 2750 1350
F 0 "C703" V 2498 1350 50  0000 C CNN
F 1 "0.1uF" V 2589 1350 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 2788 1200 50  0001 C CNN
F 3 "~" H 2750 1350 50  0001 C CNN
	1    2750 1350
	0    1    1    0   
$EndComp
Connection ~ 2600 1350
Wire Wire Line
	2600 1350 2600 1000
$Comp
L Device:C C702
U 1 1 608B7B4E
P 2350 1350
F 0 "C702" V 2098 1350 50  0000 C CNN
F 1 "0.1uF" V 2189 1350 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 2388 1200 50  0001 C CNN
F 3 "~" H 2350 1350 50  0001 C CNN
	1    2350 1350
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0707
U 1 1 608B81E4
P 2900 1350
F 0 "#PWR0707" H 2900 1100 50  0001 C CNN
F 1 "GND" V 2905 1222 50  0000 R CNN
F 2 "" H 2900 1350 50  0001 C CNN
F 3 "" H 2900 1350 50  0001 C CNN
	1    2900 1350
	0    -1   -1   0   
$EndComp
Connection ~ 2500 1350
Wire Wire Line
	2500 1350 2500 1000
$Comp
L power:GND #PWR0702
U 1 1 608B8B73
P 2200 1350
F 0 "#PWR0702" H 2200 1100 50  0001 C CNN
F 1 "GND" V 2205 1222 50  0000 R CNN
F 2 "" H 2200 1350 50  0001 C CNN
F 3 "" H 2200 1350 50  0001 C CNN
	1    2200 1350
	0    1    1    0   
$EndComp
$Comp
L Device:C C701
U 1 1 608B959B
P 1650 1800
F 0 "C701" V 1902 1800 50  0000 C CNN
F 1 "0.1uF" V 1811 1800 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 1688 1650 50  0001 C CNN
F 3 "~" H 1650 1800 50  0001 C CNN
	1    1650 1800
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0701
U 1 1 608BB07A
P 1400 1800
F 0 "#PWR0701" H 1400 1550 50  0001 C CNN
F 1 "GND" V 1405 1672 50  0000 R CNN
F 2 "" H 1400 1800 50  0001 C CNN
F 3 "" H 1400 1800 50  0001 C CNN
	1    1400 1800
	0    1    1    0   
$EndComp
Wire Wire Line
	1900 1800 1800 1800
Wire Wire Line
	1500 1800 1400 1800
Text HLabel 4250 5200 2    50   Output ~ 0
a_in
Text Label 3500 3100 0    50   ~ 0
sda
Text Label 3500 3200 0    50   ~ 0
scl
Text Label 3500 3300 0    50   ~ 0
~reset~
Text HLabel 4000 3500 2    50   Input ~ 0
rxd
Text HLabel 4000 3600 2    50   Output ~ 0
txd
Text Label 3500 1800 0    50   ~ 0
addr4
Text Label 3500 1900 0    50   ~ 0
addr5
Text Label 3500 2000 0    50   ~ 0
led4
Text Label 3500 2100 0    50   ~ 0
led3_mosi
Text Label 3500 2200 0    50   ~ 0
led2_miso
Text Label 3500 2300 0    50   ~ 0
led1_sck
Text Label 3500 2700 0    50   ~ 0
~button~
Text Label 3500 2800 0    50   ~ 0
debug1
Text Label 3500 2900 0    50   ~ 0
debug2
Text HLabel 4000 3000 2    50   Output ~ 0
tx_en
Text HLabel 6850 5250 2    50   Output ~ 0
~pca_oe~
Text Label 3500 3900 0    50   ~ 0
addr1
Text Label 3500 4100 0    50   ~ 0
addr2
Text Label 3500 4200 0    50   ~ 0
addr3
Wire Wire Line
	3100 2400 4750 2400
NoConn ~ 1900 2000
NoConn ~ 1900 2100
$Comp
L Connector:AVR-ISP-6 J701
U 1 1 608D8A6D
P 2450 6050
F 0 "J701" H 2120 6146 50  0000 R CNN
F 1 "AVR-ISP-6" H 2120 6055 50  0000 R CNN
F 2 "AmbientLight:ISP_P1.27mm_single_row" V 2200 6100 50  0001 C CNN
F 3 " ~" H 1175 5500 50  0001 C CNN
	1    2450 6050
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0706
U 1 1 608DE2B0
P 2550 6450
F 0 "#PWR0706" H 2550 6200 50  0001 C CNN
F 1 "GND" H 2555 6277 50  0000 C CNN
F 2 "" H 2550 6450 50  0001 C CNN
F 3 "" H 2550 6450 50  0001 C CNN
	1    2550 6450
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0705
U 1 1 608DE66D
P 2550 5550
F 0 "#PWR0705" H 2550 5400 50  0001 C CNN
F 1 "+5V" H 2565 5723 50  0000 C CNN
F 2 "" H 2550 5550 50  0001 C CNN
F 3 "" H 2550 5550 50  0001 C CNN
	1    2550 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 2000 7000 2000
Wire Wire Line
	6500 2100 7500 2100
Text HLabel 8000 2000 2    50   Output ~ 0
scl
Text HLabel 8000 2100 2    50   BiDi ~ 0
sda
Text Label 6550 2000 0    50   ~ 0
scl
Text Label 6550 2100 0    50   ~ 0
sda
$Comp
L Device:R R704
U 1 1 608F32A6
P 7000 1750
F 0 "R704" H 7070 1796 50  0000 L CNN
F 1 "4k7" H 7070 1705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 6930 1750 50  0001 C CNN
F 3 "~" H 7000 1750 50  0001 C CNN
	1    7000 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R706
U 1 1 608F3507
P 7500 1750
F 0 "R706" H 7570 1796 50  0000 L CNN
F 1 "4k7" H 7570 1705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 7430 1750 50  0001 C CNN
F 3 "~" H 7500 1750 50  0001 C CNN
	1    7500 1750
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0715
U 1 1 608F389F
P 7000 1500
F 0 "#PWR0715" H 7000 1350 50  0001 C CNN
F 1 "+5V" H 7015 1673 50  0000 C CNN
F 2 "" H 7000 1500 50  0001 C CNN
F 3 "" H 7000 1500 50  0001 C CNN
	1    7000 1500
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0718
U 1 1 608F3FBD
P 7500 1500
F 0 "#PWR0718" H 7500 1350 50  0001 C CNN
F 1 "+5V" H 7515 1673 50  0000 C CNN
F 2 "" H 7500 1500 50  0001 C CNN
F 3 "" H 7500 1500 50  0001 C CNN
	1    7500 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 1500 7000 1600
Wire Wire Line
	7000 1900 7000 2000
Connection ~ 7000 2000
Wire Wire Line
	7000 2000 8000 2000
Wire Wire Line
	7500 1900 7500 2100
Connection ~ 7500 2100
Wire Wire Line
	7500 2100 8000 2100
Wire Wire Line
	7500 1500 7500 1600
$Comp
L Connector:TestPoint TP709
U 1 1 608F82E1
P 7000 2200
F 0 "TP709" H 6942 2226 50  0000 R CNN
F 1 "scl" H 6942 2317 50  0000 R CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 7200 2200 50  0001 C CNN
F 3 "~" H 7200 2200 50  0001 C CNN
	1    7000 2200
	-1   0    0    1   
$EndComp
$Comp
L Connector:TestPoint TP711
U 1 1 608FA39F
P 7500 2200
F 0 "TP711" H 7442 2226 50  0000 R CNN
F 1 "sda" H 7442 2317 50  0000 R CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 7700 2200 50  0001 C CNN
F 3 "~" H 7700 2200 50  0001 C CNN
	1    7500 2200
	-1   0    0    1   
$EndComp
Wire Wire Line
	7000 2000 7000 2200
Wire Wire Line
	7500 2100 7500 2200
$Comp
L Jumper:SolderJumper_2_Open JP701
U 1 1 608FCEE5
P 9750 3000
F 0 "JP701" H 9750 3113 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 9750 3114 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_TrianglePad1.0x1.5mm" H 9750 3000 50  0001 C CNN
F 3 "~" H 9750 3000 50  0001 C CNN
	1    9750 3000
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP702
U 1 1 608FF9FA
P 9750 3500
F 0 "JP702" H 9750 3613 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 9750 3614 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_TrianglePad1.0x1.5mm" H 9750 3500 50  0001 C CNN
F 3 "~" H 9750 3500 50  0001 C CNN
	1    9750 3500
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP703
U 1 1 608FFDA0
P 9750 4000
F 0 "JP703" H 9750 4113 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 9750 4114 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_TrianglePad1.0x1.5mm" H 9750 4000 50  0001 C CNN
F 3 "~" H 9750 4000 50  0001 C CNN
	1    9750 4000
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP704
U 1 1 609001B4
P 9750 4500
F 0 "JP704" H 9750 4613 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 9750 4614 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_TrianglePad1.0x1.5mm" H 9750 4500 50  0001 C CNN
F 3 "~" H 9750 4500 50  0001 C CNN
	1    9750 4500
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP705
U 1 1 609009B5
P 9750 5000
F 0 "JP705" H 9750 5113 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 9750 5114 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_TrianglePad1.0x1.5mm" H 9750 5000 50  0001 C CNN
F 3 "~" H 9750 5000 50  0001 C CNN
	1    9750 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 3000 9600 3000
Wire Wire Line
	9000 3500 9600 3500
Wire Wire Line
	9000 4000 9600 4000
Wire Wire Line
	9600 4500 9000 4500
Wire Wire Line
	9000 5000 9600 5000
Wire Wire Line
	9900 3000 10500 3000
Wire Wire Line
	10500 5000 9900 5000
Wire Wire Line
	10500 5000 10500 5100
Wire Wire Line
	10500 4500 9900 4500
Wire Wire Line
	9900 4000 10500 4000
Wire Wire Line
	10500 3500 9900 3500
$Comp
L power:GND #PWR0722
U 1 1 6090E71B
P 10500 5100
F 0 "#PWR0722" H 10500 4850 50  0001 C CNN
F 1 "GND" H 10505 4927 50  0000 C CNN
F 2 "" H 10500 5100 50  0001 C CNN
F 3 "" H 10500 5100 50  0001 C CNN
	1    10500 5100
	1    0    0    -1  
$EndComp
Text Label 9050 3000 0    50   ~ 0
addr1
Text Label 9050 3500 0    50   ~ 0
addr2
Text Label 9050 4000 0    50   ~ 0
addr3
Text Label 9050 4500 0    50   ~ 0
addr4
Text Label 9050 5000 0    50   ~ 0
addr5
$Comp
L Device:LED D702
U 1 1 608BAFD5
P 10000 1000
F 0 "D702" H 10000 1100 50  0000 C CNN
F 1 "Green" H 10000 900 50  0000 C CNN
F 2 "LED_THT:LED_D3.0mm" H 10000 1000 50  0001 C CNN
F 3 "~" H 10000 1000 50  0001 C CNN
	1    10000 1000
	-1   0    0    1   
$EndComp
$Comp
L Device:LED D703
U 1 1 608BBEE2
P 10000 1500
F 0 "D703" H 10000 1600 50  0000 C CNN
F 1 "Yellow" H 10000 1400 50  0000 C CNN
F 2 "LED_THT:LED_D3.0mm" H 10000 1500 50  0001 C CNN
F 3 "~" H 10000 1500 50  0001 C CNN
	1    10000 1500
	-1   0    0    1   
$EndComp
$Comp
L Device:LED D704
U 1 1 608BC20E
P 10000 2000
F 0 "D704" H 10000 2100 50  0000 C CNN
F 1 "Orange" H 10000 1900 50  0000 C CNN
F 2 "LED_THT:LED_D3.0mm" H 10000 2000 50  0001 C CNN
F 3 "~" H 10000 2000 50  0001 C CNN
	1    10000 2000
	-1   0    0    1   
$EndComp
$Comp
L Device:LED D705
U 1 1 608BC628
P 10000 2500
F 0 "D705" H 10000 2600 50  0000 C CNN
F 1 "Red" H 10000 2400 50  0000 C CNN
F 2 "LED_THT:LED_D3.0mm" H 10000 2500 50  0001 C CNN
F 3 "~" H 10000 2500 50  0001 C CNN
	1    10000 2500
	-1   0    0    1   
$EndComp
Wire Wire Line
	9650 1000 9850 1000
Wire Wire Line
	9650 1500 9850 1500
Wire Wire Line
	9650 2000 9850 2000
Wire Wire Line
	9650 2500 9850 2500
Wire Wire Line
	10150 1000 10500 1000
Wire Wire Line
	10500 2500 10150 2500
Connection ~ 10500 2500
Wire Wire Line
	10500 2500 10500 2600
Wire Wire Line
	10150 2000 10500 2000
Wire Wire Line
	10150 1500 10500 1500
$Comp
L power:GND #PWR0721
U 1 1 608CBDD7
P 10500 2600
F 0 "#PWR0721" H 10500 2350 50  0001 C CNN
F 1 "GND" H 10505 2427 50  0000 C CNN
F 2 "" H 10500 2600 50  0001 C CNN
F 3 "" H 10500 2600 50  0001 C CNN
	1    10500 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	10500 3000 10500 3500
Connection ~ 10500 5000
Connection ~ 10500 3500
Wire Wire Line
	10500 3500 10500 4000
Connection ~ 10500 4000
Wire Wire Line
	10500 4000 10500 4500
Connection ~ 10500 4500
Wire Wire Line
	10500 4500 10500 5000
Wire Wire Line
	10500 1000 10500 1500
Connection ~ 10500 1500
Wire Wire Line
	10500 1500 10500 2000
Connection ~ 10500 2000
Wire Wire Line
	10500 2000 10500 2500
Text Label 8800 2500 0    50   ~ 0
led4
$Comp
L Device:R R705
U 1 1 60905DC6
P 7000 3250
F 0 "R705" H 7070 3296 50  0000 L CNN
F 1 "10k" H 7070 3205 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 6930 3250 50  0001 C CNN
F 3 "~" H 7000 3250 50  0001 C CNN
	1    7000 3250
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW702
U 1 1 60907903
P 7000 3750
F 0 "SW702" V 7046 3702 50  0000 R CNN
F 1 "reset" V 6955 3702 50  0000 R CNN
F 2 "Button_Switch_SMD:SW_SPST_CK_RS282G05A3" H 7000 3950 50  0001 C CNN
F 3 "~" H 7000 3950 50  0001 C CNN
	1    7000 3750
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0716
U 1 1 60908C24
P 7000 3000
F 0 "#PWR0716" H 7000 2850 50  0001 C CNN
F 1 "+5V" H 7015 3173 50  0000 C CNN
F 2 "" H 7000 3000 50  0001 C CNN
F 3 "" H 7000 3000 50  0001 C CNN
	1    7000 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0717
U 1 1 609091E4
P 7000 4000
F 0 "#PWR0717" H 7000 3750 50  0001 C CNN
F 1 "GND" H 7005 3827 50  0000 C CNN
F 2 "" H 7000 4000 50  0001 C CNN
F 3 "" H 7000 4000 50  0001 C CNN
	1    7000 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 3950 7000 4000
Wire Wire Line
	7000 3550 7000 3500
Wire Wire Line
	7000 3100 7000 3000
Wire Wire Line
	7100 3500 7000 3500
Text Label 6550 3500 0    50   ~ 0
~reset~
$Comp
L Connector:TestPoint TP710
U 1 1 60912AED
P 7100 3500
F 0 "TP710" V 7048 3688 50  0000 L CNN
F 1 "~reset~" V 7146 3688 50  0000 L CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 7300 3500 50  0001 C CNN
F 3 "~" H 7300 3500 50  0001 C CNN
	1    7100 3500
	0    1    1    0   
$EndComp
Wire Wire Line
	3850 6600 4600 6600
Text Label 3900 6600 0    50   ~ 0
~button~
$Comp
L Connector:TestPoint TP706
U 1 1 6093A750
P 4600 6500
F 0 "TP706" H 4542 6526 50  0000 R CNN
F 1 "~button~" H 4542 6617 50  0000 R CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 4800 6500 50  0001 C CNN
F 3 "~" H 4800 6500 50  0001 C CNN
	1    4600 6500
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 6500 4600 6600
Connection ~ 4600 6600
Text Label 1600 6150 0    50   ~ 0
~reset~
Wire Wire Line
	1550 5850 2050 5850
Wire Wire Line
	1550 5950 2050 5950
Wire Wire Line
	1550 6050 2050 6050
Wire Wire Line
	1550 6150 2050 6150
Wire Wire Line
	3100 1800 4000 1800
Wire Wire Line
	3100 1900 4000 1900
Wire Wire Line
	3100 2000 4000 2000
Wire Wire Line
	3100 2100 4000 2100
Wire Wire Line
	3100 2200 4000 2200
Wire Wire Line
	3100 2300 4000 2300
Wire Wire Line
	3100 2700 4000 2700
Wire Wire Line
	3100 3000 4000 3000
Wire Wire Line
	3100 3100 4000 3100
Wire Wire Line
	3100 3200 4000 3200
Wire Wire Line
	3100 3300 4000 3300
Wire Wire Line
	3100 3500 4000 3500
Wire Wire Line
	3100 3600 4000 3600
Wire Wire Line
	3100 3800 4000 3800
Wire Wire Line
	3100 3900 4000 3900
Wire Wire Line
	3100 4200 4000 4200
$Comp
L Connector:TestPoint TP704
U 1 1 609CDE03
P 4350 2800
F 0 "TP704" V 4304 2988 50  0000 L CNN
F 1 "dbg1" V 4395 2988 50  0000 L CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 4550 2800 50  0001 C CNN
F 3 "~" H 4550 2800 50  0001 C CNN
	1    4350 2800
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP705
U 1 1 609D0394
P 4350 3100
F 0 "TP705" V 4304 3288 50  0000 L CNN
F 1 "dbg2" V 4395 3288 50  0000 L CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 4550 3100 50  0001 C CNN
F 3 "~" H 4550 3100 50  0001 C CNN
	1    4350 3100
	0    1    1    0   
$EndComp
Wire Wire Line
	3100 2800 4350 2800
Wire Wire Line
	4350 3100 4350 2900
Wire Wire Line
	4350 2900 3100 2900
Wire Wire Line
	4750 2400 4750 2300
Wire Wire Line
	3100 2500 4750 2500
Wire Wire Line
	4750 2500 4750 2600
Wire Wire Line
	5300 2450 5300 2600
Connection ~ 5300 2450
$Comp
L power:GND #PWR0712
U 1 1 608D6E10
P 5300 2450
F 0 "#PWR0712" H 5300 2200 50  0001 C CNN
F 1 "GND" V 5305 2322 50  0000 R CNN
F 2 "" H 5300 2450 50  0001 C CNN
F 3 "" H 5300 2450 50  0001 C CNN
	1    5300 2450
	0    -1   -1   0   
$EndComp
Connection ~ 5000 2600
Wire Wire Line
	4750 2600 5000 2600
Connection ~ 5000 2300
Wire Wire Line
	4750 2300 5000 2300
Wire Wire Line
	5300 2300 5300 2450
$Comp
L Device:C C706
U 1 1 608D4257
P 5150 2600
F 0 "C706" V 5400 2600 50  0000 C CNN
F 1 "22pF" V 5300 2600 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5188 2450 50  0001 C CNN
F 3 "~" H 5150 2600 50  0001 C CNN
	1    5150 2600
	0    1    1    0   
$EndComp
$Comp
L Device:C C705
U 1 1 608D3EFB
P 5150 2300
F 0 "C705" V 4898 2300 50  0000 C CNN
F 1 "22pF" V 4989 2300 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5188 2150 50  0001 C CNN
F 3 "~" H 5150 2300 50  0001 C CNN
	1    5150 2300
	0    1    1    0   
$EndComp
$Comp
L Device:Crystal Y701
U 1 1 608D345D
P 5000 2450
F 0 "Y701" H 5050 2600 50  0000 R CNN
F 1 "14.7456Mhz" V 5200 2400 50  0000 L CNN
F 2 "Crystal:Crystal_HC49-U_Vertical" H 5000 2450 50  0001 C CNN
F 3 "~" H 5000 2450 50  0001 C CNN
	1    5000 2450
	0    -1   -1   0   
$EndComp
Text Label 8800 1000 0    50   ~ 0
led1_sck
Wire Wire Line
	8750 1000 9350 1000
Wire Wire Line
	8750 1500 9350 1500
Wire Wire Line
	8750 2000 9350 2000
Wire Wire Line
	8750 2500 9350 2500
Text HLabel 6850 5750 2    50   Input ~ 0
~brown_out~
$Comp
L Device:R R702
U 1 1 60945A82
P 6600 5500
F 0 "R702" H 6550 5450 50  0000 R CNN
F 1 "10k" H 6550 5550 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 6530 5500 50  0001 C CNN
F 3 "~" H 6600 5500 50  0001 C CNN
	1    6600 5500
	-1   0    0    1   
$EndComp
Text Label 3500 3700 0    50   ~ 0
~pca_oe~
Wire Wire Line
	3100 3700 4000 3700
Text Label 5900 5250 0    50   ~ 0
~pca_oe~
Text Label 5900 5750 0    50   ~ 0
~brown_out~
Text Label 3500 3800 0    50   ~ 0
~brown_out~
Wire Wire Line
	3100 4100 4000 4100
Wire Wire Line
	5850 5750 6600 5750
Wire Wire Line
	5850 5250 6600 5250
Wire Wire Line
	6600 5250 6600 5350
Connection ~ 6600 5250
Wire Wire Line
	6600 5250 6850 5250
Wire Wire Line
	6600 5650 6600 5750
Connection ~ 6600 5750
Wire Wire Line
	6600 5750 6850 5750
Connection ~ 7000 3500
Wire Wire Line
	7000 3500 7000 3400
Wire Wire Line
	7000 3500 6500 3500
$Comp
L power:GND #PWR0711
U 1 1 60E286D3
P 4750 5200
F 0 "#PWR0711" H 4750 4950 50  0001 C CNN
F 1 "GND" H 4755 5027 50  0000 C CNN
F 2 "" H 4750 5200 50  0001 C CNN
F 3 "" H 4750 5200 50  0001 C CNN
	1    4750 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 5050 4750 5200
$Comp
L Connector:TestPoint TP707
U 1 1 60E27489
P 4750 5050
F 0 "TP707" H 4692 5076 50  0000 R CNN
F 1 "gnd" H 4692 5167 50  0000 R CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 4950 5050 50  0001 C CNN
F 3 "~" H 4950 5050 50  0001 C CNN
	1    4750 5050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0719
U 1 1 60E6D7A2
P 8000 3600
F 0 "#PWR0719" H 8000 3350 50  0001 C CNN
F 1 "GND" H 8005 3427 50  0000 C CNN
F 2 "" H 8000 3600 50  0001 C CNN
F 3 "" H 8000 3600 50  0001 C CNN
	1    8000 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 3450 8000 3600
$Comp
L Connector:TestPoint TP712
U 1 1 60E6D7A9
P 8000 3450
F 0 "TP712" H 7942 3476 50  0000 R CNN
F 1 "gnd" H 7942 3567 50  0000 R CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 8200 3450 50  0001 C CNN
F 3 "~" H 8200 3450 50  0001 C CNN
	1    8000 3450
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW701
U 1 1 61737013
P 4600 6950
F 0 "SW701" V 4646 6902 50  0000 R CNN
F 1 "button" V 4555 6902 50  0000 R CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm_H4.3mm" H 4600 7150 50  0001 C CNN
F 3 "~" H 4600 7150 50  0001 C CNN
	1    4600 6950
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0710
U 1 1 61737019
P 4600 7200
F 0 "#PWR0710" H 4600 6950 50  0001 C CNN
F 1 "GND" H 4605 7027 50  0000 C CNN
F 2 "" H 4600 7200 50  0001 C CNN
F 3 "" H 4600 7200 50  0001 C CNN
	1    4600 7200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 7150 4600 7200
Wire Wire Line
	4600 6600 4600 6750
Wire Wire Line
	6600 6650 6600 6850
Wire Wire Line
	6600 6150 6600 6350
Wire Wire Line
	6600 5750 6600 5850
$Comp
L Device:LED D?
U 1 1 619BE9CD
P 6600 6500
AR Path="/608C0E66/619BE9CD" Ref="D?"  Part="1" 
AR Path="/6094F41A/619BE9CD" Ref="D?"  Part="1" 
AR Path="/608B1159/619BE9CD" Ref="D?"  Part="1" 
AR Path="/617A8CB5/608B1159/619BE9CD" Ref="D701"  Part="1" 
F 0 "D701" V 6639 6382 50  0000 R CNN
F 1 "Blue" V 6548 6382 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 6600 6500 50  0001 C CNN
F 3 "~" H 6600 6500 50  0001 C CNN
	1    6600 6500
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R?
U 1 1 619BE9D3
P 6600 6000
AR Path="/608C0E66/619BE9D3" Ref="R?"  Part="1" 
AR Path="/6094F41A/619BE9D3" Ref="R?"  Part="1" 
AR Path="/608B1159/619BE9D3" Ref="R?"  Part="1" 
AR Path="/617A8CB5/608B1159/619BE9D3" Ref="R703"  Part="1" 
F 0 "R703" H 6670 6046 50  0000 L CNN
F 1 "10k" H 6670 5955 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 6530 6000 50  0001 C CNN
F 3 "~" H 6600 6000 50  0001 C CNN
	1    6600 6000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0714
U 1 1 619C9B0C
P 6600 6850
F 0 "#PWR0714" H 6600 6600 50  0001 C CNN
F 1 "GND" H 6605 6677 50  0000 C CNN
F 2 "" H 6600 6850 50  0001 C CNN
F 3 "" H 6600 6850 50  0001 C CNN
	1    6600 6850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 619D14C8
P 3750 5200
AR Path="/608C0E66/619D14C8" Ref="R?"  Part="1" 
AR Path="/608B1159/619D14C8" Ref="R?"  Part="1" 
AR Path="/617A8CB5/608B1159/619D14C8" Ref="R701"  Part="1" 
F 0 "R701" V 3543 5200 50  0000 C CNN
F 1 "100k" V 3634 5200 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 3680 5200 50  0001 C CNN
F 3 "~" H 3750 5200 50  0001 C CNN
	1    3750 5200
	0    1    1    0   
$EndComp
Wire Wire Line
	4000 5200 4250 5200
$Comp
L Device:R R707
U 1 1 61C2A133
P 9500 1000
F 0 "R707" V 9400 950 50  0000 L CNN
F 1 "10k" V 9500 950 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 9430 1000 50  0001 C CNN
F 3 "~" H 9500 1000 50  0001 C CNN
	1    9500 1000
	0    1    1    0   
$EndComp
$Comp
L Device:R R708
U 1 1 61C3800A
P 9500 1500
F 0 "R708" V 9400 1450 50  0000 L CNN
F 1 "10k" V 9500 1450 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 9430 1500 50  0001 C CNN
F 3 "~" H 9500 1500 50  0001 C CNN
	1    9500 1500
	0    1    1    0   
$EndComp
$Comp
L Device:R R709
U 1 1 61C385F6
P 9500 2000
F 0 "R709" V 9400 1950 50  0000 L CNN
F 1 "10k" V 9500 1950 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 9430 2000 50  0001 C CNN
F 3 "~" H 9500 2000 50  0001 C CNN
	1    9500 2000
	0    1    1    0   
$EndComp
$Comp
L Device:R R710
U 1 1 61C38A9A
P 9500 2500
F 0 "R710" V 9400 2450 50  0000 L CNN
F 1 "10k" V 9500 2450 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 9430 2500 50  0001 C CNN
F 3 "~" H 9500 2500 50  0001 C CNN
	1    9500 2500
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP?
U 1 1 61DFC26D
P 4000 5050
AR Path="/608C0E66/61DFC26D" Ref="TP?"  Part="1" 
AR Path="/608B1159/61DFC26D" Ref="TP?"  Part="1" 
AR Path="/617A8CB5/608B1159/61DFC26D" Ref="TP703"  Part="1" 
F 0 "TP703" H 4058 5168 50  0000 L CNN
F 1 "a_in" H 4058 5077 50  0000 L CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 4200 5050 50  0001 C CNN
F 3 "~" H 4200 5050 50  0001 C CNN
	1    4000 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 5750 4000 5550
$Comp
L power:GND #PWR?
U 1 1 61DFC274
P 4000 5750
AR Path="/608C0E66/61DFC274" Ref="#PWR?"  Part="1" 
AR Path="/608B1159/61DFC274" Ref="#PWR?"  Part="1" 
AR Path="/617A8CB5/608B1159/61DFC274" Ref="#PWR0709"  Part="1" 
F 0 "#PWR0709" H 4000 5500 50  0001 C CNN
F 1 "GND" H 4005 5577 50  0000 C CNN
F 2 "" H 4000 5750 50  0001 C CNN
F 3 "" H 4000 5750 50  0001 C CNN
	1    4000 5750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 61DFC27A
P 4000 5400
AR Path="/608C0E66/61DFC27A" Ref="C?"  Part="1" 
AR Path="/608B1159/61DFC27A" Ref="C?"  Part="1" 
AR Path="/617A8CB5/608B1159/61DFC27A" Ref="C704"  Part="1" 
F 0 "C704" H 4115 5446 50  0000 L CNN
F 1 "1uF" H 4115 5355 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 4038 5250 50  0001 C CNN
F 3 "~" H 4000 5400 50  0001 C CNN
	1    4000 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 4000 4000 4000
Wire Wire Line
	3500 5050 3500 5200
Text Label 3500 4000 0    50   ~ 0
pwm
Text Label 3300 5200 0    50   ~ 0
pwm
Wire Wire Line
	3500 5200 3300 5200
$Comp
L Connector:TestPoint TP?
U 1 1 619D14CE
P 3500 5050
AR Path="/608C0E66/619D14CE" Ref="TP?"  Part="1" 
AR Path="/608B1159/619D14CE" Ref="TP?"  Part="1" 
AR Path="/617A8CB5/608B1159/619D14CE" Ref="TP702"  Part="1" 
F 0 "TP702" H 3558 5168 50  0000 L CNN
F 1 "pwm" H 3558 5077 50  0000 L CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 3700 5050 50  0001 C CNN
F 3 "~" H 3700 5050 50  0001 C CNN
	1    3500 5050
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4000 5050 4000 5200
Connection ~ 4000 5200
Wire Wire Line
	4000 5200 4000 5250
Wire Wire Line
	3900 5200 4000 5200
Wire Wire Line
	3600 5200 3500 5200
Connection ~ 3500 5200
$Comp
L Switch:SW_DIP_x05 SW703
U 1 1 61A4841D
P 9800 5900
F 0 "SW703" H 9800 5433 50  0000 C CNN
F 1 "SW_DIP_x05" H 9800 5524 50  0000 C CNN
F 2 "Button_Switch_THT:SW_DIP_SPSTx05_Slide_6.7x14.26mm_W7.62mm_P2.54mm_LowProfile" H 9800 5900 50  0001 C CNN
F 3 "~" H 9800 5900 50  0001 C CNN
	1    9800 5900
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0720
U 1 1 61A4E966
P 10450 6300
F 0 "#PWR0720" H 10450 6050 50  0001 C CNN
F 1 "GND" H 10455 6127 50  0000 C CNN
F 2 "" H 10450 6300 50  0001 C CNN
F 3 "" H 10450 6300 50  0001 C CNN
	1    10450 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	10450 5700 10450 5800
Wire Wire Line
	10450 5700 10100 5700
Wire Wire Line
	10450 5800 10100 5800
Connection ~ 10450 5800
Wire Wire Line
	10450 5800 10450 5900
Wire Wire Line
	10450 5900 10100 5900
Connection ~ 10450 5900
Wire Wire Line
	10450 5900 10450 6000
Wire Wire Line
	10450 6000 10100 6000
Connection ~ 10450 6000
Wire Wire Line
	10450 6000 10450 6100
Wire Wire Line
	10450 6100 10100 6100
Connection ~ 10450 6100
Wire Wire Line
	10450 6100 10450 6300
Wire Wire Line
	9500 5700 9000 5700
Wire Wire Line
	9000 5800 9500 5800
Wire Wire Line
	9000 5900 9500 5900
Wire Wire Line
	9000 6000 9500 6000
Wire Wire Line
	9000 6100 9500 6100
Text Label 9050 5700 0    50   ~ 0
addr1
Text Label 9050 5800 0    50   ~ 0
addr2
Text Label 9050 5900 0    50   ~ 0
addr3
Text Label 9050 6000 0    50   ~ 0
addr4
Text Label 9050 6100 0    50   ~ 0
addr5
$Comp
L power:GND #PWR0708
U 1 1 6186C56D
P 3000 5200
F 0 "#PWR0708" H 3000 4950 50  0001 C CNN
F 1 "GND" H 3005 5027 50  0000 C CNN
F 2 "" H 3000 5200 50  0001 C CNN
F 3 "" H 3000 5200 50  0001 C CNN
	1    3000 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 5050 3000 5200
$Comp
L Connector:TestPoint TP701
U 1 1 6186C574
P 3000 5050
F 0 "TP701" H 2942 5076 50  0000 R CNN
F 1 "gnd" H 2942 5167 50  0000 R CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 3200 5050 50  0001 C CNN
F 3 "~" H 3200 5050 50  0001 C CNN
	1    3000 5050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0713
U 1 1 618788F4
P 6200 2150
F 0 "#PWR0713" H 6200 1900 50  0001 C CNN
F 1 "GND" H 6205 1977 50  0000 C CNN
F 2 "" H 6200 2150 50  0001 C CNN
F 3 "" H 6200 2150 50  0001 C CNN
	1    6200 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 2000 6200 2150
$Comp
L Connector:TestPoint TP708
U 1 1 618788FB
P 6200 2000
F 0 "TP708" H 6142 2026 50  0000 R CNN
F 1 "gnd" H 6142 2117 50  0000 R CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 6400 2000 50  0001 C CNN
F 3 "~" H 6400 2000 50  0001 C CNN
	1    6200 2000
	1    0    0    -1  
$EndComp
Text Label 8800 1500 0    50   ~ 0
led2_miso
Text Label 8800 2000 0    50   ~ 0
led3_mosi
Text Label 1600 5850 0    50   ~ 0
led2_miso
Text Label 1600 5950 0    50   ~ 0
led3_mosi
Text Label 1600 6050 0    50   ~ 0
led1_sck
$EndSCHEMATC
