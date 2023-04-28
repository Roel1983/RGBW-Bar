// DO NOT EDIT THIS FILE
// This file is generated by: ../../../Shared/3D/kicad_pcb_to_scad.py
// Input file: ../../PCB/Mainboard/Mainboard.kicad_pcb

// Getter functions
function ref_id(ref)  = ref[0];
function ref_nr(ref)  = ref[1];
function ref_str(ref) = str(ref_id(ref), ref_nr(ref));

function at_side(at)  = at[0];
function at_loc(at)   = at[1];
function at_rot(at)   = at[2];

function component_ref      (component) = component[0];
function component_ref_id   (component) = ref_id (component_ref(component));
function component_ref_nr   (component) = ref_nr (component_ref(component));
function component_ref_str  (component) = ref_str(component_ref(component));
function component_at       (component) = component[1];
function component_at_side  (component) = at_side(component_at(component));
function component_at_loc   (component) = at_loc (component_at(component));
function component_at_rot   (component) = at_rot (component_at(component));
function component_footprint(component) = component[2];

// Board size
PCB_THICKNESS = 1.6;
PCB_BOUNDS_MAINBOARD = [[-31.75, 31.75], [-35.56, 38.1]];

// Components
COMPONENT_BT901 = [
	["BT", 901],
	["F", [24.87, 20.8], 90.0],
	"Battery:BatteryHolder_LINX_BAT-HLD-012-SMT"];

COMPONENT_C301 = [
	["C", 301],
	["B", [8.636, -11.303], 0.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C302 = [
	["C", 302],
	["B", [12.446, -8.382], 270.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C303 = [
	["C", 303],
	["B", [8.636, -7.112], 0.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C304 = [
	["C", 304],
	["B", [12.446, -12.192], 270.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C305 = [
	["C", 305],
	["B", [11.938, -24.0665], 270.0],
	"Capacitor_Tantalum_SMD:CP_EIA-6032-28_Kemet-C_Pad2.25x2.35mm_HandSolder"];

COMPONENT_C306 = [
	["C", 306],
	["B", [15.7695, -26.162], 180.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C307 = [
	["C", 307],
	["B", [22.352, -18.288], 270.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C308 = [
	["C", 308],
	["B", [24.384, -18.796], 270.0],
	"Capacitor_Tantalum_SMD:CP_EIA-3216-18_Kemet-A_Pad1.58x1.35mm_HandSolder"];

COMPONENT_C401 = [
	["C", 401],
	["B", [-26.924, -17.018], 0.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C402 = [
	["C", 402],
	["B", [-22.352, -14.224], 180.0],
	"Capacitor_Tantalum_SMD:CP_EIA-3216-18_Kemet-A_Pad1.58x1.35mm_HandSolder"];

COMPONENT_C403 = [
	["C", 403],
	["B", [-17.3585, -14.224], 0.0],
	"Capacitor_Tantalum_SMD:CP_EIA-3216-18_Kemet-A_Pad1.58x1.35mm_HandSolder"];

COMPONENT_C404 = [
	["C", 404],
	["B", [-13.716, -13.208], 90.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C501 = [
	["C", 501],
	["B", [13.5255, 16.3195], 270.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C502 = [
	["C", 502],
	["B", [-12.7, 2.032], 90.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C503 = [
	["C", 503],
	["F", [-12.7, -0.508], 90.0],
	"Capacitor_THT:CP_Radial_D10.0mm_P5.00mm"];

COMPONENT_C504 = [
	["C", 504],
	["B", [12.7, 2.032], 90.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C505 = [
	["C", 505],
	["F", [12.7, -0.508], 90.0],
	"Capacitor_THT:CP_Radial_D10.0mm_P5.00mm"];

COMPONENT_C601 = [
	["C", 601],
	["B", [-0.889, -33.147], 0.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C701 = [
	["C", 701],
	["B", [-20.701, 12.573], 0.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C702 = [
	["C", 702],
	["B", [-18.923, 25.527], 180.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C703 = [
	["C", 703],
	["B", [-16.129, 12.573], 0.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C704 = [
	["C", 704],
	["B", [-2.921, 26.797], 90.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C705 = [
	["C", 705],
	["B", [-15.748, 27.559], 180.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C706 = [
	["C", 706],
	["B", [-11.938, 27.559], 0.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C801 = [
	["C", 801],
	["B", [-7.112, -26.543], 0.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C802 = [
	["C", 802],
	["B", [-5.08, -10.668], 180.0],
	"Capacitor_Tantalum_SMD:CP_EIA-6032-28_Kemet-C_Pad2.25x2.35mm_HandSolder"];

COMPONENT_C803 = [
	["C", 803],
	["B", [-7.112, -23.876], 0.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_C901 = [
	["C", 901],
	["B", [28.956, 25.908], 90.0],
	"Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder"];

COMPONENT_D301 = [
	["D", 301],
	["B", [7.62, -25.019], 270.0],
	"Diode_SMD:D_SMB_Handsoldering"];

COMPONENT_D302 = [
	["D", 302],
	["B", [10.287, -15.6845], 0.0],
	"Diode_SMD:D_1206_3216Metric_Pad1.42x1.75mm_HandSolder"];

COMPONENT_D401 = [
	["D", 401],
	["B", [-27.432, -24.003], 0.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_D701 = [
	["D", 701],
	["F", [-17.78, 34.29], 270.0],
	"LED_THT:LED_D3.0mm"];

COMPONENT_D702 = [
	["D", 702],
	["F", [17.78, 34.29], 270.0],
	"LED_THT:LED_D3.0mm"];

COMPONENT_D703 = [
	["D", 703],
	["F", [12.7, 34.29], 270.0],
	"LED_THT:LED_D3.0mm"];

COMPONENT_D704 = [
	["D", 704],
	["F", [7.62, 34.29], 270.0],
	"LED_THT:LED_D3.0mm"];

COMPONENT_D705 = [
	["D", 705],
	["F", [2.54, 34.29], 270.0],
	"LED_THT:LED_D3.0mm"];

COMPONENT_D706 = [
	["D", 706],
	["B", [-26.0985, 25.908], 270.0],
	"Diode_SMD:D_1206_3216Metric_Pad1.42x1.75mm_HandSolder"];

COMPONENT_D801 = [
	["D", 801],
	["B", [1.524, -18.9865], 270.0],
	"Diode_SMD:D_1206_3216Metric_Pad1.42x1.75mm_HandSolder"];

COMPONENT_F301 = [
	["F", 301],
	["F", [4.826, -8.89], 0.0],
	"RGBW-Bar:Fuseholder_Cylinder-5x20mm_BLX_A_Horizontal"];

COMPONENT_H201 = [
	["H", 201],
	["F", [-26.67, 33.02], 0.0],
	"MountingHole:MountingHole_4.3mm_M4"];

COMPONENT_H202 = [
	["H", 202],
	["F", [-26.67, -30.48], 180.0],
	"MountingHole:MountingHole_4.3mm_M4"];

COMPONENT_H203 = [
	["H", 203],
	["F", [26.67, 33.02], 0.0],
	"RGBW-Bar:MountingHole_4.3mm_M4_modified1"];

COMPONENT_H204 = [
	["H", 204],
	["F", [26.67, -30.48], 0.0],
	"MountingHole:MountingHole_4.3mm_M4"];

COMPONENT_J301 = [
	["J", 301],
	["F", [18.542, -30.48], 180.0],
	"RGBW-Bar:2EDGRC-5.08-2P"];

COMPONENT_J401 = [
	["J", 401],
	["F", [-11.43, -30.48], 180.0],
	"RGBW-Bar:15EDGRC-3.5-3P"];

COMPONENT_J501 = [
	["J", 501],
	["F", [-24.13, -1.27], 180.0],
	"Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Horizontal"];

COMPONENT_J502 = [
	["J", 502],
	["F", [0.0, 0.508], 180.0],
	"RGBW-Bar:perpendicular_pcb_1mm_female_2x6"];

COMPONENT_J503 = [
	["J", 503],
	["F", [24.13, 8.89], 0.0],
	"Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Horizontal"];

COMPONENT_J601 = [
	["J", 601],
	["F", [0.0, -30.48], 180.0],
	"RGBW-Bar:15EDGRC-3.5-2P"];

COMPONENT_J701 = [
	["J", 701],
	["F", [-28.829, 22.2885], 0.0],
	"RGBW-Bar:ISP_P1.27mm_single_row"];

COMPONENT_JP601 = [
	["JP", 601],
	["B", [-6.35, -30.764], 90.0],
	"Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm"];

COMPONENT_JP701 = [
	["JP", 701],
	["B", [15.24, 24.638], 270.0],
	"Jumper:SolderJumper-2_P1.3mm_Open_TrianglePad1.0x1.5mm"];

COMPONENT_JP702 = [
	["JP", 702],
	["B", [12.7, 24.638], 270.0],
	"Jumper:SolderJumper-2_P1.3mm_Open_TrianglePad1.0x1.5mm"];

COMPONENT_JP703 = [
	["JP", 703],
	["B", [10.16, 24.638], 270.0],
	"Jumper:SolderJumper-2_P1.3mm_Open_TrianglePad1.0x1.5mm"];

COMPONENT_JP704 = [
	["JP", 704],
	["B", [7.62, 24.638], 270.0],
	"Jumper:SolderJumper-2_P1.3mm_Open_TrianglePad1.0x1.5mm"];

COMPONENT_JP705 = [
	["JP", 705],
	["B", [5.08, 24.638], 270.0],
	"Jumper:SolderJumper-2_P1.3mm_Open_TrianglePad1.0x1.5mm"];

COMPONENT_Q501 = [
	["Q", 501],
	["B", [-17.78, -2.286], 180.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q502 = [
	["Q", 502],
	["B", [-7.366, -2.286], 0.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q503 = [
	["Q", 503],
	["B", [7.366, -2.286], 180.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q504 = [
	["Q", 504],
	["B", [17.78, -2.286], 0.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q505 = [
	["Q", 505],
	["B", [-17.78, 1.397], 180.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q506 = [
	["Q", 506],
	["B", [-7.366, 1.397], 0.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q507 = [
	["Q", 507],
	["B", [7.366, 1.397], 180.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q508 = [
	["Q", 508],
	["B", [17.78, 1.397], 0.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q509 = [
	["Q", 509],
	["B", [-17.78, 5.08], 180.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q510 = [
	["Q", 510],
	["B", [-7.366, 5.08], 0.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q511 = [
	["Q", 511],
	["B", [7.366, 5.08], 180.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q512 = [
	["Q", 512],
	["B", [17.78, 5.08], 0.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q513 = [
	["Q", 513],
	["B", [-17.78, 8.763], 180.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q514 = [
	["Q", 514],
	["B", [-7.366, 8.763], 0.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q515 = [
	["Q", 515],
	["B", [7.366, 8.763], 180.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_Q516 = [
	["Q", 516],
	["B", [17.78, 8.763], 0.0],
	"Package_TO_SOT_SMD:SOT-23_Handsoldering"];

COMPONENT_R301 = [
	["R", 301],
	["B", [8.636, -13.335], 0.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R302 = [
	["R", 302],
	["B", [1.27, -7.62], 270.0],
	"Resistor_SMD:R_2512_6332Metric_Pad1.40x3.35mm_HandSolder"];

COMPONENT_R303 = [
	["R", 303],
	["B", [8.636, -9.144], 0.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R304 = [
	["R", 304],
	["B", [10.287, -18.542], 180.0],
	"Resistor_SMD:R_1210_3225Metric_Pad1.30x2.65mm_HandSolder"];

COMPONENT_R401 = [
	["R", 401],
	["B", [-26.924, -19.177], 0.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R402 = [
	["R", 402],
	["B", [-26.924, -21.209], 0.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R601 = [
	["R", 601],
	["B", [-4.064, -26.924], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R602 = [
	["R", 602],
	["B", [-1.143, -26.924], 90.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R603 = [
	["R", 603],
	["B", [1.778, -26.924], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R701 = [
	["R", 701],
	["B", [-5.588, 26.797], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R702 = [
	["R", 702],
	["B", [-29.21, 26.162], 90.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R703 = [
	["R", 703],
	["B", [-20.447, 32.512], 90.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R704 = [
	["R", 704],
	["B", [21.62, 15.75], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R705 = [
	["R", 705],
	["B", [-8.255, 26.797], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R706 = [
	["R", 706],
	["B", [19.07, 15.748], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R707 = [
	["R", 707],
	["B", [15.24, 32.512], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R708 = [
	["R", 708],
	["B", [10.16, 32.512], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R709 = [
	["R", 709],
	["B", [5.08, 32.512], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R710 = [
	["R", 710],
	["B", [0.0, 32.512], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R711 = [
	["R", 711],
	["B", [-22.987, 26.289], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R801 = [
	["R", 801],
	["B", [-3.81, -14.5034], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R802 = [
	["R", 802],
	["B", [-6.35, -14.478], 90.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R803 = [
	["R", 803],
	["B", [-1.143, -14.5034], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R804 = [
	["R", 804],
	["B", [1.524, -14.478], 270.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R805 = [
	["R", 805],
	["B", [-7.112, -21.082], 0.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R806 = [
	["R", 806],
	["B", [-7.096, -18.288], 0.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_R807 = [
	["R", 807],
	["B", [-2.921, -6.874], 90.0],
	"Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder"];

COMPONENT_SW701 = [
	["SW", 701],
	["F", [-4.37, 30.77], 180.0],
	"Button_Switch_THT:SW_PUSH_6mm_H4.3mm"];

COMPONENT_SW702 = [
	["SW", 702],
	["F", [-9.525, 17.907], 90.0],
	"Button_Switch_SMD:SW_SPST_CK_RS282G05A3"];

COMPONENT_SW703 = [
	["SW", 703],
	["F", [5.08, 20.701], 90.0],
	"Button_Switch_THT:SW_DIP_SPSTx05_Slide_6.7x14.26mm_W7.62mm_P2.54mm_LowProfile"];

COMPONENT_TP301 = [
	["TP", 301],
	["B", [-6.35, -5.08], 180.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP302 = [
	["TP", 302],
	["B", [-6.35, -7.62], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP303 = [
	["TP", 303],
	["B", [24.13, -12.7], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP304 = [
	["TP", 304],
	["B", [24.13, -15.24], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP401 = [
	["TP", 401],
	["B", [-13.97, -27.94], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP402 = [
	["TP", 402],
	["B", [-19.05, -27.94], 90.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP403 = [
	["TP", 403],
	["B", [-16.51, -27.94], 90.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP404 = [
	["TP", 404],
	["B", [-26.67, -12.7], 90.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP405 = [
	["TP", 405],
	["B", [-29.21, -12.7], 90.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP406 = [
	["TP", 406],
	["B", [-11.43, -17.78], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP407 = [
	["TP", 407],
	["B", [-11.43, -20.32], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP408 = [
	["TP", 408],
	["B", [-11.43, -22.86], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP409 = [
	["TP", 409],
	["B", [-11.43, -25.4], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP501 = [
	["TP", 501],
	["B", [-24.13, 22.86], 180.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP502 = [
	["TP", 502],
	["B", [-13.97, 10.16], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP503 = [
	["TP", 503],
	["B", [-21.59, 7.62], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP504 = [
	["TP", 504],
	["B", [-21.59, 10.16], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP601 = [
	["TP", 601],
	["B", [-3.81, -33.02], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP602 = [
	["TP", 602],
	["B", [3.81, -33.02], 180.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP701 = [
	["TP", 701],
	["B", [-3.81, 22.86], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP702 = [
	["TP", 702],
	["B", [-6.35, 22.86], 90.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP703 = [
	["TP", 703],
	["B", [1.27, -22.86], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP704 = [
	["TP", 704],
	["B", [-24.13, 17.78], 180.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP705 = [
	["TP", 705],
	["B", [-24.13, 15.24], 180.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP706 = [
	["TP", 706],
	["B", [-8.89, 33.02], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP707 = [
	["TP", 707],
	["B", [3.81, -22.86], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP708 = [
	["TP", 708],
	["B", [24.13, 12.7], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP709 = [
	["TP", 709],
	["B", [21.59, 12.7], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP710 = [
	["TP", 710],
	["B", [-24.13, 20.32], 180.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP711 = [
	["TP", 711],
	["B", [19.05, 12.7], 180.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP712 = [
	["TP", 712],
	["B", [-24.13, 12.7], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_TP801 = [
	["TP", 801],
	["B", [-8.89, -15.24], 0.0],
	"RGBW-Bar:TestPoint_Pad_D1.0mm"];

COMPONENT_U301 = [
	["U", 301],
	["B", [17.526, -10.922], 180.0],
	"Package_SO:SOIC-8_3.9x4.9mm_P1.27mm"];

COMPONENT_U302 = [
	["U", 302],
	["B", [17.526, -20.32], 90.0],
	"Package_TO_SOT_SMD:SOT-223-3_TabPin2"];

COMPONENT_U401 = [
	["U", 401],
	["B", [-18.542, -20.828], 180.0],
	"Package_SO:SOIC-16W_7.5x10.3mm_P1.27mm"];

COMPONENT_U402 = [
	["U", 402],
	["F", [-16.002, -11.176], 180.0],
	"RGBW-Bar:B0505S-1W"];

COMPONENT_U501 = [
	["U", 501],
	["B", [7.366, 14.478], 270.0],
	"Package_SO:TSSOP-28_4.4x9.7mm_P0.65mm"];

COMPONENT_U601 = [
	["U", 601],
	["B", [-2.4765, -21.082], 270.0],
	"Package_SO:SOIC-8_3.9x4.9mm_P1.27mm"];

COMPONENT_U701 = [
	["U", 701],
	["B", [-17.018, 19.05], 270.0],
	"Package_QFP:TQFP-32_7x7mm_P0.8mm"];

COMPONENT_U901 = [
	["U", 901],
	["B", [25.166, 24.7], 270.0],
	"Package_SO:SOIC-8_3.9x4.9mm_P1.27mm"];

COMPONENT_Y701 = [
	["Y", 701],
	["F", [-11.176, 25.654], 180.0],
	"Crystal:Crystal_HC49-U_Vertical"];

COMPONENT_Y901 = [
	["Y", 901],
	["B", [21.082, 29.337], 180.0],
	"Crystal:Crystal_C38-LF_D3.0mm_L8.0mm_Horizontal_1EP_style1"];

ALL_COMPONENTS = [
  COMPONENT_BT901, COMPONENT_C301, COMPONENT_C302, COMPONENT_C303, COMPONENT_C304, 
  COMPONENT_C305, COMPONENT_C306, COMPONENT_C307, COMPONENT_C308, COMPONENT_C401, 
  COMPONENT_C402, COMPONENT_C403, COMPONENT_C404, COMPONENT_C501, COMPONENT_C502, 
  COMPONENT_C503, COMPONENT_C504, COMPONENT_C505, COMPONENT_C601, COMPONENT_C701, 
  COMPONENT_C702, COMPONENT_C703, COMPONENT_C704, COMPONENT_C705, COMPONENT_C706, 
  COMPONENT_C801, COMPONENT_C802, COMPONENT_C803, COMPONENT_C901, COMPONENT_D301, 
  COMPONENT_D302, COMPONENT_D401, COMPONENT_D701, COMPONENT_D702, COMPONENT_D703, 
  COMPONENT_D704, COMPONENT_D705, COMPONENT_D706, COMPONENT_D801, COMPONENT_F301, 
  COMPONENT_H201, COMPONENT_H202, COMPONENT_H203, COMPONENT_H204, COMPONENT_J301, 
  COMPONENT_J401, COMPONENT_J501, COMPONENT_J502, COMPONENT_J503, COMPONENT_J601, 
  COMPONENT_J701, COMPONENT_JP601, COMPONENT_JP701, COMPONENT_JP702, COMPONENT_JP703, 
  COMPONENT_JP704, COMPONENT_JP705, COMPONENT_Q501, COMPONENT_Q502, COMPONENT_Q503, 
  COMPONENT_Q504, COMPONENT_Q505, COMPONENT_Q506, COMPONENT_Q507, COMPONENT_Q508, 
  COMPONENT_Q509, COMPONENT_Q510, COMPONENT_Q511, COMPONENT_Q512, COMPONENT_Q513, 
  COMPONENT_Q514, COMPONENT_Q515, COMPONENT_Q516, COMPONENT_R301, COMPONENT_R302, 
  COMPONENT_R303, COMPONENT_R304, COMPONENT_R401, COMPONENT_R402, COMPONENT_R601, 
  COMPONENT_R602, COMPONENT_R603, COMPONENT_R701, COMPONENT_R702, COMPONENT_R703, 
  COMPONENT_R704, COMPONENT_R705, COMPONENT_R706, COMPONENT_R707, COMPONENT_R708, 
  COMPONENT_R709, COMPONENT_R710, COMPONENT_R711, COMPONENT_R801, COMPONENT_R802, 
  COMPONENT_R803, COMPONENT_R804, COMPONENT_R805, COMPONENT_R806, COMPONENT_R807, 
  COMPONENT_SW701, COMPONENT_SW702, COMPONENT_SW703, COMPONENT_TP301, COMPONENT_TP302, 
  COMPONENT_TP303, COMPONENT_TP304, COMPONENT_TP401, COMPONENT_TP402, COMPONENT_TP403, 
  COMPONENT_TP404, COMPONENT_TP405, COMPONENT_TP406, COMPONENT_TP407, COMPONENT_TP408, 
  COMPONENT_TP409, COMPONENT_TP501, COMPONENT_TP502, COMPONENT_TP503, COMPONENT_TP504, 
  COMPONENT_TP601, COMPONENT_TP602, COMPONENT_TP701, COMPONENT_TP702, COMPONENT_TP703, 
  COMPONENT_TP704, COMPONENT_TP705, COMPONENT_TP706, COMPONENT_TP707, COMPONENT_TP708, 
  COMPONENT_TP709, COMPONENT_TP710, COMPONENT_TP711, COMPONENT_TP712, COMPONENT_TP801, 
  COMPONENT_U301, COMPONENT_U302, COMPONENT_U401, COMPONENT_U402, COMPONENT_U501, 
  COMPONENT_U601, COMPONENT_U701, COMPONENT_U901, COMPONENT_Y701, COMPONENT_Y901];