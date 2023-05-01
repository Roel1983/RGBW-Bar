include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

Crystal_C38_LF_Horizontal_1EP_style1(layer = "3D", D=mm(3.0), L=mm(8.0));

module Crystal_C38_LF_Horizontal_1EP_style1(layer, D=mm(3.0), L=mm(8.0)) {
    if (layer == "3D") {
        pitch = mm(1.9);
        translate([0, mm(-2.3), D/2])
        rotate(90, VEC_X) cylinder(d=D, h=L);
    }
}
