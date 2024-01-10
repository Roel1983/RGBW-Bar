use <../Shared/Support.scad>

include <../Config.inc>

profile_width_clearance     = mm(.50);
profile_thickness_clearance = mm(.25);

diagonal_wall = nozzle(4);

EndSupportStraight(0);

module EndSupportStraight(angle = 0) {
    width = 2 * sqrt(.5) * (ANGLE_PROFILE_WIDTH + profile_width_clearance) + 2 * diagonal_wall;
    difference() {
        Support(
            height  = CASE_HEIGHT_TOP +  (ANGLE_PROFILE_THICKENS + profile_thickness_clearance) / sqrt(.5) + diagonal_wall,
            width   = width,
            angle   = angle,
            is_open = true
        );
        translate([0,0,CASE_HEIGHT_TOP]) {
            mirror(VEC_X) {
                A();
            }
            translate([0, -width/2]) rotate(-angle) {
                translate([0, width/2]) {
                    A();
                }
            }
        }
    }

    module A() {
        rotate(90, VEC_Y) translate([0,0,nozzle(1)])linear_extrude(10, convexity=3) {
            rotate(-45) {
                difference() {
                    a = ANGLE_PROFILE_THICKENS + profile_thickness_clearance;
                    translate([-a, -a]) {
                        square(ANGLE_PROFILE_WIDTH + profile_width_clearance);
                    }
                    square(ANGLE_PROFILE_WIDTH + profile_width_clearance + profile_thickness_clearance);
                }
            }
        }
    }
}