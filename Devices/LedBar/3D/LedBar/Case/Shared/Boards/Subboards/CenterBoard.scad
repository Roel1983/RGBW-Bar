use     <../../../../../../../Shared/3D/Utils/Box.scad>
use     <../../Footprint/Footprint.scad>
use     <../../PlaceFootprints.scad>

include <SubboardsKicadPcb.inc>

include <../../../../Config.inc>

ALL_COMPONENTS_CENTER_BOARD = [COMPONENT_H1204, COMPONENT_J1201,
        COMPONENT_J1202, COMPONENT_J1203, COMPONENT_J1204, COMPONENT_J1205];

CenterBoard();

module CenterBoard() {
    translate(-CENTER_BOARD_CENTER) {
        CenterBoardEdgeCuts();
        PlaceFootprints(ALL_COMPONENTS_CENTER_BOARD, "3D", PCB_THICKNESS_SUBBOARDS);
    }
}

module CenterBoardEdgeCuts() {
    color("white") linear_extrude(PCB_THICKNESS_SUBBOARDS) {
        CenterBoardEdgeCuts2D();
    }
}

module CenterBoardEdgeCuts2D() {
    difference() {
        Box(bounds = PCB_BOUNDS_CENTER_BOARD);
        PlaceFootprints(ALL_COMPONENTS_CENTER_BOARD, "Edge.Cuts");
    }
}
