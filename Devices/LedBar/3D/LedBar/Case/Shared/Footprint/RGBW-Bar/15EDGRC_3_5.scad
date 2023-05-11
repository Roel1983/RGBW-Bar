include <../../../../Config.inc>

include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

$fn = 32;

15EDGRC_3_5(layer = "3D", pins = 3);
%15EDGRC_3_5(layer = "Case.Remove", pins = 3);

module 15EDGRC_3_5(layer = "3D", pins) {
    if (layer == "3D") {
        Layer3D();
    } else if (layer == "Case.Remove") {
        LayerCaseRemove();
    }
    
    pitch = mm(3.5);
    
    module Layer3D() {
        a     = (pins - 1) * pitch;
        b     = mm(4.4);
        w     = a + b;
        d     = mm(9.2);
        h     = mm(7.25);
        front_to_pin = mm(8.0);
        
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