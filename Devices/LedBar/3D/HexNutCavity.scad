include <Shapes.inc>
include <Units.inc>

include <HexNutCavity.inc>

$fn = 32;

NOZZLE = mm(0.4);

hexnut_size     = HEXNUT_SIZE_M3;
shaft_diameter  = mm(3.2);
tolerance_steps = 0.1;
number          = 4;

difference() {
    test_size   = hexnut_size[0] * 1.3 + NOZZLE * 3;
    test_height = hexnut_size[1] + mm(2.0);
    
    linear_extrude(5) square([test_size * number, test_size + 2 * NOZZLE], true);
    for (i = [0:number-1]) {
        tolerance = i * tolerance_steps;
        translate([(i - number/2 + .5) * test_size, 0]) {
            HexNutCavity(
                size         = hexnut_size,
                tolerance_xy = tolerance,
                tolerance_z  = tolerance
            );
            cylinder(d=shaft_diameter, h = test_height + mm(1.0));
            
            translate([0, -test_size /2, test_height/2])
            rotate(90,[1,0,0]) linear_extrude(2*NOZZLE) text(
                str(i),
                size = test_height,
                halign="center",
                valign="center"
            );
        }
        
    }
}

module HexNutCavity(
    size,
    tolerance_xy   = mm(0.0),
    tolerance_z    = mm(0.0),
    bias           = mm(0.1),
    overhang_angle = 60,
    s              = 5,
) {
    diameter = size[0];
    height   = size[1];
    hull() {
        d  = diameter + 2*tolerance_xy;
        d2 = d / s;
        translate([0,0,-bias]) {
            linear_extrude(bias + height + tolerance_z) {
                Hex(d = d);
            }
        }

        translate([0,0, tolerance_z + (d - d2/2)/2 / tan(overhang_angle)]) {
            linear_extrude(height) {
                Hex(d = d2);
            }
        }
    }
}