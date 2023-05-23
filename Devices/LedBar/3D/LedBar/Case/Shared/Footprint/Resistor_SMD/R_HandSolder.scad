use     <../../../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

R_HandSolder(
    layer = "3D",
    l = inch(0.08),
    w = inch(0.05),
    h = mm(0.45),
    
    solder_l = mm(3.2),
    solver_w = mm(1.4)
);

module R_HandSolder(
    layer,
    l,
    w,
    h,   
    solder_l,
    solver_w
) {
    if (layer == "3D") {
        Layer3D();
    }
    
    module Layer3D() {
        color([0.1,0.1,0.1])Box(
            x_size = l,
            y_size = w,
            z_to   = h
        );
        
        BIAS = 0.05;
        color("silver") {
            hull() {
                Box(
                    x_size = solder_l,
                    y_size = w - BIAS,
                    z_to   = BIAS
                );
                RoundSolder();
            }
            hull() {
                Box(
                    x_size = l - BIAS,
                    y_size = w - BIAS,
                    z_to   = h - BIAS
                );
                RoundSolder();
            }
        }
    }
    
    module RoundSolder() {
        mirror_copy(VEC_X) {
            translate([l / 2, 0]) {
                intersection() {
                    translate([0, 0, h - w / 2]) {
                        sphere(d = w);
                    }
                    Box(
                        x_size = w,
                        y_size = w,
                        z_to   = h
                    );
                }
            }
        }
    }
}