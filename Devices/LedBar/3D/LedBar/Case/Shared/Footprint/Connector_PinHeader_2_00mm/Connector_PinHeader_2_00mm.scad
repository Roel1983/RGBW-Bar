use <PinHeader_2x6_P2_00mm_Horizontal.scad>
use <PinHeader_2x6_P2_00mm_Vertical.scad>
use <PinHeader_1x6_P2_00mm_Vertical.scad>

module Connector_PinHeader_2_00mm(layer, footprint) {
    if(footprint == "PinHeader_1x06_P2.00mm_Horizontal") {
        PinHeader_2x6_P2_00mm_Horizontal(layer = layer, pins = 6);
    } else if(footprint == "PinHeader_2x06_P2.00mm_Vertical") {
        PinHeader_2x6_P2_00mm_Vertical(layer = layer);
    } else if(footprint == "PinHeader_1x06_P2.00mm_Vertical") {
        PinHeader_1x6_P2_00mm_Vertical(layer = layer);
    }
}
