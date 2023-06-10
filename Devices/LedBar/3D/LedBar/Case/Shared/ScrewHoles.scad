include <../../Config.inc>

use     <../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../Shared/3D/Utils/Hex.scad>
use     <../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../Shared/3D/Utils/Units.scad>
use     <../../../../../Shared/3D/KicadPcbComponent.scad>

$fn = $preview?16:64;
difference() {
    union() {
        ScrewHoles("Case.Bottom.Add.Inner");
        ScrewHoles("Case.Top.Add.Inner");
    }
    ScrewHoles("Case.Remove");
}

module ScrewHoles(layer) {
    
    ScrewHole(COMPONENT_H201, 270);
    ScrewHole(COMPONENT_H202,   0);
    ScrewHole(COMPONENT_H203, 180);
    ScrewHole(COMPONENT_H204,  90);
    
    module ScrewHole(component, angle) {
        ComponentPosition(component, rotate = false) {
            rotate(angle) {
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
    
    screw_length           = mm(9.8);
    screw_head_diameter    = mm(5.5);
    hex_nut_size           = mm(5.5);
    hex_nut_height         = mm(2.4);
    hex_nut_wall_thickness = nozzle(4);
    support_diameter       = hex_nut_size / cos(degree(30)) + 2 * hex_nut_wall_thickness;

    module CaseRemove() {
        BIAS = 0.1;
        
        rotate_extrude() polygon(points = [
            [0, -BIAS],
            [pillar_inner_diameter / 2, 0],
            [pillar_inner_diameter / 2, screw_length - (screw_head_diameter - pillar_inner_diameter) / 2],
            [screw_head_diameter / 2, screw_length],
            [screw_head_diameter / 2, CASE_HEIGHT_SIDE + BIAS],
            [0, CASE_HEIGHT_SIDE + BIAS]
        ]);
        hull() {
            LinearExtrude(
                z_from = -BIAS,
                z_to   = hex_nut_height
            ) {
                Hex(size = hex_nut_size);
            }
            cylinder(
                d = pillar_inner_diameter / 2,
                h = hex_nut_height + (hex_nut_size - pillar_inner_diameter) / 2
            );
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