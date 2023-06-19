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
//
//module CenterBoardEdgeCuts() {
//    
//    
//    
////    color("green") LinearExtrude(z_to = PCB_THICKNESS_SUBBOARDS) {
////        square(CENTER_BOARD_SIZE, center = true);
////    }
////    translate([0, mm(2.745)]) {
////        color([0.2,0.2,0.2]) Box(
////            x_size = mm(4.12),
////            y_size = mm(12.12),
////            z_from = mm(-1.5)
////        );
////        pitch = mm(2);
////        for (row = [-.5, .5], col = [-2.5:2.5]) {
////            translate([pitch * row, pitch * col]) {
////                Box(
////                    x_size = mm(.5), 
////                    y_size = mm(.5),
////                    z_from = mm(-5),
////                    z_to   = mm(2.5));
////            }
////        }
////    }
////    
////    translate([0, mm(-8.125)]) {
////        color([0.2,0.2,0.2]) {
////            LinearExtrude(
////                z_size = mm(-8),
////                z_from   =  PCB_THICKNESS_SUBBOARDS
////            ) {
////                circle(d=mm(3.2));
////            }
////            translate([0,0,PCB_THICKNESS_SUBBOARDS]) {
////                cylinder(d=mm(5.5), h=mm(2.2));
////            }
////        }
////    }
//}
