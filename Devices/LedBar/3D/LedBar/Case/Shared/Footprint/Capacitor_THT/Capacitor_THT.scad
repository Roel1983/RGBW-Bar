use <../../../../../../../Shared/3D/Utils/Units.scad>
use <CP_Radial.scad>

module Capacitor_THT(layer, footprint) {
    if(footprint == "CP_Radial_D10.0mm_P5.00mm") {
        CP_Radial(
            layer = layer,
            D = mm(10.0),
            P = mm(5.00),
            H = mm(20.1)
        );
    }
}
