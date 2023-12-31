include <../Config.inc>

use <MiddleSupport.scad>

MiddleSupportTemplate();

module MiddleSupportTemplate() {
    difference() {
        rotate(90, VEC_Y)linear_extrude(12, center = true, convexity = 3) polygon([
            [0, -ANGLE_PROFILE_THICKENS],
            [0, ANGLE_PROFILE_WIDTH - -ANGLE_PROFILE_THICKENS],
            [-ANGLE_PROFILE_THICKENS, ANGLE_PROFILE_WIDTH - -ANGLE_PROFILE_THICKENS],
            [-ANGLE_PROFILE_THICKENS - .5, ANGLE_PROFILE_WIDTH - -ANGLE_PROFILE_THICKENS - .5],
            [-ANGLE_PROFILE_THICKENS - 1.5, ANGLE_PROFILE_WIDTH - -ANGLE_PROFILE_THICKENS - .5],
            [-ANGLE_PROFILE_THICKENS - 1.5, ANGLE_PROFILE_WIDTH + 2.5],
            [2, ANGLE_PROFILE_WIDTH + 2.5],
            [2, -2 - ANGLE_PROFILE_THICKENS],
            [-ANGLE_PROFILE_THICKENS - 1.5, -2 - ANGLE_PROFILE_THICKENS],
            [-ANGLE_PROFILE_THICKENS - 1.5, - ANGLE_PROFILE_THICKENS],
            
        ]);

        rotate(45, VEC_X) translate([0,0,-CASE_HEIGHT_TOP]) {
            MiddleSupportHolePos() cylinder(d=3, h=10, center =true);
            MiddleSupportConnectorCenterPos() {
                cube([2.0, 10, 10], true);
                rotate(90, VEC_X)linear_extrude(7, center=true) rotate(45) square(3);
            }
        }
        translate([0, -ANGLE_PROFILE_THICKENS]) {
            linear_extrude(10, center=true)rotate(-135) square(5);
        }
    }
}