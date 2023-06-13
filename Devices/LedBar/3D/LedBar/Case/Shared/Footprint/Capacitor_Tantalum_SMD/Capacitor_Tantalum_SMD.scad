use     <../../../../../../../Shared/3D/Utils/Units.scad>

use <CP_EIA_6032_28_Kemet_C_Pad2_25x2_35mm_HandSolder.scad>

module Capacitor_Tantalum_SMD(layer, footprint) {
    if(footprint == "CP_EIA-6032-28_Kemet-C_Pad2.25x2.35mm_HandSolder") {
        CP_EIA_6032_28_Kemet_C_Pad2_25x2_35mm_HandSolder(layer = layer);    
    }
}