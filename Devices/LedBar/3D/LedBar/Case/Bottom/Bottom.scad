include <../../Config.inc>
include <../MainboardKicadPcb.inc>
use     <../../../../../Shared/3D/Box.scad>
use     <../../../../../Shared/3D/Shapes.scad>
use     <../../../../../Shared/3D/LinearExtrude.scad>
include <../../../../../Shared/3D/Units.inc>


$fn = 32;

function bounds_margin(bounds, margin) = [
    [bounds[0][0] - margin, bounds[0][1] + margin],
    [bounds[1][0] - margin, bounds[1][1] + margin],
];

$UNITS_LAYER               = 0.15;
$UNITS_NOZZLE              = 0.40;

CASE_WALL_THICKNESS_XY     = nozzle(3);
CASE_WALL_THICKNESS_Z      = layer(5);
CASE_PCB_WALL_CLEARANCE_Z  = mm(3);
CASE_PCB_WALL_CLEARANCE_XY = mm(1);
M3_HOLE_DIAMETER           = mm(3.1);
M3_NUT_SIZE                = [mm(5), m(2.5)]; // Measure

case_inner_size_xy = bounds_margin(PCB_BOUNDS, CASE_PCB_WALL_CLEARANCE_XY);
case_outer_size_xy = bounds_margin(case_inner_size_xy, CASE_WALL_THICKNESS_XY);

case_bottom_size_z = CASE_WALL_THICKNESS_Z + CASE_PCB_WALL_CLEARANCE_Z + PCB_THICKNESS;

Bottom();

module CenterBoard_At_2D(component) {
    translate(component_at_loc(component)) {
        side = component_at_side(component);
        if (side == "F") {
            rotate(component_at_rot(component)) {
                children();
            }
        } else {
            rotate(-component_at_rot(component)) {
                children();
            }
        }
    }
}

module Bottom() {
    
    difference() {
        union() {
            OuterBox();
            ScrewHolePilar();
        }        
        difference() {
            bias = 0.1;
            LinearExtrude(
                z_from = CASE_WALL_THICKNESS_Z,
                z_to   = case_bottom_size_z + bias
            ) difference() {
                InnerBox2D();
                difference() {
                    Supports2D();
                    ThroughHolePins2D();
                }
            }
            SmdComponents();
        }
        ScrewHoles();
    }
    Bridge();
    Pillars();
    
    module OuterBox() {
        Box(
            bounds = case_outer_size_xy,
            z_to   = case_bottom_size_z
        );
    }
    
    module InnerBox2D() {
        Box(
            bounds = case_inner_size_xy
        );
    }
    
    module Supports2D() {
        
    }
    
    module ThroughHolePins2D() {
        
    }
    
    
    module SmdComponents() {
        
    }
    
    module ScrewHolePilar() {
        CenterBoard_At_2D(COMPONENT_H201) Pillar();
        CenterBoard_At_2D(COMPONENT_H202) Pillar();
        CenterBoard_At_2D(COMPONENT_H203) Pillar();
        CenterBoard_At_2D(COMPONENT_H204) Pillar();
        
        module Pillar() {
            cylinder(
                d = M3_HOLE_DIAMETER + nozzle(2),
                h = case_bottom_size_z
            );
        }
    }
    
    module ScrewHoles() {
        CenterBoard_At_2D(COMPONENT_H201) Hole();
        CenterBoard_At_2D(COMPONENT_H202) Hole();
        CenterBoard_At_2D(COMPONENT_H203) Hole();
        CenterBoard_At_2D(COMPONENT_H204) Hole();
        
        module Hole() {
            bias = 0.1;
            LinearExtrude(
                z_to   = case_bottom_size_z + bias
            ) {
                circle(d = M3_HOLE_DIAMETER);
            }
            *LinearExtrude(
                z_from = -bias,
                z_to   = M3_NUT_SIZE[1]
            ) {
                Hex(size = M3_NUT_SIZE[0]);
            }
        }
    }
    
    module Bridge() {
        
    }
    
    module Pillars() {
        
    }
}

