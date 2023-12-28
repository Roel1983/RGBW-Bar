include <../../../../Shared/3D/Utils/Constants.inc>

use     <MiddleSupportLeft.scad>

MiddleSupportRight();

module MiddleSupportRight() {
    mirror(VEC_X) MiddleSupportLeft();
}