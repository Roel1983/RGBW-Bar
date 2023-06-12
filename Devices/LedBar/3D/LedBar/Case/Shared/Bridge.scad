include <../../Config.inc>

use     <../../../../../Shared/3D/KicadPcbComponent.scad>
use     <../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../../Shared/3D/Utils/Units.scad>

Bridge("Case.Top.Add.Inner");

module Bridge(layer) {
    if (layer == "Case.Top.Add.Inner") {
        LayerCaseTopAddInner();
    }
    
    module LayerCaseTopAddInner() {
        pos_z          = mm(23);
        width          = mm(7.5);
        beam_thickness = nozzle(2);
        beam_height    = layer(2);
        
        translate([
            component_at_loc(COMPONENT_J502)[X],
            0
        ]) {
            mirror_copy(VEC_X) {
                Box(
                    x_to     = width / 2,
                    x_size   = beam_thickness,
                    y_bounds = CASE_BOUNDS_XY[Y],
                    z_from   = pos_z,
                    z_to     = CASE_HEIGHT_TOP
                );
            }
            Box(
                x_size   = width,
                y_bounds = CASE_BOUNDS_XY[Y],
                z_from   = pos_z + beam_height,
                z_to     = CASE_HEIGHT_TOP
            );
        }
    }
}