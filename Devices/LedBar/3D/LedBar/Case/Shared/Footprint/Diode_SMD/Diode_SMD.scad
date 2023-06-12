use     <../../../../../../../Shared/3D/Utils/Units.scad>

use <D_SMB_Handsoldering.scad>

module Diode_SMD(layer, footprint) {
    if(footprint == "D_SMB_Handsoldering") {
        D_SMB_Handsoldering(layer = layer);
    }
}