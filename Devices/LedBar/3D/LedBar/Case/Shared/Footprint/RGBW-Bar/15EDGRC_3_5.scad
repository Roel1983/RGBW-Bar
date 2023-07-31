include <../../../../Config.inc>

include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

$fn = 32;

15EDGRC_3_5(layer = "3D", pins = 3);
difference() {
    15EDGRC_3_5(layer = "Case.Top.Add.Outer.NoBevel", pins = 3);
    #15EDGRC_3_5(layer = "Case.Remove", pins = 3);
    15EDGRC_3_5(layer = "Case.Top.Remove", pins = 3);
    15EDGRC_3_5(layer = "Case.Top.Remove.Inner.NoBevel", pins = 3);
}

module 15EDGRC_3_5(layer = "3D", pins) {
    if (layer == "3D") {
        Layer3D();
    } else if (layer == "Case.Remove") {
        LayerCaseRemove();
    } else if (layer == "Case.Top.Remove") {
        CaseTopRemove();
    } else if (layer == "Case.Top.Remove.Inner.NoBevel") {
        CaseTopRemoveInnerNoBevel();
    } else if (layer == "Smd.Back.1mm") {
        LayerSmdBack1mm();
    } else if (layer == "Case.Top.Add.Outer.NoBevel") {
        LayerCaseTopAddOuterNoBevel();
    }
    
    pitch = mm(3.5);
    a     = (pins - 1) * pitch;
    b     = mm(4.4);
    w     = a + b;
    d     = mm(9.2);
    h     = mm(7.0);
    front_to_pin = mm(8.0);
    
    tolerance_xy = mm(.1);
    wall_xy      = nozzle(3);
    wall_z       = layer(10);
    BIAS = .1;
    
    module Layer3D() {
        translate([-(w-a)/2, -(d-front_to_pin)]) {
            cube([w,d,h]);
        }
    }
    
    module LayerSmdBack1mm() {
        hull() {
            circle(d = PAD_SIZE_15EDGRC_3_5);
            translate([(pins - 1) * pitch, 0]) circle(d = PAD_SIZE_15EDGRC_3_5);
        }
    }
    
    module LayerCaseRemove() {
        pin_length = mm(3.0);
        LinearExtrude(
            z_from = -pin_length,
            z_to   = mm(.5)
        ) {
           LayerSmdBack1mm(); 
        }
    }
    
    module CaseTopRemoveInnerNoBevel() {
        tolerance_xy = mm(.1);
        tolerance_z  = layer(3);
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
    
    module CaseTopRemove() {
        tolerance_z  = layer(.5);
        
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
        tolerance_xy = mm(.1);
        tolerance_z  = layer(.5);
        wall_xy      = nozzle(3);
        wall_z       = layer(10);
        BIAS = .1;
                
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