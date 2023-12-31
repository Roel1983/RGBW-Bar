use     <../../../../../../../Shared/3D/Utils/Box.scad>
use     <../../Footprint/Footprint.scad>
use     <../../PlaceFootprints.scad>

include <SubboardsKicadPcb.inc>

include <../../../../Config.inc>

ALL_COMPONENTS_LEFT_BOARD = [COMPONENT_H1102, COMPONENT_J1101,
        COMPONENT_J1102, COMPONENT_J1103];

LeftBoard();
module LeftBoard() {
    translate(-LEFT_BOARD_CENTER) {
        LeftBoardEdgeCuts();
        PlaceFootprints(ALL_COMPONENTS_LEFT_BOARD, "3D", PCB_THICKNESS_SUBBOARDS);
    }
}

module LeftBoardEdgeCuts() {
    color("white") linear_extrude(PCB_THICKNESS_SUBBOARDS) {
        LeftBoardEdgeCuts2D();
    }
}

module LeftBoardEdgeCuts2D() {
    difference() {
        Box(bounds = PCB_BOUNDS_LEFT_BOARD);
        PlaceFootprints(ALL_COMPONENTS_LEFT_BOARD, "Edge.Cuts");
    }
}
