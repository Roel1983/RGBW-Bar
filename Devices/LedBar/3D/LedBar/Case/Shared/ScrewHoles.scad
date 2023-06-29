include <../../Config.inc>

use     <../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../Shared/3D/Utils/Hex.scad>
use     <../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../Shared/3D/Utils/TransformIf.scad>
use     <../../../../../Shared/3D/Utils/Units.scad>
use     <../../../../../Shared/3D/KicadPcbComponent.scad>

$fn = $preview?16:64;
difference() {
    ScrewHoles("Case.Bottom.Add.Inner");
    ScrewHoles("Case.Remove");
}

difference() {
    ScrewHoles("Case.Top.Add.Inner");
    ScrewHoles("Case.Remove");
}

module ScrewHoles(layer) {
    
    ScrewHole(COMPONENT_H201, mirror_x = false, mirror_y = true);
    ScrewHole(COMPONENT_H202, mirror_x = false, mirror_y = false);
    ScrewHole(COMPONENT_H203, mirror_x = true, mirror_y = true);
    ScrewHole(COMPONENT_H204, mirror_x = true, mirror_y = false);
    
    module ScrewHole(component, mirror_x, mirror_y) {
        ComponentPosition(component, rotate = false) {
            mirror_if(mirror_x, VEC_X) mirror_if(mirror_y, VEC_Y) {
                if (layer == "Case.Remove") {
                    CaseRemove();
                } else if (layer == "Case.Bottom.Add.Inner") {
                    CaseBottomAddInner();
                } else if (layer == "Case.Top.Add.Inner") {
                    CaseTopAddInner(
                        is_modified = (
                            component_footprint(component)[1]
                            ==
                            "MountingHole_4.3mm_M4_modified1"
                        )
                    );
                }
            }
        }
    }

    pillar_hole_clearance = mm(0.15);
    pillar_wall_thickness = nozzle(1);
    hole_diameter         = mm(4.3);
    pillar_outer_diameter = hole_diameter - 2 * pillar_hole_clearance;
    pillar_inner_diameter = pillar_outer_diameter - 2 * pillar_wall_thickness;
    assert(pillar_inner_diameter == mm(3.2));
    
    screw_head_embed       = mm(0.8);
    wall_thickness_z        = layer(5);
    screw_length           = CASE_HEIGHT_SIDE - screw_head_embed - wall_thickness_z;
    assert(screw_length > mm(10.1));
    screw_head_diameter    = mm(5.5);
    
    hex_nut_wall_thickness = nozzle(4);
    support_diameter       = HEX_NUT_DIAMETER / cos(degree(30)) + 2 * hex_nut_wall_thickness;

    module CaseRemove() {
        BIAS = 0.1;
        
        screw();
        nut();
        
        module screw() {
            rotate_extrude() polygon(points = [  
                [0, -BIAS],
                [screw_head_diameter / 2, -BIAS],
                [screw_head_diameter / 2, screw_head_embed],
                [pillar_inner_diameter / 2, 
                 screw_head_embed + (screw_head_diameter - pillar_inner_diameter) / 2],
                [pillar_inner_diameter / 2, screw_head_embed + screw_length],
                [0, screw_head_embed + screw_length]
            ]);
        }
        module nut() {
            clearance_xy = mm(.05);
            clearance_z  = layer(.5 );
            translate([0, 0, CASE_PCB_Z_FRONT + mm(1.5)]) {
                LinearExtrude(
                    z_to   = HEX_NUT_HEIGHT + clearance_z
                ) {
                    Hex(size = HEX_NUT_DIAMETER + 2 * clearance_xy);
                }
                Box(
                    x_size = HEX_NUT_DIAMETER + 2 * clearance_xy,
                    y_size = pillar_inner_diameter,
                    z_to   = HEX_NUT_HEIGHT + clearance_z + layer(1.1)
                );
                hull() {
                    Box(
                        x_size = pillar_inner_diameter,
                        y_size = pillar_inner_diameter,
                        z_to   = HEX_NUT_HEIGHT + clearance_z + layer(2.1)
                    );
                    cylinder(
                        d = pillar_inner_diameter,
                        h = HEX_NUT_HEIGHT + clearance_z + layer(5.1)
                    );
                }
            }
        }
    }
    
    
    module Support2D() {
        circle(d = support_diameter);
        difference() {
            Box(
                x_to   = support_diameter / 2,
                x_from = cm(-1),
                y_to   = support_diameter / 2,
                y_from = cm(-1)
            );
            BIAS = 0.1;
            Box(
                x_to = support_diameter / 2 + BIAS,
                y_to = support_diameter / 2 + BIAS
            );
        }
    }
    
    module CaseBottomAddInner() {
        LinearExtrude(
            z_to = CASE_PCB_Z_BACK
        ) {
            Support2D();
        }
        cylinder(
            d = pillar_outer_diameter,
            h = CASE_PCB_Z_FRONT
        );
    }
    
    module CaseTopAddInner(is_modified) {
        difference() {
            LinearExtrude(
                z_from = CASE_PCB_Z_FRONT,
                z_to   = CASE_HEIGHT_SIDE
            ) {
                Support2D();
            }
            if (is_modified) {
                // TODO: Modification
            }
        }
    }
}