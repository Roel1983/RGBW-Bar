include <../../../../Config.inc>

include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

$fn = 32;

2EDGRC_5_08_2P(layer = "3D");
%2EDGRC_5_08_2P(layer = "Case.Remove");

module 2EDGRC_5_08_2P(layer, pins = 3) {
    if (layer == "3D") {
        Layer3D();
    } else if (layer == "Case.Remove") {
        LayerCaseRemove();
    }
    
    pitch = inch(0.20);
    
    module Layer3D() {
        a     = (pins - 1) * pitch;
        b     = mm(5.2);
        w     = a + b;
        d     = mm(12.2);
        h     = mm(7.8);
        front_to_pin = mm(10.25);
        echo(w);
        
        translate([-(w-a)/2, -(d-front_to_pin)]) {
            cube([w,d,h]);
        }
    }
    
    module LayerCaseRemove() {
        pin_length = mm(3.0); // TODO measure
        LinearExtrude(
            z_from = -pin_length
        ) {
            hull() {
                circle(d = PAD_SIZE_15EDGRC_3_5);
                translate([(pins - 1) * pitch, 0]) circle(d = PAD_SIZE_15EDGRC_3_5);
            }
        }
    }
}
