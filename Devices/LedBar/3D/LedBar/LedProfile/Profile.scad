include <../Config.inc>

use     <../../../../Shared/3D/Utils/Box.scad>
use     <../../../../Shared/3D/Utils/LinearExtrude.scad>

Profile();

module Profile(length = mm(100)) {
    LinearExtrude(x_size = length) {
        rotate(-90) difference() {
            translate([-ANGLE_PROFILE_THICKENS, -ANGLE_PROFILE_THICKENS]) {
                square(ANGLE_PROFILE_WIDTH);
            }
            square(ANGLE_PROFILE_WIDTH);
        }
    }    
}
