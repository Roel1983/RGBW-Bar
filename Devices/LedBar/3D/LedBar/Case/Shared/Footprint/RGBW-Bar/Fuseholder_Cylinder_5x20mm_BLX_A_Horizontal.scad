use     <../../../../../../../Shared/3D/Utils/Units.scad>

Fuseholder_Cylinder_5x20mm_BLX_A_Horizontal(layer = "3D");

module Fuseholder_Cylinder_5x20mm_BLX_A_Horizontal(layer) {
    if(layer == "3D") {
        w  = mm(28.3);
        d  = mm(10.0);
        h  = mm(13.6);
        px = mm(-4.0);
        translate([
            px,
            -d/2
        ]) cube([
            w, d, h
        ]);
    }
}
