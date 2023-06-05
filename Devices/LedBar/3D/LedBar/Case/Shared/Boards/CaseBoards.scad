use     <../../../../../../Shared/3D/KicadPcbComponent.scad>
include <../../../../../../Shared/3D/Utils/Constants.inc>
use     <Mainboard/Mainboard.scad>
include <Mainboard/MainboardKicadPcb.inc>
use     <Subboards/PerpendicularBoard.scad>
include <Subboards/SubboardsKicadPcb.inc>

$fn = 32;
CaseBoards();

module CaseBoards() {
    Mainboard();
    ComponentPosition(COMPONENT_J502, pcb_thickness = PCB_THICKNESS_MAINBOARD) {
        rotate(90, VEC_Y) rotate(-90) {
            translate([0, 0, -PCB_THICKNESS_SUBBOARDS / 2]) {
                PerpendicularBoard();
            }
        }
    }
}