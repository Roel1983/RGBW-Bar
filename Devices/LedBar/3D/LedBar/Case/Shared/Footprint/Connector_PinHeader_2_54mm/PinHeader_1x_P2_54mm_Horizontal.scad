use     <../../../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

PinHeader_1x_P2_54mm_Horizontal(layer = "3D", pins = 5);

module PinHeader_1x_P2_54mm_Horizontal(layer, pins = 5) {
    if (layer == "3D") {
        pitch = mill(100);
        Box(
            x_size = pitch,
            y_to   = pitch / 2,
            y_size = pitch * pins,
            z_to   = pitch
        );
        for(pin=[0:pins-1]) {
            translate([0, pin * -pitch]) {
                Pin();
            }
        }
    }
    module Pin() {
        a = mm(4.0);
        b = mm(3.75);
        d = mm(7);
        r = mm(.75);
        t = mm(0.64);
        hull() {
            Box(
                x_size = t,
                y_size = t,
                z_from = -a + t / 2,
                z_to   = b - r
                
            );
            Box(
                x_size = t / 3,
                y_size = t / 3,
                z_from = -a
            );
        }
        translate([0, 0, b]) hull() {
            Box(
                x_from = r,
                x_to   = d - t / 2,
                y_size = t,
                z_size = t
            );
            Box(
                x_from = r,
                x_to   = d,
                y_size = t / 3,
                z_size = t / 3
            );
        }
        translate([r, 0, b - r]) {
            rotate(-90, VEC_X) {
                rotate_extrude(angle = 90) {
                    translate([-r, 0]) square(size = t, center = true);
                }
            }
        }
    }
}