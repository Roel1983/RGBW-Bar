include <../../Config.inc>

use     <../../../../../Shared/3D/Utils/Units.scad>
use     <../../../../../Shared/3D/KicadPcbComponent.scad>

ScrewHoles("Case.Remove");

module ScrewHoles(layer) {
    
    ComponentPosition(COMPONENT_H201) ScrewHole();
    ComponentPosition(COMPONENT_H202) ScrewHole();
    ComponentPosition(COMPONENT_H203) ScrewHole();
    ComponentPosition(COMPONENT_H204) ScrewHole();
    
    module ScrewHole() {
        if (layer == "Case.Remove") {
            CaseRemove();
        }
    }

    pillar_hole_clearance = mm(0.15);
    pillar_wall_thickness = nozzle(2);
    hole_diameter   = mm(4.3);
    pillar_outer_diameter = hole_diameter - 2 * pillar_hole_clearance;
    pillar_inner_diameter = pillar_outer_diameter - pillar_wall_thickness;
    assert(pillar_inner_diameter == mm(3.2));
    
    screw_length        = mm(9.8);
    screw_head_diameter = mm(5.5);

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
    }
}