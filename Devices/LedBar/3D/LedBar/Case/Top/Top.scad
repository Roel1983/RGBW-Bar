use     <../../../../../Shared/3D/Utils/Box.scad>
include <../../Config.inc>

include <../Shared/Boards/Mainboard/MainboardKicadPcb.inc>
use     <../Shared/Boards/Mainboard/Mainboard.scad>

use     <../Shared/PlaceFootprints.scad>
use     <../Shared/CaseBaseShape.scad>

translate([0, 0, CASE_PCB_Z_BACK]) {
    %Mainboard();
}

difference() {
    intersection() {
        union() {
            CaseBasicShapeOuter();
            PlaceFootprints(ALL_COMPONENTS_MAINBOARD, "Case.Top.Add.Outer");
        }
        Box(
            bounds = CASE_BOUNDS_XY,
            z_from = CASE_PCB_Z_FRONT,
            z_to   = CASE_HEIGHT_TOP
        );
    }
    difference() {
        CaseBasicShapeInner();
        translate([0, 0, CASE_PCB_Z_BACK]) {
            PlaceFootprints(ALL_COMPONENTS_MAINBOARD, "Case.Top.Add.Inner");
        }
    }
    translate([0, 0, CASE_PCB_Z_BACK]) {
        PlaceFootprints(ALL_COMPONENTS_MAINBOARD, "Case.Remove", PCB_THICKNESS_MAINBOARD);
    }
}