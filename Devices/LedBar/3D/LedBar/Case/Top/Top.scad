use     <../../../../../Shared/3D/Utils/Box.scad>
include <../../Config.inc>

include <../Shared/Boards/Mainboard/MainboardKicadPcb.inc>
use     <../Shared/Boards/Mainboard/Mainboard.scad>

use     <../Shared/CaseBaseShape.scad>
use     <../Shared/PlaceFootprints.scad>
use     <../Shared/ScrewHoles.scad>
use     <../Shared/Guides.scad>

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
                Modifications("Case.Top.Add.Outer");
            }
            Box(
                bounds = CASE_BOUNDS_XY,
                z_from = CASE_PCB_Z_FRONT,
                z_to   = CASE_HEIGHT_TOP
            );
        }
        difference() {
            CaseBasicShapeInner();
            Modifications("Case.Top.Add.Inner");
        }
        Modifications("Case.Remove");
        Modifications("Case.Top.Remove");
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
    
    module Modifications(layer) {
        translate([0, 0, CASE_PCB_Z_BACK]) {
            PlaceFootprints(
                ALL_COMPONENTS_MAINBOARD,
                layer,
                PCB_THICKNESS_MAINBOARD
            );
        }
        ScrewHoles(layer);
        Guides(layer);
    }
}