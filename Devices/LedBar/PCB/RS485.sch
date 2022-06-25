EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 13
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
L Interface_UART:ISO3082DW U401
U 1 1 60866215
P 6300 4500
F 0 "U401" H 6300 5250 50  0000 C CNN
F 1 "ISO3082DW" H 6300 5150 50  0000 C CNN
F 2 "Package_SO:SOIC-16W_7.5x10.3mm_P1.27mm" H 6300 5350 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/iso3082.pdf" H 6100 3750 50  0001 C CNN
	1    6300 4500
	-1   0    0    -1  
$EndComp
$Comp
L Device:D_TVS_x2_AAC D401
U 1 1 6086DBB2
P 4600 5000
F 0 "D401" H 4600 5217 50  0000 C CNN
F 1 "PSM712" H 4600 5126 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23_Handsoldering" H 4450 5000 50  0001 C CNN
F 3 "http://www.protekdevices.com/xyz/documents/datasheets/psm712.pdf" H 4450 5000 50  0001 C CNN
	1    4600 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 5200 6500 5300
Wire Wire Line
	6500 5300 6600 5300
Wire Wire Line
	6700 5300 6700 5200
Wire Wire Line
	6600 5200 6600 5300
Connection ~ 6600 5300
Wire Wire Line
	6600 5300 6700 5300
$Comp
L power:GND #PWR0408
U 1 1 6086EC52
P 6600 5300
F 0 "#PWR0408" H 6600 5050 50  0001 C CNN
F 1 "GND" H 6605 5127 50  0000 C CNN
F 2 "" H 6600 5300 50  0001 C CNN
F 3 "" H 6600 5300 50  0001 C CNN
	1    6600 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 4700 7000 4700
Wire Wire Line
	7000 4700 7000 4200
Wire Wire Line
	7000 4200 6900 4200
Text HLabel 8100 4400 2    50   Input ~ 0
txd
Text HLabel 8100 4600 2    50   Output ~ 0
rxd
Text HLabel 8100 5000 2    50   Input ~ 0
tx_en
$Comp
L power:+5V #PWR0409
U 1 1 6086FFFF
P 6850 3350
F 0 "#PWR0409" H 6850 3200 50  0001 C CNN
F 1 "+5V" H 6865 3523 50  0000 C CNN
F 2 "" H 6850 3350 50  0001 C CNN
F 3 "" H 6850 3350 50  0001 C CNN
	1    6850 3350
	1    0    0    -1  
$EndComp
$Comp
L Device:C C404
U 1 1 6087070C
P 7100 3650
F 0 "C404" H 7215 3696 50  0000 L CNN
F 1 "0.1uF" H 7215 3605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 7138 3500 50  0001 C CNN
F 3 "~" H 7100 3650 50  0001 C CNN
	1    7100 3650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0412
U 1 1 60870F07
P 7100 3800
F 0 "#PWR0412" H 7100 3550 50  0001 C CNN
F 1 "GND" H 7105 3627 50  0000 C CNN
F 2 "" H 7100 3800 50  0001 C CNN
F 3 "" H 7100 3800 50  0001 C CNN
	1    7100 3800
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP406
U 1 1 608731C2
P 7600 4350
F 0 "TP406" H 7658 4468 50  0000 L CNN
F 1 "txd" H 7658 4377 50  0000 L CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 7800 4350 50  0001 C CNN
F 3 "~" H 7800 4350 50  0001 C CNN
	1    7600 4350
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP407
U 1 1 608755BF
P 7600 4650
F 0 "TP407" H 7542 4676 50  0000 R CNN
F 1 "rxd" H 7542 4767 50  0000 R CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 7800 4650 50  0001 C CNN
F 3 "~" H 7800 4650 50  0001 C CNN
	1    7600 4650
	-1   0    0    1   
$EndComp
$Comp
L Connector:TestPoint TP408
U 1 1 60875DD3
P 7600 5050
F 0 "TP408" H 7542 5076 50  0000 R CNN
F 1 "tx_en" H 7542 5167 50  0000 R CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 7800 5050 50  0001 C CNN
F 3 "~" H 7800 5050 50  0001 C CNN
	1    7600 5050
	-1   0    0    1   
$EndComp
Wire Wire Line
	7000 5000 7000 4700
Wire Wire Line
	7600 5000 8100 5000
Connection ~ 7000 4700
Wire Wire Line
	7000 5000 7600 5000
Connection ~ 7600 5000
Wire Wire Line
	6600 3500 6600 3800
Wire Wire Line
	6600 3500 6850 3500
Wire Wire Line
	6850 3350 6850 3500
Connection ~ 6850 3500
Wire Wire Line
	6850 3500 7100 3500
Wire Wire Line
	7600 5000 7600 5050
Wire Wire Line
	6900 4400 7600 4400
Wire Wire Line
	6900 4600 7600 4600
Wire Wire Line
	7600 4650 7600 4600
Connection ~ 7600 4600
Wire Wire Line
	7600 4600 8100 4600
Wire Wire Line
	7600 4350 7600 4400
Connection ~ 7600 4400
Wire Wire Line
	7600 4400 8100 4400
$Comp
L Device:R R402
U 1 1 60882D64
P 5350 4400
F 0 "R402" V 5557 4400 50  0000 C CNN
F 1 "120" V 5466 4400 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5280 4400 50  0001 C CNN
F 3 "~" H 5350 4400 50  0001 C CNN
	1    5350 4400
	0    -1   -1   0   
$EndComp
$Comp
L AmbientLight:GND_iso #PWR0407
U 1 1 6088C9C5
P 6000 5300
F 0 "#PWR0407" H 6000 5050 50  0001 C CNN
F 1 "GND_iso" H 6005 5127 50  0000 C CNN
F 2 "" H 6000 5300 50  0001 C CNN
F 3 "" H 6000 5300 50  0001 C CNN
	1    6000 5300
	1    0    0    -1  
$EndComp
$Comp
L AmbientLight:GND_iso #PWR0401
U 1 1 6088DF33
P 3450 5300
F 0 "#PWR0401" H 3450 5050 50  0001 C CNN
F 1 "GND_iso" H 3455 5127 50  0000 C CNN
F 2 "" H 3450 5300 50  0001 C CNN
F 3 "" H 3450 5300 50  0001 C CNN
	1    3450 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 5200 5900 5300
Wire Wire Line
	5900 5300 6000 5300
Wire Wire Line
	6100 5300 6100 5200
Connection ~ 6000 5300
Wire Wire Line
	6000 5300 6100 5300
Wire Wire Line
	6000 5200 6000 5300
$Comp
L AmbientLight:GND_iso #PWR0402
U 1 1 60894182
P 4600 5300
F 0 "#PWR0402" H 4600 5050 50  0001 C CNN
F 1 "GND_iso" H 4605 5127 50  0000 C CNN
F 2 "" H 4600 5300 50  0001 C CNN
F 3 "" H 4600 5300 50  0001 C CNN
	1    4600 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 4400 5700 4400
$Comp
L Connector_Generic:Conn_01x03 J401
U 1 1 60886AC6
P 3150 4600
F 0 "J401" H 3150 4350 50  0000 C CNN
F 1 "RS485" H 3450 4600 50  0000 R CNN
F 2 "AmbientLight:15EDGRC-3.5-3P" H 3150 4600 50  0001 C CNN
F 3 "~" H 3150 4600 50  0001 C CNN
	1    3150 4600
	-1   0    0    1   
$EndComp
Wire Wire Line
	5200 4400 4100 4400
Wire Wire Line
	4950 5000 5100 5000
Wire Wire Line
	4250 5000 4100 5000
Wire Wire Line
	4100 5000 4100 4400
Connection ~ 4100 4400
$Comp
L Device:R R403
U 1 1 608A0159
P 5350 4600
F 0 "R403" V 5150 4600 50  0000 C CNN
F 1 "120" V 5250 4600 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5280 4600 50  0001 C CNN
F 3 "~" H 5350 4600 50  0001 C CNN
	1    5350 4600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4600 5150 4600 5300
$Comp
L AmbientLight:B0505S-1W-SIP4 U402
U 1 1 608B32EA
P 6350 2250
F 0 "U402" H 6350 2765 50  0000 C CNN
F 1 "B0505S-1W-SIP4" H 6350 2674 50  0000 C CNN
F 2 "AmbientLight:B0505S-1W" H 6100 2250 50  0001 C CNN
F 3 "https://datasheetspdf.com/pdf-file/792761/MORNSUN/B0505S-1W/1" H 6100 2250 50  0001 C CNN
	1    6350 2250
	-1   0    0    -1  
$EndComp
$Comp
L Device:C C403
U 1 1 608B4345
P 7100 2250
F 0 "C403" H 7215 2296 50  0000 L CNN
F 1 "4.7uF" H 7215 2205 50  0000 L CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-3216-18_Kemet-A_Pad1.58x1.35mm_HandSolder" H 7138 2100 50  0001 C CNN
F 3 "~" H 7100 2250 50  0001 C CNN
	1    7100 2250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C402
U 1 1 608B4777
P 5600 2250
F 0 "C402" H 5486 2204 50  0000 R CNN
F 1 "10uF" H 5486 2295 50  0000 R CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-3216-18_Kemet-A_Pad1.58x1.35mm_HandSolder" H 5638 2100 50  0001 C CNN
F 3 "~" H 5600 2250 50  0001 C CNN
	1    5600 2250
	1    0    0    1   
$EndComp
Wire Wire Line
	6900 2050 7100 2050
Wire Wire Line
	7100 2050 7100 2100
$Comp
L power:GND #PWR0411
U 1 1 608BA353
P 7100 2550
F 0 "#PWR0411" H 7100 2300 50  0001 C CNN
F 1 "GND" H 7105 2377 50  0000 C CNN
F 2 "" H 7100 2550 50  0001 C CNN
F 3 "" H 7100 2550 50  0001 C CNN
	1    7100 2550
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0410
U 1 1 608BB791
P 7100 1950
F 0 "#PWR0410" H 7100 1800 50  0001 C CNN
F 1 "+5V" H 7115 2123 50  0000 C CNN
F 2 "" H 7100 1950 50  0001 C CNN
F 3 "" H 7100 1950 50  0001 C CNN
	1    7100 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7100 1950 7100 2050
Connection ~ 7100 2050
$Comp
L AmbientLight:GND_iso #PWR0405
U 1 1 608BCBD7
P 5600 2550
F 0 "#PWR0405" H 5600 2300 50  0001 C CNN
F 1 "GND_iso" H 5605 2377 50  0000 C CNN
F 2 "" H 5600 2550 50  0001 C CNN
F 3 "" H 5600 2550 50  0001 C CNN
	1    5600 2550
	1    0    0    -1  
$EndComp
$Comp
L AmbientLight:+5V_iso #PWR0404
U 1 1 608BEF84
P 5600 1950
F 0 "#PWR0404" H 5600 1800 50  0001 C CNN
F 1 "+5V_iso" H 5615 2123 50  0000 C CNN
F 2 "" H 5600 1950 50  0001 C CNN
F 3 "" H 5600 1950 50  0001 C CNN
	1    5600 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 1950 5600 2050
Wire Wire Line
	7100 2400 7100 2450
Wire Wire Line
	5600 2400 5600 2450
Wire Wire Line
	5800 2050 5600 2050
Connection ~ 5600 2050
Wire Wire Line
	5600 2050 5600 2100
Wire Wire Line
	5600 2450 5800 2450
Connection ~ 5600 2450
Wire Wire Line
	5600 2450 5600 2550
Wire Wire Line
	6900 2450 7100 2450
Connection ~ 7100 2450
Wire Wire Line
	7100 2450 7100 2550
Wire Wire Line
	5500 4600 5700 4600
Wire Wire Line
	5200 4600 5100 4600
Wire Wire Line
	3350 4500 3600 4500
Wire Wire Line
	3350 4700 3450 4700
Wire Wire Line
	3600 4500 3600 4400
Wire Wire Line
	3600 4400 4100 4400
Wire Wire Line
	5100 5000 5100 4600
Connection ~ 5100 4600
Wire Wire Line
	5100 4600 3600 4600
$Comp
L Device:C C401
U 1 1 608EA21D
P 5500 3650
F 0 "C401" H 5386 3604 50  0000 R CNN
F 1 "0.1uF" H 5386 3695 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5538 3500 50  0001 C CNN
F 3 "~" H 5500 3650 50  0001 C CNN
	1    5500 3650
	1    0    0    1   
$EndComp
Wire Wire Line
	6000 3500 6000 3800
$Comp
L AmbientLight:+5V_iso #PWR0406
U 1 1 6089173E
P 5750 3350
F 0 "#PWR0406" H 5750 3200 50  0001 C CNN
F 1 "+5V_iso" H 5765 3523 50  0000 C CNN
F 2 "" H 5750 3350 50  0001 C CNN
F 3 "" H 5750 3350 50  0001 C CNN
	1    5750 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 3500 5750 3500
Wire Wire Line
	5750 3350 5750 3500
Connection ~ 5750 3500
Wire Wire Line
	5750 3500 6000 3500
$Comp
L AmbientLight:GND_iso #PWR0403
U 1 1 608F11EC
P 5500 3800
F 0 "#PWR0403" H 5500 3550 50  0001 C CNN
F 1 "GND_iso" H 5505 3627 50  0000 C CNN
F 2 "" H 5500 3800 50  0001 C CNN
F 3 "" H 5500 3800 50  0001 C CNN
	1    5500 3800
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP404
U 1 1 6088B048
P 5000 2000
F 0 "TP404" H 5058 2118 50  0000 L CNN
F 1 "+5V_iso" H 5058 2027 50  0000 L CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 5200 2000 50  0001 C CNN
F 3 "~" H 5200 2000 50  0001 C CNN
	1    5000 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 2000 5000 2050
Wire Wire Line
	5000 2050 5600 2050
$Comp
L Connector:TestPoint TP405
U 1 1 6088D97E
P 5000 2500
F 0 "TP405" H 4942 2526 50  0000 R CNN
F 1 "GND_iso" H 4942 2617 50  0000 R CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 5200 2500 50  0001 C CNN
F 3 "~" H 5200 2500 50  0001 C CNN
	1    5000 2500
	-1   0    0    1   
$EndComp
Wire Wire Line
	5600 2450 5000 2450
Wire Wire Line
	5000 2450 5000 2500
$Comp
L Connector:TestPoint TP402
U 1 1 6088F1EE
P 3600 4350
F 0 "TP402" H 3658 4468 50  0000 L CNN
F 1 "B" H 3658 4377 50  0000 L CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 3800 4350 50  0001 C CNN
F 3 "~" H 3800 4350 50  0001 C CNN
	1    3600 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 4350 3600 4400
Connection ~ 3600 4400
$Comp
L Connector:TestPoint TP403
U 1 1 60895751
P 3600 4650
F 0 "TP403" H 3542 4676 50  0000 R CNN
F 1 "A" H 3542 4767 50  0000 R CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 3800 4650 50  0001 C CNN
F 3 "~" H 3800 4650 50  0001 C CNN
	1    3600 4650
	-1   0    0    1   
$EndComp
Wire Wire Line
	3600 4600 3600 4650
Connection ~ 3600 4600
Wire Wire Line
	3600 4600 3350 4600
Text Label 4500 4400 0    50   ~ 0
B
Text Label 4500 4600 0    50   ~ 0
A
Text Notes 4600 2350 2    50   ~ 0
Resistor added to make sure: The\nB0505S has a minimum load of\n10% of its maximum load.
$Comp
L Device:R R401
U 1 1 6151011B
P 5000 2250
F 0 "R401" H 4950 2300 50  0000 R CNN
F 1 "56" H 4950 2200 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4930 2250 50  0001 C CNN
F 3 "~" H 5000 2250 50  0001 C CNN
	1    5000 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 2050 5000 2100
Connection ~ 5000 2050
Wire Wire Line
	5000 2400 5000 2450
Connection ~ 5000 2450
$Comp
L Connector:TestPoint TP409
U 1 1 61F30B4C
P 7600 5650
F 0 "TP409" H 7542 5676 50  0000 R CNN
F 1 "gnd" H 7542 5767 50  0000 R CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 7800 5650 50  0001 C CNN
F 3 "~" H 7800 5650 50  0001 C CNN
	1    7600 5650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0413
U 1 1 61F31292
P 7600 5800
F 0 "#PWR0413" H 7600 5550 50  0001 C CNN
F 1 "GND" H 7605 5627 50  0000 C CNN
F 2 "" H 7600 5800 50  0001 C CNN
F 3 "" H 7600 5800 50  0001 C CNN
	1    7600 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 5650 7600 5800
Wire Wire Line
	3450 4700 3450 5000
$Comp
L Connector:TestPoint TP401
U 1 1 62127E07
P 3450 5000
F 0 "TP401" V 3550 5150 50  0000 C CNN
F 1 "GND_iso" V 3392 5117 50  0000 C CNN
F 2 "AmbientLight:TestPoint_Pad_D1.0mm" H 3650 5000 50  0001 C CNN
F 3 "~" H 3650 5000 50  0001 C CNN
	1    3450 5000
	0    1    1    0   
$EndComp
Wire Wire Line
	3450 5000 3450 5300
Connection ~ 3450 5000
$EndSCHEMATC
