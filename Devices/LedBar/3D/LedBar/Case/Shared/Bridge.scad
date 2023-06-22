include <../../Config.inc>

use     <../../../../../Shared/3D/KicadPcbComponent.scad>
use     <../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../../Shared/3D/Utils/Units.scad>

use     <../Top/ProfileScrewHoles.scad>

Bridge("Case.Top.Add.Inner");

module Bridge(layer) {
    if (layer == "Case.Top.Add.Inner") {
        LayerCaseTopAddInner();
    }
    
    module LayerCaseTopAddInner() {
        width          = CASE_BRIDGE_WIDTH;
        beam_thickness = nozzle(2);
        beam_height    = layer(2);
        
        for(i = [0 : profile_screw_hole_count() - 1]) {
            pos_z = profile_screw_hole_bridge_pos_z(i);
            translate([
                profile_screw_hole_loc_x(i),
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
}