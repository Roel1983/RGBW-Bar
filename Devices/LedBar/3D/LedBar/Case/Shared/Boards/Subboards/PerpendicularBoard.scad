use     <../../../../../../../Shared/3D/Utils/Box.scad>
use     <../../Footprint/Footprint.scad>
use     <../../PlaceFootprints.scad>

include <SubboardsKicadPcb.inc>

ALL_COMPONENTS_PERPENDICULAR = [COMPONENT_J1001, COMPONENT_J1002];

$fn = 32;
PerpendicularBoard();

module PerpendicularBoard(layer = "3D") {
    PerpendicularBoardEdgeCuts();
    PlaceFootprints(ALL_COMPONENTS_PERPENDICULAR, layer, PCB_THICKNESS_SUBBOARDS,
        relative_to_component = COMPONENT_J1001);
}

module PerpendicularBoardEdgeCuts() {
    color("green") linear_extrude(PCB_THICKNESS_SUBBOARDS) {
        PerpendicularBoardCuts2D();
    }
}

module PerpendicularBoardCuts2D() {
    // TODO
}
