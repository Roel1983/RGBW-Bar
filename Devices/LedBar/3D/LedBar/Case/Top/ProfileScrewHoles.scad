use     <../../../../../Shared/3D/KicadPcbComponent.scad>
use     <../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../Shared/3D/Utils/TransformIf.scad>
use     <../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../Shared/3D/Utils/Hex.scad>

include <../Shared/Boards/Mainboard/MainboardKicadPcb.inc>
include <../Shared/Boards/Subboards/SubboardsKicadPcb.inc>

include <../../Config.inc>
use     <CenterBoard.scad>

$fn = $preview?16:64;

LOC_X        = 0;
MIRROR_Y     = 1;
BRIDGE_POS_Z = 2;

PROFILE_SCREW_HOLE = [
    [CASE_BOUNDS_XY[X][0] + CASE_BRIDGE_WIDTH / 2, true , mm(25.5)],
    [component_at_loc(COMPONENT_J502)[X],          false, mm(23)],
    [CASE_BOUNDS_XY[X][1] - CASE_BRIDGE_WIDTH / 2, true , mm(25.5)]
];

function profile_screw_hole_count() = (
    len(PROFILE_SCREW_HOLE)
);
function profile_screw_hole_loc_x(i) = (
    PROFILE_SCREW_HOLE[i][LOC_X]
);
function profile_screw_hole_mirror_y(i) = (
    PROFILE_SCREW_HOLE[i][MIRROR_Y]
);
function profile_screw_hole_bridge_pos_z(i) = (
    PROFILE_SCREW_HOLE[i][BRIDGE_POS_Z]
);

ProfileScrewHoles("Case.Top.Remove");

module ProfileScrewHoles(layer) {
    if(layer == "Case.Top.Remove") {
        LayerCaseTopRemove();
    }
    
    module LayerCaseTopRemove() {
        for(i = [0 : profile_screw_hole_count() - 1]) {     
            translate([
                profile_screw_hole_loc_x(i),
                0
            ]) {
                mirror_if(profile_screw_hole_mirror_y(i), VEC_Y) {
                    TranslateToCenterBoardCenter() {
                        translate([
                            0,
                            (component_at_loc(COMPONENT_H1204)[Y] - 
                             CENTER_BOARD_CENTER[Y])
                        ]) {
                            ScrewHole();
                        }
                    }
                }
            }           
        }
    }
    
    module ScrewHole() {
        screw_length   = mm(9.0);
        screw_diameter = mm(3.0);
    
        BIAS = 0.1;
        translate([0,0,-screw_length + ANGLE_PROFILE_THICKENS]) {
            cylinder(d = screw_diameter, h = screw_length + BIAS);
        }
        render() {
            LinearExtrude(z_size=mm(HEX_NUT_HEIGHT), z_to = mm(-3.5)) {
                Hex(HEX_NUT_DIAMETER + 2 * HEX_NUT_TOLERANCE);
                translate([0, HEX_NUT_DIAMETER * -.8]) {
                    Hex(HEX_NUT_DIAMETER + 2 * HEX_NUT_TOLERANCE);
                    Box(
                        x_size = HEX_NUT_DIAMETER + 2 * HEX_NUT_TOLERANCE,
                        y_from = mm(-10)
                    );
                }
            }
            notch = 0.07;
            Box(
                x_size = HEX_NUT_DIAMETER + 2 * (HEX_NUT_TOLERANCE - notch),
                y_from = mm(-10),
                z_size=mm(HEX_NUT_HEIGHT), z_to = mm(-3.5)
            );
            Box(
                x_size = HEX_NUT_DIAMETER + 2 * (HEX_NUT_TOLERANCE),
                y_from = mm(-10),
                z_size=mm(HEX_NUT_HEIGHT / 3), z_to = mm(-3.5)
            );
            Box(
                x_size = HEX_NUT_DIAMETER + 2 * (HEX_NUT_TOLERANCE),
                y_from = mm(-10),
                z_size=mm(HEX_NUT_HEIGHT / 3), z_from = mm(-3.5) - HEX_NUT_HEIGHT
            );
        }
    }
}
