use <PinHeader_2x6_P2_00mm_Horizontal.scad>

module Connector_PinHeader_2_00mm(layer, footprint) {
    if(footprint == "PinHeader_1x06_P2.00mm_Horizontal") {
        PinHeader_2x6_P2_00mm_Horizontal(layer = layer, pins = 6);
    }
}