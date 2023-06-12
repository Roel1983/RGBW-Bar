include <../../../../../../../Shared/3D/Utils/Constants.inc>
include <../../../../Config.inc>

use <../Connector_PinHeader_2_00mm/PinHeader_2x6_P2_00mm_Horizontal.scad>

$fn = 32;
$pcb_thickness = mm(1.6);

PinHeader_2x06_P200mm_PCB_edge(layer = "3D");

module PinHeader_2x06_P200mm_PCB_edge(layer, pins = 3) {
    pitch = mm(2);
    translate([0,0, -pitch / 2 - $pcb_thickness / 2])
    rotate(-90, VEC_Y) {
        PinHeader_2x6_P2_00mm_Horizontal(layer);
    }
}
