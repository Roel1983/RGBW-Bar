use     <../../../../../../../Shared/3D/Utils/Units.scad>

use <2EDGRC_5_08_2P.scad>
use <15EDGRC_3_5.scad>
use <B0505S_1W.scad>
use <Fuseholder_Cylinder_5x20mm_BLX_A_Horizontal.scad>
use <ISP_single_row.scad>
use <MountingHole_4_3mm_M4_modified1.scad>
use <Perpendicular_pcb_1mm_female_2x6.scad>
use <PinHeader_2x06_P200mm_PCB_edge.scad>
use <TestPoint_Pad.scad>

module RGBW_Bar(layer, footprint) {
    if(footprint == "perpendicular_pcb_1mm_female_2x6") {
        Perpendicular_pcb_1mm_female_2x6(layer);
    } else if(footprint == "MountingHole_4.3mm_M4_modified1") {
        MountingHole_4_3mm_M4_modified1(layer = layer);
    } else if(footprint == "Fuseholder_Cylinder-5x20mm_BLX_A_Horizontal") {
        Fuseholder_Cylinder_5x20mm_BLX_A_Horizontal(layer = layer);
    } else if(footprint == "B0505S-1W") {
        B0505S_1W(layer = layer);
    } else if(footprint == "ISP_P1.27mm_single_row") {
        ISP_single_row(layer = layer, P = mm(1.27));
    } else if(footprint == "TestPoint_Pad_D1.0mm") {
        TestPoint_Pad(layer = layer, D = mm(1.0));
    } else if(footprint == "15EDGRC-3.5-2P") {
        15EDGRC_3_5(layer = layer, pins = 2);
    } else if(footprint == "15EDGRC-3.5-3P") {
        15EDGRC_3_5(layer = layer, pins = 3);
    } else if(footprint == "2EDGRC-5.08-2P") {
        2EDGRC_5_08_2P(layer = layer, pins = 2);
    } else if(footprint == "PinHeader_2x06_P200mm_PCB_edge") {
        PinHeader_2x06_P200mm_PCB_edge(layer = layer);
    }
}