use     <../../../../../../../Shared/3D/Utils/Units.scad>
$fn = 32;

Crystal_HC49_U_Vertical(layer = "3D", h=mm(3.4));
    
module Crystal_HC49_U_Vertical(layer, h=mm(3.4)) {
    w   = mm(10.5);
    d   = mm( 3.8);
    rim = mm([0.25, 0.75]);
    pitch = mill(200);

    l = (w - d);

    if (layer == "3D") {
        Layer3D();
    }
    
    module Layer3D() {
        color("silver") {
            translate([pitch/2,0]) {
                shape(d + rim[0] * 2, rim[1]);
                shape(d, h);
            }
            
            for(x = [0, pitch]) translate([x, 0]) {
                Pin();
            }
        }
        
        module shape(d, h) {
            linear_extrude(h) hull() {
                translate([-l/2, 0]) circle(d=d);
                translate([ l/2, 0]) circle(d=d);
            }
        }
        
        module Pin() {
            pin_length   = mm(3.5);
            pin_diameter = mm(0.4);
            BIAS = 0.1;
            
            translate([0, 0, -pin_length]) {
                cylinder(d = pin_diameter, h = pin_length + BIAS);
            }
        }
    }
}