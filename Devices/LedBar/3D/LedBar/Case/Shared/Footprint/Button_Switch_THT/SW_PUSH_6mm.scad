include <../../../../Config.inc>

include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

$fn = 16;

SW_PUSH_6mm(layer = "3D", H=mm(4.3));
%difference() {
    union() {
        SW_PUSH_6mm(layer = "Case.Top.Add.Inner", H=mm(4.3));
        SW_PUSH_6mm(layer = "Case.Bottom.Add.Inner", H=mm(4.3));
    }
    SW_PUSH_6mm(layer = "Case.Remove", H=mm(4.3));
}

SW_PUSH_6mm(layer = "3D", H=mm(4.3));

module SW_PUSH_6mm(layer, H=mm(4.3)) {
    if(layer == "3D") {
        Layer3D();
    } else if (layer == "Case.Remove") {
        LayerCaseRemove();
    } else if (layer == "Case.Top.Add.Inner") {
        LayerCaseTopAddInner();
    } else if (layer == "Case.Bottom.Add.Inner") {
        LayerCaseBottomAddInner();
    }
    
    BIAS  = 0.1;
    size  = mm(6.0);
    pitch = mm([6.5, 4.5]);
    pin_size = mm([.7, 1.0]);
    h1    = mm(3.5);
    d1    = mm(3.5);
    d2    = mm(1.3);
    l2    = mm(4.0);
    h2    = mm(0.5);
    pad_size = mm(2);
    
    module Layer3D() {
        translate([pitch[0]/2, -pitch[1]/2]) {
            linear_extrude(h1) hull() {
                $fn=16;
                mirror_copy(VEC_X) mirror_copy(VEC_Y) {
                    r = mm(.5);
                    translate(mm([(size-r)/2 ,(size-r)/2])) circle(r=r);
                }
            }
            mirror_copy(VEC_X) mirror_copy(VEC_Y) {
                $fn=16;
                translate([l2/2,l2/2,h1]) {
                    cylinder(d=d2,h=h2*2, center=true);
                }
            }
            translate([0,0,h1-BIAS]) {
                cylinder(d=d1, h=H-h1+BIAS);
            }
            mirror_copy(VEC_Y) {
                translate([0,pitch[1]/2, mm(1)/2]) {
                    cube([pitch[0]+2*pin_size[0], pin_size[0], pin_size[1]], center=true);
                }
            }
        }
    }
    module LayerCaseRemove() {
        translate([pitch[0]/2, -pitch[1]/2]) {
            Top();
            Bottom();
        }
        
        module Bottom() {
            pin_length = mm(4);
            LinearExtrude(z_from = -pin_length, z_to=BIAS, convexity = 2) {
                mirror_copy(VEC_X) mirror_copy(VEC_Y) {
                    translate([pitch[0]/2, pitch[1]/2]) {
                        circle(d=pad_size + CASE_BUTTON_WALL_CLEARANCE);
                    }
                }
            }
        }
        
        module Top() {
            intersection() {
                LinearExtrude(z_from=-BIAS, z_to=h1+h2 + layer(2 + 4)) {
                    hull() mirror_copy(VEC_X) mirror_copy(VEC_Y) {
                        translate([pitch[0]/2, pitch[1]/2]) circle(d=pad_size + 2 * CASE_BUTTON_WALL_CLEARANCE);
                    }
                }
                union() {
                    Box(
                        x_size = pitch[0] + pad_size + CASE_BUTTON_WALL_CLEARANCE + BIAS,
                        y_size = pitch[1] + pad_size + CASE_BUTTON_WALL_CLEARANCE + BIAS,
                        z_from = -BIAS,
                        z_to   = h1+h2 + layer(2)
                    );
                    Box(
                        x_size = d1 + CASE_BUTTON_WALL_CLEARANCE,
                        y_size = pitch[1] + pad_size + CASE_BUTTON_WALL_CLEARANCE + BIAS,
                        z_to   = h1+h2 + layer(4)
                    );
                }
            }
            hull() {
                Box(
                    x_size = d1 + CASE_BUTTON_WALL_CLEARANCE,
                    y_size = d1 + CASE_BUTTON_WALL_CLEARANCE,
                    z_to   = h1+h2 + layer(6)
                );
                cylinder(d = d1 + CASE_BUTTON_WALL_CLEARANCE, h1+h2 + layer(12));
            }
            cylinder(d = d1 + CASE_BUTTON_WALL_CLEARANCE, h = H + mm(5) + BIAS);
        }
    }
    
    module LayerCaseTopAddInner() {
        wall = nozzle(3);
        
        translate([pitch[0]/2, -pitch[1]/2]) {
            LinearExtrude(z_to = H + mm(5)) {
                hull() mirror_copy(VEC_X) mirror_copy(VEC_Y) {
                    translate([pitch[0]/2, pitch[1]/2]) {
                        circle(d=pad_size + 2 * CASE_BUTTON_WALL_CLEARANCE + wall);
                    }
                }
            }
        }
    }
    
    module LayerCaseBottomAddInner() {
        wall = nozzle(2);
        
        translate([pitch[0]/2, -pitch[1]/2]) {
            LinearExtrude(
                z_from = -(CASE_PCB_WALL_CLEARANCE_BOTTOM + PCB_THICKNESS_MAINBOARD + BIAS),
                z_to   = -PCB_THICKNESS_MAINBOARD
            ) {
                hull() mirror_copy(VEC_X) mirror_copy(VEC_Y) {
                    translate([pitch[0]/2, pitch[1]/2]) {
                        circle(d=pad_size + CASE_BUTTON_WALL_CLEARANCE + 2 * wall);
                    }
                }
            }
        }
    }
}