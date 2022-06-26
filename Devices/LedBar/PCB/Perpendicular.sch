EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 13 13
Title ""
Date ""
Rev ""
Comp ""
Comment1 "GNU General Public License v3.0"
Comment2 ""
Comment3 ""
Comment4 "4 channel RGBW LED bar, Arduino compatible with isolated half duplex RS485."
$EndDescr
$Comp
L Connector_Generic:Conn_02x06_Odd_Even J1001
U 1 1 61789538
P 5950 2500
F 0 "J1001" H 6000 2917 50  0000 C CNN
F 1 "Conn_02x06_Odd_Even" H 6000 2826 50  0000 C CNN
F 2 "RGBW-Bar:perpendicular_pcb_1mm_male_2x6" H 5950 2500 50  0001 C CNN
F 3 "~" H 5950 2500 50  0001 C CNN
	1    5950 2500
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x06_Odd_Even J1002
U 1 1 6178A2F7
P 5950 4450
F 0 "J1002" H 6000 4867 50  0000 C CNN
F 1 "Conn_02x06_Odd_Even" H 6000 4776 50  0000 C CNN
F 2 "RGBW-Bar:PinHeader_2x06_P200mm_PCB_edge" H 5950 4450 50  0001 C CNN
F 3 "~" H 5950 4450 50  0001 C CNN
	1    5950 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 2300 5000 4250
Wire Wire Line
	4900 2400 4900 4350
Wire Wire Line
	4800 2500 4800 4450
Wire Wire Line
	4700 2600 4700 4550
Wire Wire Line
	4600 2700 4600 4650
Wire Wire Line
	4500 2800 4500 4750
Wire Wire Line
	7000 2300 7000 4250
Wire Wire Line
	7100 2400 7100 4350
Wire Wire Line
	7200 2500 7200 4450
Wire Wire Line
	7300 2600 7300 4550
Wire Wire Line
	7400 2700 7400 4650
Wire Wire Line
	7500 2800 7500 4750
Wire Wire Line
	5000 2300 5750 2300
Wire Wire Line
	4900 2400 5750 2400
Wire Wire Line
	4800 2500 5750 2500
Wire Wire Line
	4700 2600 5750 2600
Wire Wire Line
	4600 2700 5750 2700
Wire Wire Line
	4500 2800 5750 2800
Text Label 5100 2300 0    50   ~ 0
strip3_+12V_1
Text Label 5100 2400 0    50   ~ 0
strip3_+12V_2
Text Label 5100 2500 0    50   ~ 0
strip3_g_out
Text Label 5100 2600 0    50   ~ 0
strip3_r_out
Text Label 5100 2700 0    50   ~ 0
strip3_b_out
Text Label 5100 2800 0    50   ~ 0
strip3_w_out
Wire Wire Line
	5000 4250 5750 4250
Wire Wire Line
	4900 4350 5750 4350
Wire Wire Line
	4800 4450 5750 4450
Wire Wire Line
	4700 4550 5750 4550
Wire Wire Line
	4600 4650 5750 4650
Wire Wire Line
	4500 4750 5750 4750
Wire Wire Line
	6250 2300 7000 2300
Wire Wire Line
	6250 2400 7100 2400
Wire Wire Line
	6250 2500 7200 2500
Wire Wire Line
	6250 2600 7300 2600
Wire Wire Line
	6250 2700 7400 2700
Wire Wire Line
	6250 2800 7500 2800
Wire Wire Line
	6250 4250 7000 4250
Wire Wire Line
	6250 4350 7100 4350
Wire Wire Line
	6250 4450 7200 4450
Wire Wire Line
	6250 4550 7300 4550
Wire Wire Line
	6250 4650 7400 4650
Wire Wire Line
	6250 4750 7500 4750
Text Label 6300 2300 0    50   ~ 0
strip2_+12V_1
Text Label 6300 2400 0    50   ~ 0
strip2_+12V_2
Text Label 6300 2500 0    50   ~ 0
strip2_g_out
Text Label 6300 2600 0    50   ~ 0
strip2_r_out
Text Label 6300 2700 0    50   ~ 0
strip2_b_out
Text Label 6300 2800 0    50   ~ 0
strip2_w_out
$EndSCHEMATC
