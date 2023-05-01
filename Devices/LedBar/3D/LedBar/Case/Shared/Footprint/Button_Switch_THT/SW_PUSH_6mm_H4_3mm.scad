include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

SW_PUSH_6mm_H4_3mm(layer = "3D", h=mm(4.3));

module SW_PUSH_6mm_H4_3mm(layer, h=mm(4.3)) {
    if(layer == "3D") {
        BIAS  = 0.1;
        size  = mm(6.0);
        pitch = mm([6.5, 4.5]);
        pin_size = mm([.7,.7]);
        h1    = mm(3.5);
        d1    = mm(3.5);
        d2    = mm(1.3);
        l2    = mm(4.0);
        h2    = mm(0.5);
        translate([pitch[0]/2, -pitch[1]/2]) {
            linear_extrude(h1) hull() {
                $fn=16;
                mirror_copy(VEC_X) mirror_copy(VEC_Y) {
                    r = mm(.5);
                    translate(mm([(size-r)/2 ,(size-r)/2])) circle(r=r);
                }
            }
            mirror_copy(VEC_X) mirror_copy(VEC_Y) {
                $fn=16;
                translate([l2/2,l2/2,h1]) {
                    cylinder(d=d2,h=h2*2, center=true);
                }
            }
            translate([0,0,h1-BIAS]) {
                cylinder(d=d1, h=h-h1+BIAS);
            }
            mirror_copy(VEC_Y) {
                translate([0,pitch[1]/2, mm(1)/2]) {
                    cube([pitch[0]+2*pin_size[0], pin_size[1], mm(1)], center=true);
                }
            }
        }
    }
}