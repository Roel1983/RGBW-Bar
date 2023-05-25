use     <../../../../../Shared/3D/Utils/Box.scad>
include <../../Config.inc>

include <../Shared/Boards/Mainboard/MainboardKicadPcb.inc>
use     <../Shared/Boards/Mainboard/Mainboard.scad>

use     <../Shared/CaseBaseShape.scad>
use     <../Shared/PlaceFootprints.scad>
use     <../Shared/ScrewHoles.scad>

$fn = 16;

translate([0, 0, CASE_PCB_Z_BACK]) {
    *Mainboard();
}
Top();

module Top() {
    difference() {
        intersection() {
            union() {
                CaseBasicShapeOuter();
                translate([0, 0, CASE_PCB_Z_BACK]) {
                    PlaceFootprints(
                        ALL_COMPONENTS_MAINBOARD,
                        "Case.Top.Add.Outer",
                        PCB_THICKNESS_MAINBOARD
                    );
                }
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
                PlaceFootprints(
                    ALL_COMPONENTS_MAINBOARD,
                    "Case.Top.Add.Inner",
                    PCB_THICKNESS_MAINBOARD
                );
            }
            ScrewHoles("Case.Top.Add.Inner");
        }
        translate([0, 0, CASE_PCB_Z_BACK]) {
            PlaceFootprints(
                ALL_COMPONENTS_MAINBOARD,
                "Case.Remove",
                PCB_THICKNESS_MAINBOARD
            );
            PlaceFootprints(
                ALL_COMPONENTS_MAINBOARD,
                "Case.Top.Remove",
                PCB_THICKNESS_MAINBOARD
            );
        }
        ScrewHoles("Case.Remove");
    }
    intersection() {
        translate([0, 0, CASE_PCB_Z_BACK]) {
            PlaceFootprints(
                ALL_COMPONENTS_MAINBOARD,
                "Case.Top.Add.Outer.NoBevel",
                PCB_THICKNESS_MAINBOARD
            );
        }
        CaseBasicShapeOuter(no_bevel = true);
    }
}