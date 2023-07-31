include <../../../../Config.inc>

include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

$fn = 32;

2EDGRC_5_08_2P(layer = "3D", pins = 3);
difference() {
    2EDGRC_5_08_2P(layer = "Case.Top.Add.Outer.NoBevel", pins = 3);
    #2EDGRC_5_08_2P(layer = "Case.Remove", pins = 3);
    2EDGRC_5_08_2P(layer = "Case.Top.Remove", pins = 3);
    2EDGRC_5_08_2P(layer = "Case.Top.Remove.Inner.NoBevel", pins = 3);
}

module 2EDGRC_5_08_2P(layer, pins = 3) {
    if (layer == "3D") {
        Layer3D();
    } else if (layer == "Case.Remove") {
        LayerCaseRemove();
    } else if (layer == "Case.Top.Remove") {
        LayerCaseTopRemove();
    } else if (layer == "Case.Top.Remove.Inner.NoBevel") {
        CaseTopRemoveInnerNoBevel();
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
    
    tolerance_xy = mm(.1);
    tolerance_z  = mm(.1) + layer(1);
    
    wall_xy      = nozzle(3);
    wall_z       = layer(10);
    BIAS = .1;
    
    module Layer3D() {
        translate([-(w-a)/2, -(d-front_to_pin)]) {
            cube([w,d,h]);
        }
    }
    
    module LayerCaseRemove() {
        pin_length = mm(4.25);
        LinearExtrude(
            z_from = -pin_length,
            z_to   = mm(.5)
        ) {
            hull() {
                circle(d = PAD_SIZE_15EDGRC_3_5);
                translate([(pins - 1) * pitch, 0]) circle(d = PAD_SIZE_15EDGRC_3_5);
            }
        }
    }
    
    module CaseTopRemoveInnerNoBevel() {
        tolerance_xy = mm(.1);
        tolerance_z  = mm(.1) + layer(3);
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
    
    module LayerCaseTopRemove() {
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
    
    module LayerCaseTopAddOuterNoBevel() {
        
                
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
    }
}
