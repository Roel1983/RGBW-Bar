use     <../../../../Shared/3D/Utils/Box.scad>
use     <../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../Shared/3D/Utils/Hex.scad>

include <../Config.inc>

ScrewHole();

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