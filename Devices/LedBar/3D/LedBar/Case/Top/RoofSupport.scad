use     <../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../Shared/3D/Utils/TransformCopy.scad>

include <../../Config.inc>

RoofSupport("Case.Top.Add.Inner");

module RoofSupport(layer) {
    if(layer == "Case.Top.Add.Inner") {
        LayerCaseTopAddInner();
    }
    
    module LayerCaseTopAddInner() {
        thickness = [
            nozzle(2),
            CASE_WALL_THICKNESS_TOP + layer(8)
        ];
        
        mirror_copy(VEC_Y) {
            translate([
                0,
                CASE_HEIGHT_TOP
                - CASE_HEIGHT_SIDE
                - CASE_WALL_THICKNESS_TOP * .5
            ]) {
                Box(
                    x_from = CASE_BOUNDS_XY[X][0],
                    x_to   = CASE_BOUNDS_XY[X][1],
                    y_size = thickness[0],
                    z_to   = CASE_HEIGHT_SIDE,
                    z_size = thickness[1]
                );
            }
        }
    }
}
