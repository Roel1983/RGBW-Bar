use     <../../../../../../../Shared/3D/Utils/Units.scad>

use <LED_D3_0mm.scad>

module LED_THT (layer, footprint) {
    if(footprint == "LED_D3.0mm") {
        LED_D3_0mm(layer = layer, h = mm(3));
    }
}
