use     <../../../../../Shared/3D/Utils/Box.scad>
include <../../Config.inc>

include <../Shared/Boards/Mainboard/MainboardKicadPcb.inc>
use     <../Shared/Boards/Mainboard/Mainboard.scad>

use     <../Shared/CaseBaseShape.scad>
use     <../Shared/PlaceFootprints.scad>
use     <../Shared/ScrewHoles.scad>

translate([0, 0, CASE_PCB_Z_BACK]) {
    %Mainboard();
}

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
        translate([0, 0, CASE_PCB_Z_BACK]) {
            PlaceFootprints(ALL_COMPONENTS_MAINBOARD, "Case.Bottom.Add.Inner");
        }
        ScrewHoles("Case.Bottom.Add.Inner");
    }
    translate([0, 0, CASE_PCB_Z_BACK]) {
        PlaceFootprints(ALL_COMPONENTS_MAINBOARD, "Case.Remove", PCB_THICKNESS_MAINBOARD);
    }
    ScrewHoles("Case.Remove");
}

//include <../../Config.inc>
//use     <../Shared/CaseBaseShape.scad>
//include <../Shared/Boards/Mainboard/MainboardKicadPcb.inc>
//use     <../../../../../Shared/3D/Utils/Box.scad>
//use     <../../../../../Shared/3D/Utils/Shapes.scad>
//use     <../../../../../Shared/3D/Utils/LinearExtrude.scad>
//include <../../../../../Shared/3D/Utils/Units.inc>
//include <../../../../../Shared/3D/KicadPcbComponent.scad>
//
//$fn = 32;
//
//function bounds_margin(bounds, margin) = [
//    [bounds[0][0] - margin, bounds[0][1] + margin],
//    [bounds[1][0] - margin, bounds[1][1] + margin],
//];
//
////$UNITS_LAYER               = 0.15;
////$UNITS_NOZZLE              = 0.40;
//
//CASE_WALL_THICKNESS_XY     = nozzle(3);
//CASE_WALL_THICKNESS_Z      = layer(5);
//CASE_PCB_WALL_CLEARANCE_Z  = mm(3);
//CASE_PCB_WALL_CLEARANCE_XY = mm(1);
//M3_HOLE_DIAMETER           = mm(3.1);
//M3_NUT_SIZE                = [mm(5), m(2.5)]; // Measure
//
//case_inner_size_xy = bounds_margin(PCB_BOUNDS_MAINBOARD, CASE_PCB_WALL_CLEARANCE_XY);
//case_outer_size_xy = bounds_margin(case_inner_size_xy, CASE_WALL_THICKNESS_XY);
//
//case_bottom_size_z = CASE_WALL_THICKNESS_Z + CASE_PCB_WALL_CLEARANCE_Z + PCB_THICKNESS_MAINBOARD;
//
//Bottom();
//
//module Bottom() {
//    
//    difference() {
//        union() {
//            OuterBox();
//            ScrewHolePilar();
//        }        
//        difference() {
//            bias = 0.1;
//            LinearExtrude(
//                z_from = CASE_WALL_THICKNESS_Z,
//                z_to   = case_bottom_size_z + bias
//            ) difference() {
//                InnerBox2D();
//                difference() {
//                    Supports2D();
//                    ThroughHolePins2D();
//                }
//            }
//            SmdComponents();
//        }
//        ScrewHoles();
//    }
//    Bridge();
//    Pillars();
//    
//    module OuterBox() {
//        Box(
//            bounds = CASE_BOUNDS_XY,
//            z_to   = CASE_SEAM_Z
//        );
//    }
//    
//    module InnerBox2D() {
//        Box(
//            bounds = case_inner_size_xy
//        );
//    }
//    
//    module Supports2D() {
//        
//    }
//    
//    module ThroughHolePins2D() {
//        
//    }
//    
//    
//    module SmdComponents() {
//        
//    }
//    
//    module ScrewHolePilar() {
//        ComponentPosition(COMPONENT_H201) Pillar();
//        ComponentPosition(COMPONENT_H202) Pillar();
//        ComponentPosition(COMPONENT_H203) Pillar();
//        ComponentPosition(COMPONENT_H204) Pillar();
//        
//        module Pillar() {
//            cylinder(
//                d = M3_HOLE_DIAMETER + nozzle(2),
//                h = case_bottom_size_z
//            );
//        }
//    }
//    
//    module ScrewHoles() {
//        ComponentPosition(COMPONENT_H201) Hole();
//        ComponentPosition(COMPONENT_H202) Hole();
//        ComponentPosition(COMPONENT_H203) Hole();
//        ComponentPosition(COMPONENT_H204) Hole();
//        
//        module Hole() {
//            bias = 0.1;
//            LinearExtrude(
//                z_to   = case_bottom_size_z + bias
//            ) {
//                circle(d = M3_HOLE_DIAMETER);
//            }
//            *LinearExtrude(
//                z_from = -bias,
//                z_to   = M3_NUT_SIZE[1]
//            ) {
//                Hex(size = M3_NUT_SIZE[0]);
//            }
//        }
//    }
//    
//    module Bridge() {
//        
//    }
//    
//    module Pillars() {
//        
//    }
//}
//
