use     <../../../../Shared/3D/KicadPcbComponent.scad>
use     <../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../Case/Shared/Boards/Subboards/LeftBoard.scad>
use     <../Shared/ScrewHole.scad>

use <../Shared/Support.scad>

include <../Config.inc>

$fn = 64;

MiddleSupport();

*translate([0,0,CASE_HEIGHT_TOP]) rotate(-45, VEC_X) {
    translate([0, -ANGLE_PROFILE_THICKENS, ANGLE_PROFILE_THICKENS]) {
       translate([0, ANGLE_PROFILE_WIDTH/2]) {
            LeftBoard();
       }
    }
}

module MiddleSupport() {
    difference() {
        Support(
            height  = CASE_HEIGHT_TOP,
            width   = 2 * sqrt(.5) * (ANGLE_PROFILE_WIDTH - ANGLE_PROFILE_THICKENS),
            angle   = 0,
            is_open = false,
            foot_slide = mm(2)
        );
        
        /* We want the hole on the same position as for the
         * Main board and the rest relative to that */
        MiddleSupportHolePos() ScrewHole();
        MiddleSupportConnectorCenterPos() {
            linear_extrude(5.5)square([2.7, 11.1], true);
            linear_extrude(1, center=true)square([2.7 + 1, 11.1 + 1], true);
            rotate(-90, VEC_X) linear_extrude(10, center=true) {
                difference() {
                    translate([0, -19/2-5.4])square([12, 19], true);
                    translate([0, -20]) hull() {mirror_copy(VEC_X) translate([-1.5,0]) circle(d=3);}
                    translate([0, -15]) hull() {mirror_copy(VEC_X) translate([-1,0]) circle(d=2);}
                }
            }
        }

        rotate(-90, VEC_Y)linear_extrude(12, center=true)
        offset(r=1) offset(-1) difference() {
            intersection() {
                offset(-3) projection()rotate(90, VEC_Y) Support(
                    height  = CASE_HEIGHT_TOP,
                    width   = 2 * sqrt(.5) * (ANGLE_PROFILE_WIDTH - ANGLE_PROFILE_THICKENS),
                    angle   = 0,
                    is_open = false
                );
                translate([0,-7])rotate(45) square(30);
            }
            square([11,40], center=true);
        }
    }
}

module MiddleSupportHolePos() {
    translate([0, 0, CASE_PCB_Z_BACK])
    ComponentPosition(COMPONENT_J502, PCB_THICKNESS_MAINBOARD) 
    rotate(90, VEC_Y)
    rotate(-90) 
    ComponentPosition(COMPONENT_J1002, PCB_THICKNESS_SUBBOARDS, 
            relative_to_component= COMPONENT_J1001) rotate(-90, VEC_Y) 
    translate([-.4/2,0,4.5,]) // TODO?? -.4
    rotate(180)
    ComponentPosition(COMPONENT_H1204, PCB_THICKNESS_SUBBOARDS,
            relative_to_component= COMPONENT_J1202)
    rotate(180)
    children();
}

module MiddleSupportConnectorCenterPos() {
    MiddleSupportHolePos()
    ComponentPosition(COMPONENT_J1102, PCB_THICKNESS_SUBBOARDS,
        relative_to_component= COMPONENT_H1102)
    translate([0, -2 * mm(2.0)])
    children();
}
