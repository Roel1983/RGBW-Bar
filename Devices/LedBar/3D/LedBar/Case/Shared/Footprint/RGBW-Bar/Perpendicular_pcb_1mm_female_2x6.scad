use     <../../../../../../../Shared/3D/Utils/Bounds.scad>
use     <../../../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../../../Shared/3D/Utils/Constants.inc>
include <../../../../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>
include <../../../../Config.inc>

#Perpendicular_pcb_1mm_female_2x6("Edge.Cuts");
difference() {
    %Perpendicular_pcb_1mm_female_2x6("Case.Bottom.Add.Inner");
    Perpendicular_pcb_1mm_female_2x6("Case.Remove");
}

module Perpendicular_pcb_1mm_female_2x6(layer = "3D") {
    if (layer == "Edge.Cuts") {
        LayerEdgeCuts();
    } else if (layer == "Case.Bottom.Add.Inner") {
        LayerCaseBottomAddInner();
    } else if (layer == "Case.Remove") {
        LayerCaseRemove();
    }
    
    module LayerEdgeCuts() {
        hull() {
            translate([0, inch( 0.04)]) circle(mm(0.52));
            translate([0, inch(-0.34)]) circle(mm(0.52));
        }
    }
    
    clearance = mm(.1);
    support_size = [
        inch(.20) + clearance,
        inch(.38) + clearance
    ];
    wall = nozzle(4);
    BIAS = 0.1;
    
    module LayerCaseBottomAddInner() {
        translate([0, inch(-0.15)]) {
            Box(
                x_size = support_size[X] + 2 * wall,
                y_size = support_size[Y] + 2 * wall,
                z_to   = +BIAS,
                z_from = -CASE_PCB_Z_FRONT - BIAS
            );
            mirror_copy(VEC_Y) {
                Box(
                    x_bounds = CASE_BOUNDS_XY[X],    
                    y_from = support_size[Y] / 2,
                    y_to   = support_size[Y] / 2 + wall,
                    
                    z_to   = -mm(2.5) + PCB_THICKNESS_MAINBOARD,
                    z_from = -CASE_PCB_Z_FRONT - BIAS
                );
            }
        }
    }
    
    module LayerCaseRemove() {
        translate([0, inch(-0.15)]) {
            Box(
                x_size = support_size[X],
                y_size = support_size[Y],
                z_to   = 2 * BIAS,
                z_from = -mill(95) - clearance
            );
        }
    }
}
