use     <../../../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>
include <../../../../Config.inc>

$fn = 16;

PinHeader_1x_P2_54mm_Horizontal(layer = "3D", pins = 5);
%difference() {
    union() {
        PinHeader_1x_P2_54mm_Horizontal(layer = "Case.Bottom.Add.Inner", pins = 5);
        PinHeader_1x_P2_54mm_Horizontal(layer = "Case.Top.Add.Inner", pins = 5);
    }
    #PinHeader_1x_P2_54mm_Horizontal(layer = "Case.Remove", pins = 5);
}

module PinHeader_1x_P2_54mm_Horizontal(layer, pins = 5) {
    if (layer == "3D") {
        Layer3D();
    } else if (layer == "Case.Remove") {
        LayerCaseRemove();
    } else if (layer == "Case.Bottom.Add.Inner") {
        LayerCaseBottomAddInner();
    } else if (layer == "Case.Top.Add.Inner") {
        LayerCaseTopAddInner();
    }
    
    pitch = mill(100);
    a = mm(4.0);
    b = mm(3.75);
    d = mm(7);
    r = mm(.75);
    t = mm(0.64);
    hole_clearance = 0.2;
    
    module Layer3D() {
        Box(
            x_size = pitch,
            y_to   = pitch / 2,
            y_size = pitch * pins,
            z_to   = pitch
        );
        for(pin=[0:pins-1]) {
            translate([0, pin * -pitch]) {
                Pin();
            }
        }
        
        module Pin() {
            hull() {
                Box(
                    x_size = t,
                    y_size = t,
                    z_from = -a + t / 2,
                    z_to   = b - r
                    
                );
                Box(
                    x_size = t / 3,
                    y_size = t / 3,
                    z_from = -a
                );
            }
            translate([0, 0, b]) hull() {
                Box(
                    x_from = r,
                    x_to   = d - t / 2,
                    y_size = t,
                    z_size = t
                );
                Box(
                    x_from = r,
                    x_to   = d,
                    y_size = t / 3,
                    z_size = t / 3
                );
            }
            translate([r, 0, b - r]) {
                rotate(-90, VEC_X) {
                    rotate_extrude(angle = 90) {
                        translate([-r, 0]) square(size = t, center = true);
                    }
                }
            }
        }
    }
    
    clearance = mm(.1);
    pin_size  = mm(1.7) + 2 * clearance;
    module PinsHole2D() {
        
        hull() {
            square(pin_size, center = true);
            translate([0, -(pins - 1) * pitch]) circle(d = pin_size);
        }
    }
    
    module LayerCaseRemove() {
        Bottom();
        Top();
        
        module Bottom() {
            clearance = mm(.2);
            BIAS      = 0.1;
            LinearExtrude(
                z_to   = BIAS,
                z_from = -a - clearance
            ) {
                PinsHole2D();
            }
        }
        
        module Top() {
            translate([0, 0, b]) {
                Box(
                    x_to   = d + cm(1),
                    y_to   = pitch / 2 + hole_clearance,
                    y_size = pitch * pins + 2 * hole_clearance,
                    z_size = pitch + 2 * hole_clearance
                );
            }
        }
    }
    
    module LayerCaseBottomAddInner() {
        wall = nozzle(4);
        BIAS = 0.1;
        LinearExtrude(
            z_from = -CASE_PCB_Z_FRONT - BIAS
        ) {
            hull() {
                offset(wall )PinsHole2D();
                
                l = cm(1);
                translate([
                    l,
                    -(pins - 1) * pitch / 2
                ]) {
                    square([
                        pin_size + 2 * wall,
                        (pins - 1) * pitch + l
                    ], center = true);
                }
            }
        }
    }
    
    module LayerCaseTopAddInner() {
        clearance = mm(0.5);
        translate([
            0,
            -(pins - 1) * pitch / 2
        ]) {
            difference() {
                wall = nozzle(2);
                roof = layer(5);
                roof_clearance = hole_clearance + layer(3);
                BIAS = 0.1;
                
                Box(
                    y_size = pitch * pins + 2 * clearance + 2 * wall,
                    x_from = -(pitch / 2 + clearance) - wall,
                    x_to   = d + cm(.5) - BIAS,
                    z_to   = b + pitch / 2 + roof_clearance + roof
                );
                Box(
                    y_size = pitch * pins + 2 * clearance,
                    x_from = -(pitch / 2 + clearance),
                    x_to   = d + cm(.5),
                    z_from = -BIAS,
                    z_to   = b + pitch / 2 + roof_clearance
                );
            }
        }
    }
}