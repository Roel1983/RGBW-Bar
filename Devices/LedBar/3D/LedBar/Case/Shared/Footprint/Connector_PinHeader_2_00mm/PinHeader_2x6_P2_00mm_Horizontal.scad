include <../../../../Config.inc>

use     <../../../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../../../Shared/3D/Utils/LinearExtrude.scad>

$fn = 32;

PinHeader_2x6_P2_00mm_Horizontal(layer = "3D");
%difference() {
    PinHeader_2x6_P2_00mm_Horizontal(layer = "Case.Top.Add.Inner");
    PinHeader_2x6_P2_00mm_Horizontal(layer = "Case.Remove");
}

module PinHeader_2x6_P2_00mm_Horizontal(layer) {
    if (layer == "3D") {
        Layer3D();
    } else if (layer == "Case.Remove") {
        LayerCaseRemove();
    } else if (layer == "Case.Top.Remove.Inner") {
        LayerCaseTopRemoveInner();
    } else if (layer == "Case.Top.Add.Inner") {
        LayerCaseTopAddInner();
    }
    pitch = mm(2.00);
    
    module Layer3D() {
        color([.1,.1,.1]) {
            Box(
                x_from = mm(-4.5/2 + pitch/2),
                x_size = mm(4.5),
                y_to   = mm(1.25),
                y_size = mm(12.5),
                z_to   = mm(4.25)
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
                z_from = mm(-2.5)
            );
        }
    }
    
    module LayerCaseRemove() {
        clearance = mm(.1);
        Box(
            x_from = mm(-4.5/2 + pitch/2) - clearance,
            x_size = mm(4.5) + 2 * clearance,
            y_to   = mm(1.25) + clearance,
            y_size = mm(12.5) + 2 * clearance,
            z_to   = mm(10.0)
        );
    }
    
    module LayerCaseTopRemoveInner() {
        clearance = mm(.2);
        Box(
            x_from = mm(-4.5/2 + pitch/2) - clearance,
            x_size = mm(4.5) + 2 * clearance,
            y_to   = mm(1.25) + clearance,
            y_size = mm(12.5) + 2 * clearance,
            z_from = mm(-5),
            z_to   = mm(10.0)
        );
    }
    
    module LayerCaseTopAddInner() {
        wall = nozzle(2);
        clearance_and_wall = mm(.2) + wall;
        z_from_1 = mm(3.5);
        z_from_2 = mm(2.0);
        z_to   = mm(4.5);
        x_from = mm(-4.5/2 + pitch/2) - clearance_and_wall;
        x_size = mm(4.5) + 2 * clearance_and_wall;
        render(2) {
            LinearExtrude(
                x_from = x_from,
                x_size = nozzle(2)
            ) {
                Support2d();
            }
            LinearExtrude(
                x_to = x_from + x_size,
                x_size = nozzle(2)
            ) {
                Support2d();
            }
            
            hull() {
                b = nozzle(2) / sqrt(2);
                BIAS = 0.1;
                Box(
                    x_from = mm(-4.5/2 + pitch/2) - clearance_and_wall + BIAS,
                    x_size = mm(4.5) + 2 * clearance_and_wall - 2*BIAS,
                    y_to   = mm(1.25) + clearance_and_wall,
                    y_size = mm(12.5) + 2 * clearance_and_wall - b,
                    z_from = z_from_1,
                    z_to   = z_to
                );
                Box(
                    x_from = mm(-4.5/2 + pitch/2) - clearance_and_wall + BIAS,
                    x_size = mm(4.5) + 2 * clearance_and_wall - 2*BIAS,
                    y_to   = mm(1.25) + clearance_and_wall,
                    y_size = mm(12.5) + 2 * clearance_and_wall,
                    z_from = z_from_1 + b,
                    z_to   = z_to
                );
            }
        }
        module Support2d() {
            y_to   = mm(1.25) + clearance_and_wall;
            y_size = mm(12.5) + 2 * clearance_and_wall;
            polygon([
                [y_to - y_size, z_from_2],
                [y_to         , z_from_2],
                [y_to         , z_to],
                [y_to - y_size - 2*(z_to - z_from_2), z_to],
            ]);
        }
    }
}
