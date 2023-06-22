include <../../Config.inc>

include <../Shared/Boards/Mainboard/MainboardKicadPcb.inc>
use     <../Shared/PlaceFootprints.scad>

module CenterBoard(layer) {
    TranslateToCenterBoardCenter() {
        translate(-CENTER_BOARD_CENTER) {
            PlaceFootprints(
                [COMPONENT_H1204, COMPONENT_J1202],
                layer,
                PCB_THICKNESS_SUBBOARDS
            );
        }
    }
    
    module TranslateToCenterBoardCenter() {
        translate([0, 0, CASE_HEIGHT_TOP]) {
            rotate(-45, VEC_X) {
                translate([
                    0,
                    -ANGLE_PROFILE_THICKENS + ANGLE_PROFILE_WIDTH / 2
                ]) {
                    children();
                }
            }
        }
    }
}
