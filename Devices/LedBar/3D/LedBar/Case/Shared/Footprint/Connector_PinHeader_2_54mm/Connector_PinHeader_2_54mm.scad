use <PinHeader_1x_P2_54mm_Horizontal.scad>

module Connector_PinHeader_2_54mm(layer, footprint) {
    if(footprint == "PinHeader_1x05_P2.54mm_Horizontal") {
        PinHeader_1x_P2_54mm_Horizontal(layer = layer, pins = 5);
    }
}