use     <../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../Shared/3D/Utils/LinearExtrude.scad>
include <../../Config.inc>

include <../Shared/Boards/Mainboard/MainboardKicadPcb.inc>
use     <../Shared/Boards/Mainboard/Mainboard.scad>

use     <../Shared/CaseBaseShape.scad>
use     <../Shared/PlaceFootprints.scad>
use     <../Shared/ScrewHoles.scad>
use     <../Shared/Connectors.scad>

translate([0, 0, CASE_PCB_Z_BACK]) {
    *Mainboard();
}
Bottom();

module Bottom() {
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
            Modifications("Case.Bottom.Add.Inner");
        }
        Modifications("Case.Remove");
        Modifications("Case.Bottom.Remove");
    }
    
    module Modifications(layer) {
        ScrewHoles(layer);
        Connectors(layer);
        translate([0, 0, CASE_PCB_Z_BACK]) {
            PlaceFootprints(
                ALL_COMPONENTS_MAINBOARD,
                layer,
                PCB_THICKNESS_MAINBOARD);
        }
    }
}