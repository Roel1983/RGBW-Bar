use     <../../../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

include <../../../../Config.inc>

$fn = 16;

LED_D3_0mm(layer = "3D", h = 1.0);
%difference() {
    LED_D3_0mm(layer = "Case.Top.Add.Inner", h = 1.0);
    LED_D3_0mm(layer = "Case.Remove", h = 1.0);
}

module LED_D3_0mm(layer, h) {
    if(layer == "3D") {
        Layer3D();
    } else if (layer == "Case.Remove") {
        LayerCaseRemove();
    } else if (layer == "Case.Top.Add.Inner") {
        LayerCaseTopAddInner();
    }
    
    d1 = mm(3.0);
    d2 = mm(3.5);
    h1 = mm(5.1);
    t  = mm(1.0);
    pitch = mill(100);
    cone_size = mm(5);
        
    module Layer3D() {
        h_cylinder = h1-d1/2;
        BIAS = 0.1;
        color ("red") {
            translate([pitch/2,0]) {
                translate([0, 0, h]) Head();
            }
        }
        Pin();
        translate([pitch, 0 ]) Pin();
        
        module Pin() {
            color("silver") {
                Box(
                    x_size = mm(0.5),
                    y_size = mm(0.5),
                    z_from = mm(-3),
                    z_to = h
                );
            }
                
        }
        
        module Head() {
            render() {
                linear_extrude(t)intersection() {
                    circle(d=d2);
                    translate([(d2-d1)/2,0])square(d2, center=true);
                }
                cylinder(d=d1, h=h_cylinder);
                translate([0,0,h_cylinder]) sphere(d=d1);
            }
        }
    }
    
    
    
    module LayerCaseRemove() {
        BIAS = 0.1;
        translate([0, 0, -BIAS]) {
            linear_extrude(h + t + layer(1) + BIAS) {
                Tube_2D();
            }
        }
        translate([pitch/2,0]) {
            translate([0, 0, -BIAS]) {
                cylinder(
                    d = d1 + CASE_LED_WALL_CLEARANCE,
                    h = h + h1 + BIAS
                );
            }
            translate([0, 0, h + h1 - d1 / 2]) {
                cylinder(
                    d1 = d1 + CASE_LED_WALL_CLEARANCE,
                    d2 = d1 + + CASE_LED_WALL_CLEARANCE + 2 * cone_size,
                    h = cone_size
                );
            }
        }
    }
    
    module LayerCaseTopAddInner() {
        linear_extrude(h + t + layer(3)) {
            offset(nozzle(2)) Tube_2D();
        }
        translate([pitch/2,0]) {
            cylinder(d = d1 + nozzle(4/3) + nozzle(4), h = h + h1);
            translate([0, 0, h + h1 - d1 / 2 - layer(1)]) {
                cylinder(
                    d1 = d1 + nozzle(4/3) + nozzle(4),
                    d2 = d1 + nozzle(4/3) + nozzle(4) + 2 * cone_size,
                    h = cone_size
                );
            }
        }
    }
    
    module Tube_2D() {
        translate([pitch/2,0]) {
            circle(d= d2 + 2.5 * CASE_LED_WALL_CLEARANCE);
        }
        pad_size= mm(1.8) + 2.5 * CASE_LED_WALL_CLEARANCE;
        square(pad_size, center = true);
        translate([pitch, 0]) {
            circle(d=pad_size);
        }
    }
}