use     <../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../Shared/3D/Utils/LinearExtrude.scad>
include <../../Config.inc>

include <../Shared/Boards/Mainboard/MainboardKicadPcb.inc>
use     <../Shared/Boards/Mainboard/Mainboard.scad>

use     <../Shared/CaseBaseShape.scad>
use     <../Shared/PlaceFootprints.scad>
use     <../Shared/ScrewHoles.scad>

translate([0, 0, CASE_PCB_Z_BACK]) {
    *Mainboard();
}

difference() {
    intersection() {
        CaseBasicShapeOuter();
        Box(
            bounds = CASE_BOUNDS_XY,
            z_to   = CASE_PCB_Z_FRONT
        );
    }
    difference() {
        CaseBasicShapeInner();
        translate([0, 0, CASE_PCB_Z_BACK]) {
            PlaceFootprints(ALL_COMPONENTS_MAINBOARD, "Case.Bottom.Add.Inner", PCB_THICKNESS_MAINBOARD);
        }
        ScrewHoles("Case.Bottom.Add.Inner");
    }
    translate([0, 0, CASE_PCB_Z_BACK]) {
        PlaceFootprints(ALL_COMPONENTS_MAINBOARD, "Case.Remove", PCB_THICKNESS_MAINBOARD);
    }
    ScrewHoles("Case.Remove");
}
