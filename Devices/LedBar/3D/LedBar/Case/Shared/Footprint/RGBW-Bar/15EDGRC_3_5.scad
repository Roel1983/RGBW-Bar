use     <../../../../../../../Shared/3D/Utils/Units.scad>

15EDGRC_3_5(layer = "3D", pins = 3);

module 15EDGRC_3_5(layer = "3D", pins) {
    if (layer == "3D") {
        pitch = mm(3.5);
        a     = (pins - 1) * pitch;
        b     = mm(4.4);
        w     = a + b;
        d     = mm(9.2);
        h     = mm(7.25);
        front_to_pin = mm(8.0);
        
        translate([-(w-a)/2, -(d-front_to_pin)]) {
            cube([w,d,h]);
        }
    }
}