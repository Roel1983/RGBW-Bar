use     <../../../../../../../Shared/3D/Utils/Units.scad>

Crystal_HC49_U_Vertical(layer = "3D", h=mm(3.4));
    
module Crystal_HC49_U_Vertical(layer, h=mm(3.4)) {
    w   = mm(10.5);
    d   = mm( 3.8);
    rim = mm([0.25, 0.75]);
    pitch = mill(20);

    l = (w - d);

    if (layer == "3D") {
        translate([pitch/2,0]) {
            shape(d + rim[0] * 2, rim[1]);
            shape(d, h);
        }
    }
    
    module shape(d, h) {
        linear_extrude(h) hull() {
            translate([-l/2, 0]) circle(d=d);
            translate([ l/2, 0]) circle(d=d);
        }
    }
}