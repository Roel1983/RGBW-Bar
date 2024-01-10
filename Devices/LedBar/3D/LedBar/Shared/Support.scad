include <../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../Shared/3D/Utils/Git.scad>
use     <../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../Shared/3D/Utils/Units.scad>

use <../Shared/ScrewFoot.scad>

include <../Config.inc>

$fn = 64;

Support(
    height  = CASE_HEIGHT_TOP,
    width   = 2 * sqrt(.5) * (ANGLE_PROFILE_WIDTH - ANGLE_PROFILE_THICKENS),
    angle   = 45,
    is_open = true,
    foot_slide = 2);

module Support(
    height,
    width,
    angle = 0,
    is_open = false,
    foot_slide = 0
) {
    thickness = mm(10);
    
    Feet();
    difference() {
        Base();
        GitRevision();
    }
    
    module Base() {
        if(angle == 0) {
            rotate(90, VEC_Y) rotate(90) {
                linear_extrude(thickness, center = true, convexity = 3) {
                    SideSketch();
                }
            }
        } else {
            translate([-thickness / 2, 0]) A();
            translate([0, -width/2]) rotate(-angle) {
                translate([thickness / 2, width/2]) {
                    mirror(VEC_X) A();
                }
            }
        }
        module A() {
            intersection() {
                rotate(90, VEC_Y) rotate(90) {
                    linear_extrude(thickness / 2 + tan(angle/2) * width,
                        center = false, convexity = 3
                    ) {
                        SideSketch();
                    }
                }
                linear_extrude(height) polygon([
                    [0, width / 2],
                    [thickness / 2 + tan(angle/2) * width, width / 2],
                    [thickness / 2, -width / 2],
                    [0, -width / 2]
                ]);
            }
        }

        module SideSketch() {
            wall = mm(5);
            r    = mm(2);
            
            difference() {
                A();
                if(is_open) {
                    offset(r) offset(r = -wall - r) A();
                }
            }
            
            module A() {
                render() mirror_copy(VEC_X) polygon(points=[
                    [
                       0,
                       0 
                    ], [
                        0,
                        height
                    ], [
                        width / 2,
                        height - width / 2
                    ], [
                        width / 2,
                        0
                    ]
                ]);
            }
        }
    }
    
    module Feet(angle = angle) {
        if (angle < 0) {
            mirror(VEC_Y) Feet(-angle);
        } else {
            translate([-thickness / 2, 0]) {
                rotate(90) ScrewFoot(align = 0, slide = foot_slide);
            }
            translate([0, -width/2]) rotate(-angle) {
                translate([thickness / 2, width/2]) {
                    rotate(-90) ScrewFoot(align = 0, slide = foot_slide);
                }
            }
        }
    }
    
    module GitRevision() {
        linear_extrude(layer(1.5), center = true) {
            rotate(90) offset(mm(.1)) mirror(VEC_X) {
                CommitText(size=mm(5));
            }
        }
    }
}