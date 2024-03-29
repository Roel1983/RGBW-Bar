EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 9 13
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
L Device:Fuse F301
U 1 1 6085A39B
P 2750 4000
F 0 "F301" V 2553 4000 50  0000 C CNN
F 1 "Max. 5A F" V 2644 4000 50  0000 C CNN
F 2 "RGBW-Bar:Fuseholder_Cylinder-5x20mm_BLX_A_Horizontal" V 2680 4000 50  0001 C CNN
F 3 "~" H 2750 4000 50  0001 C CNN
	1    2750 4000
	0    1    1    0   
$EndComp
$Comp
L Device:D D301
U 1 1 6085B104
P 3000 4750
F 0 "D301" V 2954 4830 50  0000 L CNN
F 1 "SMBJ15A" V 3045 4830 50  0000 L CNN
F 2 "Diode_SMD:D_SMB_Handsoldering" H 3000 4750 50  0001 C CNN
F 3 "~" H 3000 4750 50  0001 C CNN
	1    3000 4750
	0    1    1    0   
$EndComp
$Comp
L Connector:Conn_01x02_Male J301
U 1 1 6085E602
P 2300 4850
F 0 "J301" H 2150 4850 50  0000 C CNN
F 1 "12VDC/5A" H 2250 4750 50  0000 R CNN
F 2 "RGBW-Bar:2EDGRC-5.08-2P" H 2300 4850 50  0001 C CNN
F 3 "" H 2300 4850 50  0001 C CNN
	1    2300 4850
	1    0    0    1   
$EndComp
$Comp
L Device:C C301
U 1 1 60861416
P 4000 4750
F 0 "C301" H 4115 4796 50  0000 L CNN
F 1 "0.1uF" H 4115 4705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 4038 4600 50  0001 C CNN
F 3 "~" H 4000 4750 50  0001 C CNN
	1    4000 4750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C303
U 1 1 60861ADF
P 5000 4750
F 0 "C303" H 5115 4796 50  0000 L CNN
F 1 "0.1uF" H 5115 4705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5038 4600 50  0001 C CNN
F 3 "~" H 5000 4750 50  0001 C CNN
	1    5000 4750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R302
U 1 1 6086DF9A
P 4500 4000
F 0 "R302" V 4400 4000 50  0000 C CNN
F 1 "R001/2W" V 4600 4000 50  0000 C CNN
F 2 "Resistor_SMD:R_2512_6332Metric_Pad1.40x3.35mm_HandSolder" V 4430 4000 50  0001 C CNN
F 3 "~" H 4500 4000 50  0001 C CNN
	1    4500 4000
	0    1    1    0   
$EndComp
Wire Wire Line
	2900 4000 3000 4000
Connection ~ 5000 4000
Wire Wire Line
	5000 4900 5000 5500
Wire Wire Line
	4000 4900 4000 5500
Connection ~ 5000 5500
Wire Wire Line
	3000 4600 3000 4000
Connection ~ 3000 4000
Wire Wire Line
	3000 4900 3000 5500
Wire Wire Line
	2500 4850 2500 5500
Connection ~ 3000 5500
Wire Wire Line
	2500 4000 2600 4000
Wire Wire Line
	2500 5500 3000 5500
Wire Wire Line
	4000 4000 4350 4000
Wire Wire Line
	4650 4000 5000 4000
Wire Wire Line
	4000 5500 5000 5500
$Comp
L power:PWR_FLAG #FLG0302
U 1 1 608AB0EF
P 5000 4000
F 0 "#FLG0302" H 5000 4075 50  0001 C CNN
F 1 "PWR_FLAG" H 5000 4173 50  0001 C CNN
F 2 "" H 5000 4000 50  0001 C CNN
F 3 "~" H 5000 4000 50  0001 C CNN
	1    5000 4000
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP301
U 1 1 608ACB83
P 5500 4000
F 0 "TP301" V 5454 4188 50  0000 L CNN
F 1 "+12V" V 5545 4188 50  0000 L CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 5700 4000 50  0001 C CNN
F 3 "~" H 5700 4000 50  0001 C CNN
	1    5500 4000
	0    1    1    0   
$EndComp
$Comp
L power:+12V #PWR0302
U 1 1 608A902A
P 5500 4000
F 0 "#PWR0302" H 5500 3850 50  0001 C CNN
F 1 "+12V" H 5515 4173 50  0000 C CNN
F 2 "" H 5500 4000 50  0001 C CNN
F 3 "" H 5500 4000 50  0001 C CNN
	1    5500 4000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0305
U 1 1 608A79AA
P 7500 5500
F 0 "#PWR0305" H 7500 5250 50  0001 C CNN
F 1 "GND" H 7505 5327 50  0000 C CNN
F 2 "" H 7500 5500 50  0001 C CNN
F 3 "" H 7500 5500 50  0001 C CNN
	1    7500 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 4500 7000 4600
Wire Wire Line
	8000 4600 8000 4500
Wire Wire Line
	7800 4500 8000 4500
Wire Wire Line
	8000 5000 7500 5000
Wire Wire Line
	8000 4900 8000 5000
Wire Wire Line
	7500 5000 7500 5500
Connection ~ 7500 5000
Wire Wire Line
	7000 5000 7500 5000
Wire Wire Line
	7000 4900 7000 5000
Wire Wire Line
	7000 4500 7200 4500
Connection ~ 7000 4500
$Comp
L Regulator_Linear:AMS1117-5.0 U302
U 1 1 608695B4
P 7500 4500
F 0 "U302" H 7500 4742 50  0000 C CNN
F 1 "AMS1117-5.0" H 7500 4651 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 7500 4700 50  0001 C CNN
F 3 "http://www.advanced-monolithic.com/pdf/ds1117.pdf" H 7600 4250 50  0001 C CNN
	1    7500 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 5150 6000 5500
Wire Wire Line
	9000 5150 9000 5500
Wire Wire Line
	9000 4500 9000 4850
Wire Wire Line
	7500 4800 7500 5000
$Comp
L Device:C C306
U 1 1 6087A060
P 7000 4750
F 0 "C306" H 6886 4704 50  0000 R CNN
F 1 "0.1uF" H 6886 4795 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 7038 4600 50  0001 C CNN
F 3 "~" H 7000 4750 50  0001 C CNN
	1    7000 4750
	1    0    0    1   
$EndComp
$Comp
L Device:C C307
U 1 1 60879AC0
P 8000 4750
F 0 "C307" H 8115 4796 50  0000 L CNN
F 1 "0.1uF" H 8115 4705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 8038 4600 50  0001 C CNN
F 3 "~" H 8000 4750 50  0001 C CNN
	1    8000 4750
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C308
U 1 1 6086D1C2
P 9000 5000
F 0 "C308" H 9118 5046 50  0000 L CNN
F 1 "10uF/10V" H 9118 4955 50  0000 L CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-3216-18_Kemet-A_Pad1.58x1.35mm_HandSolder" H 9038 4850 50  0001 C CNN
F 3 "~" H 9000 5000 50  0001 C CNN
	1    9000 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C305
U 1 1 60867727
P 6000 5000
F 0 "C305" H 6118 5046 50  0000 L CNN
F 1 "10uF/16V" H 6118 4955 50  0000 L CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-6032-28_Kemet-C_Pad2.25x2.35mm_HandSolder" H 6038 4850 50  0001 C CNN
F 3 "~" H 6000 5000 50  0001 C CNN
	1    6000 5000
	1    0    0    -1  
$EndComp
Connection ~ 4350 4000
$Comp
L power:+5V #PWR0303
U 1 1 608AA90C
P 6000 1500
F 0 "#PWR0303" H 6000 1350 50  0001 C CNN
F 1 "+5V" H 6015 1673 50  0000 C CNN
F 2 "" H 6000 1500 50  0001 C CNN
F 3 "" H 6000 1500 50  0001 C CNN
	1    6000 1500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0304
U 1 1 608AA13D
P 6000 3000
F 0 "#PWR0304" H 6000 2750 50  0001 C CNN
F 1 "GND" H 6005 2827 50  0000 C CNN
F 2 "" H 6000 3000 50  0001 C CNN
F 3 "" H 6000 3000 50  0001 C CNN
	1    6000 3000
	1    0    0    -1  
$EndComp
Text HLabel 7250 2150 2    50   Input ~ 0
scl
Text HLabel 7250 2050 2    50   BiDi ~ 0
sda
$Comp
L Device:C C304
U 1 1 6089F40C
P 5250 1750
F 0 "C304" H 5136 1704 50  0000 R CNN
F 1 "0.1uF" H 5136 1795 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5288 1600 50  0001 C CNN
F 3 "~" H 5250 1750 50  0001 C CNN
	1    5250 1750
	1    0    0    1   
$EndComp
$Comp
L Analog_ADC:INA219AxD U301
U 1 1 60887B3F
P 6000 2250
F 0 "U301" H 5900 2600 50  0000 R CNN
F 1 "INA219AxD" H 6050 2600 50  0000 L CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 6800 1900 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/ina219.pdf" H 6350 2150 50  0001 C CNN
F 4 "i2c: 0x44" H 6000 2250 50  0000 C CNN "I2C_Address"
	1    6000 2250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C302
U 1 1 608900B5
P 4500 3000
F 0 "C302" V 4248 3000 50  0000 C CNN
F 1 "1uF" V 4339 3000 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 4538 2850 50  0001 C CNN
F 3 "~" H 4500 3000 50  0001 C CNN
	1    4500 3000
	0    1    1    0   
$EndComp
$Comp
L Device:R R303
U 1 1 6088D510
P 4650 3500
F 0 "R303" H 4580 3454 50  0000 R CNN
F 1 "10R" H 4580 3545 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4580 3500 50  0001 C CNN
F 3 "~" H 4650 3500 50  0001 C CNN
	1    4650 3500
	-1   0    0    1   
$EndComp
$Comp
L Device:R R301
U 1 1 60889403
P 4350 3500
F 0 "R301" H 4281 3454 50  0000 R CNN
F 1 "10R" H 4281 3545 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4280 3500 50  0001 C CNN
F 3 "~" H 4350 3500 50  0001 C CNN
	1    4350 3500
	1    0    0    1   
$EndComp
Wire Wire Line
	3000 4000 4000 4000
Connection ~ 4000 4000
Wire Wire Line
	3000 5500 4000 5500
Connection ~ 4000 5500
Wire Wire Line
	6000 4500 7000 4500
Wire Wire Line
	6000 4500 6000 4850
Connection ~ 9000 4500
Connection ~ 4650 4000
Wire Wire Line
	4650 3650 4650 4000
Wire Wire Line
	4350 3650 4350 4000
Connection ~ 4650 3000
Wire Wire Line
	4650 3000 4650 3350
Connection ~ 4350 3000
Wire Wire Line
	4350 3000 4350 3350
Wire Wire Line
	8000 4500 8500 4500
Connection ~ 8000 4500
Wire Wire Line
	7500 5500 8500 5500
Wire Wire Line
	6000 2650 6000 3000
Connection ~ 6000 3000
Wire Wire Line
	6000 1500 6000 1850
Wire Wire Line
	4650 2350 4650 3000
Wire Wire Line
	4350 2150 4350 3000
Connection ~ 6000 1500
Wire Wire Line
	5250 1900 5250 3000
Wire Wire Line
	5250 1600 5250 1500
Wire Wire Line
	6000 1500 6750 1500
Wire Wire Line
	5250 1500 6000 1500
Wire Wire Line
	5250 3000 6000 3000
Wire Wire Line
	6400 2150 7250 2150
Wire Wire Line
	6400 2050 7250 2050
Wire Wire Line
	4350 2150 5600 2150
Wire Wire Line
	4650 2350 5600 2350
Connection ~ 6000 5500
Wire Wire Line
	6000 5500 7500 5500
Connection ~ 7500 5500
$Comp
L power:PWR_FLAG #FLG0303
U 1 1 608D884D
P 5000 5500
F 0 "#FLG0303" H 5000 5575 50  0001 C CNN
F 1 "PWR_FLAG" H 5000 5673 50  0001 C CNN
F 2 "" H 5000 5500 50  0001 C CNN
F 3 "~" H 5000 5500 50  0001 C CNN
	1    5000 5500
	-1   0    0    1   
$EndComp
Wire Wire Line
	2500 4000 2500 4750
$Comp
L power:+5V #PWR0306
U 1 1 608A8467
P 9000 4500
F 0 "#PWR0306" H 9000 4350 50  0001 C CNN
F 1 "+5V" H 9015 4673 50  0000 C CNN
F 2 "" H 9000 4500 50  0001 C CNN
F 3 "" H 9000 4500 50  0001 C CNN
	1    9000 4500
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP303
U 1 1 608AC65D
P 9000 4500
F 0 "TP303" V 8954 4688 50  0000 L CNN
F 1 "+5V" V 9045 4688 50  0000 L CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 9200 4500 50  0001 C CNN
F 3 "~" H 9200 4500 50  0001 C CNN
	1    9000 4500
	0    1    1    0   
$EndComp
Wire Wire Line
	5000 5500 6000 5500
$Comp
L Connector:TestPoint TP304
U 1 1 608D9E42
P 9000 5600
F 0 "TP304" H 8942 5626 50  0000 R CNN
F 1 "gnd" H 8942 5717 50  0000 R CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 9200 5600 50  0001 C CNN
F 3 "~" H 9200 5600 50  0001 C CNN
	1    9000 5600
	-1   0    0    1   
$EndComp
$Comp
L power:GNDPWR #PWR0301
U 1 1 60965453
P 2500 5500
F 0 "#PWR0301" H 2500 5300 50  0001 C CNN
F 1 "GNDPWR" H 2504 5346 50  0000 C CNN
F 2 "" H 2500 5450 50  0001 C CNN
F 3 "" H 2500 5450 50  0001 C CNN
	1    2500 5500
	1    0    0    -1  
$EndComp
Connection ~ 2500 5500
Wire Wire Line
	6750 1500 6750 2350
Wire Wire Line
	6750 2350 6400 2350
Wire Wire Line
	6400 2450 6750 2450
Wire Wire Line
	6750 2450 6750 3000
Wire Wire Line
	6000 3000 6750 3000
Wire Wire Line
	9000 5500 9000 5600
Connection ~ 9000 5500
$Comp
L Connector:TestPoint TP302
U 1 1 60E20AC8
P 6000 5600
F 0 "TP302" H 5942 5626 50  0000 R CNN
F 1 "gnd" H 5942 5717 50  0000 R CNN
F 2 "RGBW-Bar:TestPoint_Pad_D1.0mm" H 6200 5600 50  0001 C CNN
F 3 "~" H 6200 5600 50  0001 C CNN
	1    6000 5600
	-1   0    0    1   
$EndComp
Wire Wire Line
	6000 5500 6000 5600
Wire Wire Line
	5000 4000 5500 4000
Connection ~ 5500 4000
$Comp
L power:PWR_FLAG #FLG0301
U 1 1 60EC36EA
P 4000 4000
F 0 "#FLG0301" H 4000 4075 50  0001 C CNN
F 1 "PWR_FLAG" H 4000 4173 50  0001 C CNN
F 2 "" H 4000 4000 50  0001 C CNN
F 3 "~" H 4000 4000 50  0001 C CNN
	1    4000 4000
	1    0    0    -1  
$EndComp
Text Label 2500 4650 1    50   ~ 0
unprotected_12VDC
Text Label 3100 4000 0    50   ~ 0
+12V_not_measured
Wire Wire Line
	5000 4000 5000 4600
Wire Wire Line
	4000 4000 4000 4500
$Comp
L Device:R R304
U 1 1 6381CA7A
P 5500 4500
F 0 "R304" V 5293 4500 50  0000 C CNN
F 1 "62R/0.25W" V 5384 4500 50  0000 C CNN
F 2 "Resistor_SMD:R_1210_3225Metric_Pad1.30x2.65mm_HandSolder" V 5430 4500 50  0001 C CNN
F 3 "~" H 5500 4500 50  0001 C CNN
	1    5500 4500
	0    1    1    0   
$EndComp
Wire Wire Line
	4000 4500 5350 4500
Connection ~ 4000 4500
Wire Wire Line
	4000 4500 4000 4600
Wire Wire Line
	5650 4500 6000 4500
Connection ~ 6000 4500
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 638308BB
P 6000 4500
F 0 "#FLG0101" H 6000 4575 50  0001 C CNN
F 1 "PWR_FLAG" H 6000 4673 50  0001 C CNN
F 2 "" H 6000 4500 50  0001 C CNN
F 3 "~" H 6000 4500 50  0001 C CNN
	1    6000 4500
	1    0    0    -1  
$EndComp
$Comp
L Device:D_Zener D302
U 1 1 63837588
P 8500 5000
F 0 "D302" V 8454 5080 50  0000 L CNN
F 1 "5v1" V 8545 5080 50  0000 L CNN
F 2 "Diode_SMD:D_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 8500 5000 50  0001 C CNN
F 3 "~" H 8500 5000 50  0001 C CNN
	1    8500 5000
	0    1    1    0   
$EndComp
Wire Wire Line
	8500 4850 8500 4500
Connection ~ 8500 4500
Wire Wire Line
	8500 4500 9000 4500
Wire Wire Line
	8500 5150 8500 5500
Connection ~ 8500 5500
Wire Wire Line
	8500 5500 9000 5500
$EndSCHEMATC
