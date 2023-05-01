use     <../../../../../../../Shared/3D/Utils/Units.scad>

B0505S_1W("3D");

module B0505S_1W(layer) {
    if (layer == "3D") {
        pitch = mill(10);
        w  = mm(11.6);
        d  = mm( 6.1);
        h  = mm(10.0);
        py = mm(-0.7);
        px = -(w - pitch * 3) / 2;
        translate([px, py]) cube([w, d, h]);
    }
}
