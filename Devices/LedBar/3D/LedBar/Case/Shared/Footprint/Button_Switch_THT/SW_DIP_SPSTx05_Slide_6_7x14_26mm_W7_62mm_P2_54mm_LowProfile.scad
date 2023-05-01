include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/TransformIf.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

SW_DIP_SPSTx05_Slide_6_7x14_26mm_W7_62mm_P2_54mm_LowProfile(layer = "3D", channels = 2);

module SW_DIP_SPSTx05_Slide_6_7x14_26mm_W7_62mm_P2_54mm_LowProfile(
    layer    = "3D",
    channels = 2
) {
    if (layer == "3D") {
        pitch = mill([100, 300]);
        
        a     = (channels - 1) * pitch[0];
        w     = a + mm(4.0);
        d     = mm(9.9);
        h     = mm(4.9);
        
        rotate(-90)translate([0, -(d-pitch[1])/2]) {
            difference() {
                translate([-(w-a)/2, 0]) {
                    cube([w, d, h]);
                }
                for(i=[0:channels-1]) translate([pitch[0]*i,d/2, h]) {
                    cube([pitch[0]-nozzle(2), mm(3.75), mm(2.0)], center=true);
                }
            }
            pattern = [0,1,1,0,1];
            for(i=[0:channels-1]) translate([pitch[0]*i,d/2, h]) {
                mirror_if(pattern[i % 5], VEC_Y) {
                    translate([0,(mm(3.75)-nozzle(4))/2]) {
                        cube([pitch[0]-nozzle(2), nozzle(4), mm(2.1)], center=true);
                    }
                }
            }
        }     
    }
}