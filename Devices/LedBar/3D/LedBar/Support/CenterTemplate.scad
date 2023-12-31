include <../Config.inc>

use <MiddleSupport.scad>

CenterTemplate();

module CenterTemplate() {
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
            CenterConnectorCenterPos() {
                cube([4.0, 12, 10], true);
                translate([0,0,-1]) {
                    rotate(90, VEC_X)linear_extrude(9, center=true) rotate(45) square(5);
                }
            }
        }
        translate([0, -ANGLE_PROFILE_THICKENS]) {
            linear_extrude(10, center=true)rotate(-135) square(5);
        }
    }
}

module CenterConnectorCenterPos() {
    MiddleSupportHolePos()
    ComponentPosition(COMPONENT_J1202, PCB_THICKNESS_SUBBOARDS,
        relative_to_component= COMPONENT_H1204)
    translate([1, -2.5 * mm(2.0)])
    children();
}
