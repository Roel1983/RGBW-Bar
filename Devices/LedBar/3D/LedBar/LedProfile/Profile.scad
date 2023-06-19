include <../Config.inc>

use     <../../../../Shared/3D/Utils/Box.scad>
use     <../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../Case/Shared/PlaceFootprints.scad>

Profile();

module Profile(length = mm(100)) {
    
    difference() {
        BareProfile();
        translate([
            0,
            -ANGLE_PROFILE_THICKENS + ANGLE_PROFILE_WIDTH / 2,
            ANGLE_PROFILE_THICKENS
        ]) {
            translate(-CENTER_BOARD_CENTER) {
                PlaceFootprints(
                    [COMPONENT_H1204, COMPONENT_J1202],
                    "Profile.Remove",
                    PCB_THICKNESS_SUBBOARDS
                );
            }
        }
    }
    
    module BareProfile() {
        LinearExtrude(x_size = length, convexity=2) {
            rotate(-90) difference() {
                translate([-ANGLE_PROFILE_THICKENS, -ANGLE_PROFILE_THICKENS]) {
                    square(ANGLE_PROFILE_WIDTH);
                }
                square(ANGLE_PROFILE_WIDTH);
            }
        }
    }
}
