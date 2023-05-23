use     <../../../../../../../Shared/3D/Utils/Units.scad>

TestPoint_Pad(layer = "3D", D = mm(1.0));

module TestPoint_Pad(layer, D = mm(1.0)) {
    if (layer == "3D") {
        Layer3D();
    }
    
    module Layer3D() {
        color("silver") {
            cylinder(d=D, h = layer(1));
        }
    }
}
