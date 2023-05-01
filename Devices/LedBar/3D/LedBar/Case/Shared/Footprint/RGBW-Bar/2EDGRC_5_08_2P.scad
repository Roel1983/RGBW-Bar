use     <../../../../../../../Shared/3D/Utils/Units.scad>

2EDGRC_5_08_2P(layer = "3D");

module 2EDGRC_5_08_2P(layer, pins = 3) {
    if (layer == "3D") {
        pitch = inch(0.20);
        a     = (pins - 1) * pitch;
        b     = mm(5.2);
        w     = a + b;
        d     = mm(12.2);
        h     = mm(7.8);
        front_to_pin = mm(10.25);
        echo(w);
        
        translate([-(w-a)/2, -(d-front_to_pin)]) {
            cube([w,d,h]);
        }
    }
}
