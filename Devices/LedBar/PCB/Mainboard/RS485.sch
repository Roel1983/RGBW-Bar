EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 8 13
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
L Interface_UART:ISO3082DW U401
U 1 1 60866215
P 6800 4500
F 0 "U401" H 6800 5250 50  0000 C CNN
F 1 "ISO3082DW" H 6800 5150 50  0000 C CNN
F 2 "Package_SO:SOIC-16W_7.5x10.3mm_P1.27mm" H 6800 5350 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/iso3082.pdf" H 6600 3750 50  0001 C CNN
	1    6800 4500
	-1   0    0    -1  
$EndComp
$Comp
L Device:D_TVS_x2_AAC D401
U 1 1 6086DBB2
P 5100 5000
F 0 "D401" H 5100 5217 50  0000 C CNN
F 1 "PSM712" H 5100 5126 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 4950 5000 50  0001 C CNN
F 3 "http://www.protekdevices.com/xyz/documents/datasheets/psm712.pdf" H 4950 5000 50  0001 C CNN
	1    5100 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 5200 7000 5300
Wire Wire Line
	7000 5300 7100 5300
Wire Wire Line
	7200 5300 7200 5200
Wire Wire Line
	7100 5200 7100 5300
Connection ~ 7100 5300
Wire Wire Line
	7100 5300 7200 5300
$Comp
L power:GND #PWR0408
U 1 1 6086EC52
P 7100 5300
F 0 "#PWR0408" H 7100 5050 50  0001 C CNN
F 1 "GND" H 7105 5127 50  0000 C CNN
F 2 "" H 7100 5300 50  0001 C CNN
F 3 "" H 7100 5300 50  0001 C CNN
	1    7100 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 4700 7500 4700
Wire Wire Line
	7500 4700 7500 4200
Wire Wire Line
	7500 4200 7400 4200
Text HLabel 8600 4400 2    50   Input ~ 0
txd
Text HLabel 8600 4600 2    50   Output ~ 0
rxd
Text HLabel 8600 5000 2    50   Input ~ 0
tx_en
$Comp
L power:+5V #PWR0409
U 1 1 6086FFFF
P 7350 3350
F 0 "#PWR0409" H 7350 3200 50  0001 C CNN
F 1 "+5V" H 7365 3523 50  0000 C CNN
F 2 "" H 7350 3350 50  0001 C CNN
F 3 "" H 7350 3350 50  0001 C CNN
	1    7350 3350
	1    0    0    -1  
$EndComp
$Comp
L Device:C C404
U 1 1 6087070C
P 7600 3650
F 0 "C404" H 7715 3696 50  0000 L CNN
F 1 "0.1uF" H 7715 3605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 7638 3500 50  0001 C CNN
F 3 "~" H 7600 3650 50  0001 C CNN
	1    7600 3650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0412
U 1 1 60870F07
P 7600 3800
F 0 "#PWR0412" H 7600 3550 50  0001 C CNN
F 1 "GND" H 7605 3627 50  0000 C CNN
F 2 "" H 7600 3800 50  0001 C CNN
F 3 "" H 7600 3800 50  0001 C CNN
	1    7600 3800
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP406
U 1 1 608731C2
P 8100 4350
F 0 "TP406" H 8158 4468 50  0000 L CNN
F 1 "txd" H 8158 4377 50  0000 L CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 8300 4350 50  0001 C CNN
F 3 "~" H 8300 4350 50  0001 C CNN
	1    8100 4350
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP407
U 1 1 608755BF
P 8100 4650
F 0 "TP407" H 8042 4676 50  0000 R CNN
F 1 "rxd" H 8042 4767 50  0000 R CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 8300 4650 50  0001 C CNN
F 3 "~" H 8300 4650 50  0001 C CNN
	1    8100 4650
	-1   0    0    1   
$EndComp
$Comp
L Connector:TestPoint TP408
U 1 1 60875DD3
P 8100 5050
F 0 "TP408" H 8042 5076 50  0000 R CNN
F 1 "tx_en" H 8042 5167 50  0000 R CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 8300 5050 50  0001 C CNN
F 3 "~" H 8300 5050 50  0001 C CNN
	1    8100 5050
	-1   0    0    1   
$EndComp
Wire Wire Line
	7500 5000 7500 4700
Wire Wire Line
	8100 5000 8600 5000
Connection ~ 7500 4700
Wire Wire Line
	7500 5000 8100 5000
Connection ~ 8100 5000
Wire Wire Line
	7100 3500 7100 3800
Wire Wire Line
	7100 3500 7350 3500
Wire Wire Line
	7350 3350 7350 3500
Connection ~ 7350 3500
Wire Wire Line
	7350 3500 7600 3500
Wire Wire Line
	8100 5000 8100 5050
Wire Wire Line
	7400 4400 8100 4400
Wire Wire Line
	7400 4600 8100 4600
Wire Wire Line
	8100 4650 8100 4600
Connection ~ 8100 4600
Wire Wire Line
	8100 4600 8600 4600
Wire Wire Line
	8100 4350 8100 4400
Connection ~ 8100 4400
Wire Wire Line
	8100 4400 8600 4400
$Comp
L Device:R R401
U 1 1 60882D64
P 5850 4400
F 0 "R401" V 6057 4400 50  0000 C CNN
F 1 "10R" V 5966 4400 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5780 4400 50  0001 C CNN
F 3 "~" H 5850 4400 50  0001 C CNN
	1    5850 4400
	0    -1   -1   0   
$EndComp
$Comp
L RGBW-Bar:GND_iso #PWR0407
U 1 1 6088C9C5
P 6500 5300
F 0 "#PWR0407" H 6500 5050 50  0001 C CNN
F 1 "GND_iso" H 6505 5127 50  0000 C CNN
F 2 "" H 6500 5300 50  0001 C CNN
F 3 "" H 6500 5300 50  0001 C CNN
	1    6500 5300
	1    0    0    -1  
$EndComp
$Comp
L RGBW-Bar:GND_iso #PWR0401
U 1 1 6088DF33
P 3950 5300
F 0 "#PWR0401" H 3950 5050 50  0001 C CNN
F 1 "GND_iso" H 3955 5127 50  0000 C CNN
F 2 "" H 3950 5300 50  0001 C CNN
F 3 "" H 3950 5300 50  0001 C CNN
	1    3950 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 5200 6400 5300
Wire Wire Line
	6400 5300 6500 5300
Wire Wire Line
	6600 5300 6600 5200
Connection ~ 6500 5300
Wire Wire Line
	6500 5300 6600 5300
Wire Wire Line
	6500 5200 6500 5300
$Comp
L RGBW-Bar:GND_iso #PWR0402
U 1 1 60894182
P 5100 5300
F 0 "#PWR0402" H 5100 5050 50  0001 C CNN
F 1 "GND_iso" H 5105 5127 50  0000 C CNN
F 2 "" H 5100 5300 50  0001 C CNN
F 3 "" H 5100 5300 50  0001 C CNN
	1    5100 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 4400 6200 4400
$Comp
L Connector_Generic:Conn_01x03 J401
U 1 1 60886AC6
P 3650 4600
F 0 "J401" H 3650 4350 50  0000 C CNN
F 1 "RS485" H 3950 4600 50  0000 R CNN
F 2 "RGBW-Bar:15EDGRC-3.5-3P" H 3650 4600 50  0001 C CNN
F 3 "~" H 3650 4600 50  0001 C CNN
	1    3650 4600
	-1   0    0    1   
$EndComp
Wire Wire Line
	5700 4400 4600 4400
Wire Wire Line
	5450 5000 5600 5000
Wire Wire Line
	4750 5000 4600 5000
Wire Wire Line
	4600 5000 4600 4400
Connection ~ 4600 4400
$Comp
L Device:R R402
U 1 1 608A0159
P 5850 4600
F 0 "R402" V 5650 4600 50  0000 C CNN
F 1 "10R" V 5750 4600 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5780 4600 50  0001 C CNN
F 3 "~" H 5850 4600 50  0001 C CNN
	1    5850 4600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5100 5150 5100 5300
$Comp
L RGBW-Bar:B0505S-1W-SIP4 U402
U 1 1 608B32EA
P 6850 2250
F 0 "U402" H 6850 2765 50  0000 C CNN
F 1 "B0505S-1W-SIP4" H 6850 2674 50  0000 C CNN
F 2 "RGBW-Bar:B0505S-1W" H 6600 2250 50  0001 C CNN
F 3 "https://datasheetspdf.com/pdf-file/792761/MORNSUN/B0505S-1W/1" H 6600 2250 50  0001 C CNN
	1    6850 2250
	-1   0    0    -1  
$EndComp
$Comp
L Device:C C403
U 1 1 608B4345
P 7600 2250
F 0 "C403" H 7715 2296 50  0000 L CNN
F 1 "4.7uF" H 7715 2205 50  0000 L CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-3216-18_Kemet-A_Pad1.58x1.35mm_HandSolder" H 7638 2100 50  0001 C CNN
F 3 "~" H 7600 2250 50  0001 C CNN
	1    7600 2250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C402
U 1 1 608B4777
P 6100 2250
F 0 "C402" H 5986 2204 50  0000 R CNN
F 1 "10uF" H 5986 2295 50  0000 R CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-3216-18_Kemet-A_Pad1.58x1.35mm_HandSolder" H 6138 2100 50  0001 C CNN
F 3 "~" H 6100 2250 50  0001 C CNN
	1    6100 2250
	1    0    0    1   
$EndComp
Wire Wire Line
	7400 2050 7600 2050
Wire Wire Line
	7600 2050 7600 2100
$Comp
L power:GND #PWR0411
U 1 1 608BA353
P 7600 2550
F 0 "#PWR0411" H 7600 2300 50  0001 C CNN
F 1 "GND" H 7605 2377 50  0000 C CNN
F 2 "" H 7600 2550 50  0001 C CNN
F 3 "" H 7600 2550 50  0001 C CNN
	1    7600 2550
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0410
U 1 1 608BB791
P 7600 1950
F 0 "#PWR0410" H 7600 1800 50  0001 C CNN
F 1 "+5V" H 7615 2123 50  0000 C CNN
F 2 "" H 7600 1950 50  0001 C CNN
F 3 "" H 7600 1950 50  0001 C CNN
	1    7600 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 1950 7600 2050
Connection ~ 7600 2050
$Comp
L RGBW-Bar:GND_iso #PWR0405
U 1 1 608BCBD7
P 6100 2550
F 0 "#PWR0405" H 6100 2300 50  0001 C CNN
F 1 "GND_iso" H 6105 2377 50  0000 C CNN
F 2 "" H 6100 2550 50  0001 C CNN
F 3 "" H 6100 2550 50  0001 C CNN
	1    6100 2550
	1    0    0    -1  
$EndComp
$Comp
L RGBW-Bar:+5V_iso #PWR0404
U 1 1 608BEF84
P 6100 1950
F 0 "#PWR0404" H 6100 1800 50  0001 C CNN
F 1 "+5V_iso" H 6115 2123 50  0000 C CNN
F 2 "" H 6100 1950 50  0001 C CNN
F 3 "" H 6100 1950 50  0001 C CNN
	1    6100 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 1950 6100 2050
Wire Wire Line
	7600 2400 7600 2450
Wire Wire Line
	6100 2400 6100 2450
Wire Wire Line
	6300 2050 6100 2050
Connection ~ 6100 2050
Wire Wire Line
	6100 2050 6100 2100
Wire Wire Line
	6100 2450 6300 2450
Connection ~ 6100 2450
Wire Wire Line
	6100 2450 6100 2550
Wire Wire Line
	7400 2450 7600 2450
Connection ~ 7600 2450
Wire Wire Line
	7600 2450 7600 2550
Wire Wire Line
	6000 4600 6200 4600
Wire Wire Line
	5700 4600 5600 4600
Wire Wire Line
	3850 4500 4100 4500
Wire Wire Line
	3850 4700 3950 4700
Wire Wire Line
	4100 4500 4100 4400
Wire Wire Line
	4100 4400 4600 4400
Wire Wire Line
	5600 5000 5600 4600
Connection ~ 5600 4600
Wire Wire Line
	5600 4600 4100 4600
$Comp
L Device:C C401
U 1 1 608EA21D
P 6000 3650
F 0 "C401" H 5886 3604 50  0000 R CNN
F 1 "0.1uF" H 5886 3695 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 6038 3500 50  0001 C CNN
F 3 "~" H 6000 3650 50  0001 C CNN
	1    6000 3650
	1    0    0    1   
$EndComp
Wire Wire Line
	6500 3500 6500 3800
$Comp
L RGBW-Bar:+5V_iso #PWR0406
U 1 1 6089173E
P 6250 3350
F 0 "#PWR0406" H 6250 3200 50  0001 C CNN
F 1 "+5V_iso" H 6265 3523 50  0000 C CNN
F 2 "" H 6250 3350 50  0001 C CNN
F 3 "" H 6250 3350 50  0001 C CNN
	1    6250 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 3500 6250 3500
Wire Wire Line
	6250 3350 6250 3500
Connection ~ 6250 3500
Wire Wire Line
	6250 3500 6500 3500
$Comp
L RGBW-Bar:GND_iso #PWR0403
U 1 1 608F11EC
P 6000 3800
F 0 "#PWR0403" H 6000 3550 50  0001 C CNN
F 1 "GND_iso" H 6005 3627 50  0000 C CNN
F 2 "" H 6000 3800 50  0001 C CNN
F 3 "" H 6000 3800 50  0001 C CNN
	1    6000 3800
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP404
U 1 1 6088B048
P 5700 2050
F 0 "TP404" V 5750 2250 50  0000 L CNN
F 1 "+5V_iso" V 5650 2250 50  0000 L CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 5900 2050 50  0001 C CNN
F 3 "~" H 5900 2050 50  0001 C CNN
	1    5700 2050
	0    -1   -1   0   
$EndComp
$Comp
L Connector:TestPoint TP402
U 1 1 6088F1EE
P 4100 4350
F 0 "TP402" H 4158 4468 50  0000 L CNN
F 1 "B" H 4158 4377 50  0000 L CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 4300 4350 50  0001 C CNN
F 3 "~" H 4300 4350 50  0001 C CNN
	1    4100 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 4350 4100 4400
Connection ~ 4100 4400
$Comp
L Connector:TestPoint TP403
U 1 1 60895751
P 4100 4650
F 0 "TP403" H 4042 4676 50  0000 R CNN
F 1 "A" H 4042 4767 50  0000 R CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 4300 4650 50  0001 C CNN
F 3 "~" H 4300 4650 50  0001 C CNN
	1    4100 4650
	-1   0    0    1   
$EndComp
Wire Wire Line
	4100 4600 4100 4650
Connection ~ 4100 4600
Wire Wire Line
	4100 4600 3850 4600
Text Label 5000 4400 0    50   ~ 0
B
Text Label 5000 4600 0    50   ~ 0
A
$Comp
L Connector:TestPoint TP409
U 1 1 61F30B4C
P 8100 5650
F 0 "TP409" H 8042 5676 50  0000 R CNN
F 1 "gnd" H 8042 5767 50  0000 R CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 8300 5650 50  0001 C CNN
F 3 "~" H 8300 5650 50  0001 C CNN
	1    8100 5650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0413
U 1 1 61F31292
P 8100 5800
F 0 "#PWR0413" H 8100 5550 50  0001 C CNN
F 1 "GND" H 8105 5627 50  0000 C CNN
F 2 "" H 8100 5800 50  0001 C CNN
F 3 "" H 8100 5800 50  0001 C CNN
	1    8100 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8100 5650 8100 5800
Wire Wire Line
	3950 4700 3950 5000
$Comp
L Connector:TestPoint TP401
U 1 1 62127E07
P 3950 5000
F 0 "TP401" V 4000 5050 50  0000 L TNN
F 1 "GND_iso" V 3900 5050 50  0000 L BNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 4150 5000 50  0001 C CNN
F 3 "~" H 4150 5000 50  0001 C CNN
	1    3950 5000
	0    1    1    0   
$EndComp
Wire Wire Line
	3950 5000 3950 5300
Connection ~ 3950 5000
Wire Notes Line width 18
	6850 2650 6850 3650
Text Notes 3050 1250 0    200  ~ 0
Isolated
Wire Notes Line width 18
	6850 1650 6850 1000
Wire Notes Line width 18
	6850 1000 3000 1000
Wire Notes Line width 18
	3000 1000 3000 6000
Wire Notes Line width 18
	3000 6000 6850 6000
Wire Notes Line width 18
	6850 6000 6850 5200
$Comp
L Connector:TestPoint TP405
U 1 1 6088D97E
P 5700 2450
F 0 "TP405" V 5750 2650 50  0000 L CNN
F 1 "GND_iso" V 5650 2950 50  0000 R CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 5900 2450 50  0001 C CNN
F 3 "~" H 5900 2450 50  0001 C CNN
	1    5700 2450
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5700 2050 6100 2050
Wire Wire Line
	6100 2450 5700 2450
$EndSCHEMATC
