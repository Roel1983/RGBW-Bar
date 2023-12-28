include <../../Config.inc>
use     <../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../../Shared/3D/Utils/Units.scad>

use <../../Shared/ScrewFoot.scad>

$fn = $preview?16:64;
MountingFeet("Case.Bottom.Add");

module MountingFeet(layer) {
    if(layer == "Case.Bottom.Add") {
        LayerCaseBottomAdd();
    }
    
    module LayerCaseBottomAdd() {
        translate([CASE_BOUNDS_XY[X][0], 0]) {
            translate([0, CASE_BOUNDS_XY[Y][0]]) {
                rotate(90) ScrewFoot(align = -1);
            }
            translate([0, CASE_BOUNDS_XY[Y][1]]) {
                rotate(90) ScrewFoot(align = 1);
            }
        }
        translate([CASE_BOUNDS_XY[X][1], 0]) {
            translate([0, CASE_BOUNDS_XY[Y][0]]) {
                rotate(-90) ScrewFoot(align = 1);
            }
            translate([0, CASE_BOUNDS_XY[Y][1]]) {
                rotate(-90) ScrewFoot(align = -1);
            }
        }
    }
}
