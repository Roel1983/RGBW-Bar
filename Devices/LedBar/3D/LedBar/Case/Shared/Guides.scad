include <../../Config.inc>

use     <../../../../../Shared/3D/KicadPcbComponent.scad>
include <../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../Shared/3D/Utils/LinearExtrude.scad>

include <Boards/Mainboard/MainboardKicadPcb.inc>

Guides("Case.Bottom.Add");
%difference() {
    Guides("Case.Top.Add.Inner");
    Guides("Case.Top.Remove");
}

module Guides(layer) {
    guide_width          = mm(3.5);
    guide_thickness      = nozzle(3);
    guide_height         = mm(1.3);
    guide_pcb_support    = mm(1.2);
    
    guide_pcb_clearance    = mm(0.1);
    guide_pcb_clearance_z  = mm(1.5);
    guide_wall_clearance   = mm(0.1);
    guide_wall_clearance_z = mm(0.5);
    guide_wall_thickness   = nozzle(2);
    guide_wall_thickness_z = nozzle(5);
    
    side_connector_pitch    = mill(100);
    side_connector_to_guide = mm(4.5);
    power_connector_pitch   = mm(5.8);
    
    guide_positions_left  = [
        component_at_loc(COMPONENT_H201)[Y],
        -side_connector_to_guide + component_at_loc(COMPONENT_J501)[Y],
         side_connector_to_guide + component_at_loc(COMPONENT_J501)[Y] + 4 * side_connector_pitch,
        component_at_loc(COMPONENT_H202)[Y]
    ];
    guide_positions_right = [
        component_at_loc(COMPONENT_H203)[Y],
        -side_connector_to_guide + component_at_loc(COMPONENT_J503)[Y] - 4 * side_connector_pitch,
         side_connector_to_guide + component_at_loc(COMPONENT_J503)[Y],
        component_at_loc(COMPONENT_H204)[Y]
    ];
    guide_positions_front = [
        component_at_loc(COMPONENT_H201)[X],
        mm(-9),
        mm(9),
        component_at_loc(COMPONENT_H203)[X]
    ];
    guide_positions_back  = [
        component_at_loc(COMPONENT_H202)[X],
        (component_at_loc(COMPONENT_J601)[X] + component_at_loc(COMPONENT_J301)[X] - power_connector_pitch) / 2,
        component_at_loc(COMPONENT_H204)[X],
    ];
    
    // TODO asserts
    
    LeftGuides();
    RightGuides();
    FrontGuides();
    BackGuides();
    
    module LeftGuides() {
        for(position = guide_positions_left) {
            translate([PCB_BOUNDS_MAINBOARD[X][0], position]) {
                rotate(-90) Guide();
            }
        }
    }
    module RightGuides() {
        for(position = guide_positions_right) {
            translate([PCB_BOUNDS_MAINBOARD[X][1], position]) {
                rotate(90) Guide();
            }
        }
    }
    module FrontGuides() {
        for(position = guide_positions_front) {
            translate([position, PCB_BOUNDS_MAINBOARD[Y][1]]) {
                rotate(180) Guide();
            }
        }
    }
    module BackGuides() {
        for(position = guide_positions_back) {
            translate([position, PCB_BOUNDS_MAINBOARD[Y][0]]) {
                rotate(0) Guide();
            }
        }
    }
    
    module Guide() {
        if(layer == "Case.Bottom.Add") {
            LayerCaseBottomAddInner();
        } else if(layer == "Case.Top.Add.Inner") {
            LayerCaseTopAddInner();
        } else if(layer == "Case.Top.Remove") {
            LayerCaseTopRemove();
        }
        
        module LayerCaseBottomAddInner() {
            LinearExtrude(
                x_size = guide_width
            ) {
                polygon([
                    [guide_pcb_support - (guide_pcb_clearance_z- CASE_PCB_Z_BACK), 0],
                    [guide_pcb_support, CASE_PCB_Z_BACK - guide_pcb_clearance_z],
                    [guide_pcb_support, CASE_PCB_Z_BACK],
                    [-guide_pcb_clearance, CASE_PCB_Z_BACK],
                    [-guide_pcb_clearance, CASE_PCB_Z_FRONT + guide_height],
                    [-guide_pcb_clearance - guide_thickness, CASE_PCB_Z_FRONT + guide_height],
                    [-guide_pcb_clearance - guide_thickness, CASE_PCB_Z_FRONT],
                    [-CASE_PCB_WALL_CLEARANCE_HORIZONAL - CASE_WALL_THICKNESS_VERTICAL, CASE_PCB_Z_FRONT],
                    [-CASE_PCB_WALL_CLEARANCE_HORIZONAL - CASE_WALL_THICKNESS_VERTICAL, 0],
                ]);
            }
        }
        
        module LayerCaseTopAddInner() {
            Box(
                y_to   = -guide_pcb_clearance + guide_wall_clearance + guide_wall_thickness,
                y_from = -guide_pcb_clearance - guide_thickness - guide_wall_clearance - guide_wall_thickness,
                x_size = guide_width + 2 * (guide_wall_clearance + guide_wall_thickness),
                z_from = CASE_PCB_Z_FRONT,
                z_size = guide_height + guide_wall_clearance_z + guide_wall_thickness_z
            );
        }
        
        module LayerCaseTopRemove() {
            BIAS = .1;
            Box(
                y_to   = -guide_pcb_clearance + guide_wall_clearance,
                y_from = -guide_pcb_clearance - guide_thickness - guide_wall_clearance,
                x_size = guide_width + 2 * guide_wall_clearance,
                z_from = CASE_PCB_Z_FRONT - BIAS,
                z_size = guide_height + guide_wall_clearance_z
            );
        }
    }
    
}