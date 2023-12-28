include <../Config.inc>
use     <../../../../Shared/3D/Utils/Box.scad>
use     <../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../Shared/3D/Utils/Units.scad>

$fn = $preview?16:64;
ScrewFoot();

module ScrewFoot(align = 0) {
    wall_thickness       = nozzle(4);
    bottom_thickness     = mm(2.0);
    height               = CASE_PCB_Z_FRONT;
    screw_head_diameter  = mm(8.0);
    screw_shaft_diameter = mm(4.0);
    clearance            = mm(0.5);
    extra                = mm(1.0);
    
    width  = screw_head_diameter + 2 * (clearance + wall_thickness);
    length = screw_head_diameter + clearance + extra;
    
    BIAS = 0.01;

    translate([align * -width / 2, 0]) {
        difference() {
            Box(
                x_size = width,
                y_from = -BIAS,
                y_to   = length,
                z_to   = bottom_thickness
            );
            translate([0, clearance + screw_head_diameter / 2, -BIAS]) {
                cylinder(
                    d1 = screw_shaft_diameter,
                    d2 = screw_head_diameter,
                    h  = bottom_thickness + 2 * BIAS
                );
            }
        }
        mirror_copy(VEC_X) {
            hull() {
                Box(
                    x_to   = width / 2,
                    x_size = wall_thickness,
                    y_from = -BIAS,
                    y_to   = length,
                    z_to   = bottom_thickness
                );
                Box(
                    x_to   = width / 2,
                    x_size = wall_thickness,
                    y_from = -BIAS,
                    z_to   = height
                );
            }
        }
    }
}