include <../../../../Config.inc>

use     <../../../../../../../Shared/3D/Utils/Box.scad>

$fn = 32;

PinHeader_2x6_P2_00mm_Vertical(layer = "3D");

module PinHeader_2x6_P2_00mm_Vertical(layer) {
    if (layer == "3D") {
        Layer3D();
    } else if(layer == "Profile.Remove") {
        LayerProfileRemove();
    }
    pitch = mm(2.00);
    
    module Layer3D() {
        color([.1,.1,.1]) {
            Box(
                x_from = mm(-4.5/2 + pitch/2),
                x_size = mm(4.5),
                y_to   = mm(1.25),
                y_size = mm(12.5),
                z_to   = mm(1.5)
            );
        }
        for(x = [0:1], y =[-5:0]) {
            translate([x * pitch, y * pitch]) {
                Pin();
            }
        }
        
        module Pin() {
            Box(
                x_size = mm(.1),
                y_size = mm(.5),
                z_from = mm(-2.5),
                z_to   = mm(5.5)
            );
        }
    }
    module LayerProfileRemove() {
        BIAS = 0.01;
        Box(
            x_from = mm(-4.5/2 + pitch/2),
            x_size = mm(4.5),
            y_to   = mm(1.25),
            y_size = mm(12.5),
            z_from = -BIAS,
            z_to   = mm(1.5)
        );
    }
}
