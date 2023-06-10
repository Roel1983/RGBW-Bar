include <../../../../Config.inc>

include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

$fn = 32;

2EDGRC_5_08_2P(layer = "3D");
%2EDGRC_5_08_2P(layer = "Case.Remove");
%2EDGRC_5_08_2P(layer = "Case.Top.Remove");

#2EDGRC_5_08_2P(layer = "Case.Top.Add.Outer.NoBevel");

module 2EDGRC_5_08_2P(layer, pins = 3) {
    if (layer == "3D") {
        Layer3D();
    } else if (layer == "Case.Remove") {
        LayerCaseRemove();
    } else if (layer == "Case.Top.Remove") {
        LayerCaseTopRemove();
    } else if (layer == "Case.Top.Add.Outer.NoBevel") {
        LayerCaseTopAddOuterNoBevel();
    }
    
    pitch = inch(0.20);
    a     = (pins - 1) * pitch;
    b     = mm(5.2);
    w     = a + b;
    d     = mm(12.2);
    h     = mm(7.8);
    front_to_pin = mm(10.25);
    
    module Layer3D() {
        translate([-(w-a)/2, -(d-front_to_pin)]) {
            cube([w,d,h]);
        }
    }
    
    module LayerCaseRemove() {
        pin_length = mm(4.25);
        LinearExtrude(
            z_from = -pin_length
        ) {
            hull() {
                circle(d = PAD_SIZE_15EDGRC_3_5);
                translate([(pins - 1) * pitch, 0]) circle(d = PAD_SIZE_15EDGRC_3_5);
            }
        }
    }
    
    module LayerCaseTopRemove() {
        tolerance_xy = mm(.1);
        tolerance_z  = layer(.5);
        BIAS = .1;
        
        translate([
            -(w-a)/2 - tolerance_xy,
            -(d-front_to_pin) - tolerance_xy,
            - BIAS
        ]) {
            cube([
                w + 2 * tolerance_xy,
                d + tolerance_xy,
                h + tolerance_z + BIAS
            ]);
        }
    }
    
    module LayerCaseTopAddOuterNoBevel() {
        tolerance_xy = mm(.1);
        tolerance_z  = layer(1.5);
        wall_xy      = nozzle(3);
        wall_z       = layer(10);
        BIAS = .1;
                
        difference() {
            translate([
                -(w-a)/2 - tolerance_xy - wall_xy,
                -(d-front_to_pin) - tolerance_xy - wall_xy
            ]) {
                cube([
                    w + 2 * (tolerance_xy + wall_xy),
                    d + tolerance_xy + wall_xy,
                    h + tolerance_z + wall_z
                ]);
            }
            translate([
                -(w-a)/2 - tolerance_xy,
                -(d-front_to_pin) - tolerance_xy,
                - BIAS
            ]) {
                cube([
                    w + 2 * tolerance_xy,
                    d + tolerance_xy + BIAS,
                    h + tolerance_z + BIAS
                ]);
            }
        }
    }
}
