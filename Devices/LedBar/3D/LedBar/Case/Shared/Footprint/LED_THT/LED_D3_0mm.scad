use     <../../../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

LED_D3_0mm(layer = "3D", h=1.0);

module LED_D3_0mm(layer, h) {
    d1 = mm(3.0);
    d2 = mm(3.5);
    t  = mm(1.0);
    h1 = mm(5.1);
    pitch = mill(100);
    h_cylinder = h1-d1/2;
    BIAS = 0.1;
    if(layer == "3D") {
        translate([pitch/2,0]) {
            translate([0, 0, h]) Head();
        }
        Pin();
        translate([pitch, 0 ]) Pin();
    }
    module Pin() {
        Box(x_size = mm(0.5), y_size = mm(0.5), z_from = mm(-3), z_to = h);
    }
    module Head() {
        render() {
            linear_extrude(t)intersection() {
                circle(d=d2);
                translate([(d2-d1)/2,0])square(d2, center=true);
            }
            cylinder(d=d1, h=h_cylinder);
            translate([0,0,h_cylinder]) sphere(d=d1);
        }
    }
}