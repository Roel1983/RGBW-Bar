use     <../../../../../../../Shared/3D/Utils/Units.scad>

ISP_single_row(layer = "Edge.Cuts", P = mm(1.27));

module ISP_single_row(layer, P = mm(1.27)) {
    if(layer == "Edge.Cuts") {
        pins  = 6;
        pins_size = mm(.47);
        
        for(i=[0:pins-1]) translate([0,-i*P]) {
            circle(d=pins_size);
        }
    }
}
