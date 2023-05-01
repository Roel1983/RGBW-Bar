use     <../../../../../../../Shared/3D/Utils/Units.scad>

Perpendicular_pcb_1mm_female_2x6("Edge.Cuts");

module Perpendicular_pcb_1mm_female_2x6(layer = "3D") {
    if(layer == "Edge.Cuts") EdgeCuts();
    
    module EdgeCuts() {
        hull() {
            translate([0, inch( 0.04)]) circle(mm(0.52));
            translate([0, inch(-0.34)]) circle(mm(0.52));
        }
    }
}
