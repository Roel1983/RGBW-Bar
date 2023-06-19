include <../Config.inc>

use     <../../../../Shared/3D/Utils/Box.scad>
include <../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <Profile.scad>
use     <../Case/Shared/Boards/Subboards/CenterBoard.scad>

LedProfile();

module LedProfile() {
    color("white") Profile();
    translate([0, -ANGLE_PROFILE_THICKENS, ANGLE_PROFILE_THICKENS]) {
        translate([0, ANGLE_PROFILE_WIDTH/2]) {
            CenterBoard();
        }
    }
}
