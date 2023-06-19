use     <../../../../../../../Shared/3D/Utils/Hex.scad>
use     <../../../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

$fn=$preview?16:32;

MountingHole_3_2mm_Wall_0_8mm("Edge.Cuts");
#MountingHole_3_2mm_Wall_0_8mm("Case.Top.Remove");

module MountingHole_3_2mm_Wall_0_8mm(layer) {
    if(layer == "Edge.Cuts") {
        circle(d = mm(3.2));
    } else if(layer == "Case.Top.Remove") {
        LayerCaseTopRemove();
    } else if(layer == "Profile.Remove") {
        LayerProfileRemove();
    }
    
    module LayerCaseTopRemove() {
        ScrewHole();
        NutSlot();
    }
    
    module LayerProfileRemove() {
        ScrewHole();
    }
    
    screw_length   = mm(9.0);
    screw_diameter = mm(3.0);
        
    module ScrewHole() {
        translate([0,0,-screw_length]) {
            cylinder(d = screw_diameter, h =screw_length);
        }
    }
    
    module NutSlot() {
        LinearExtrude(z_size=mm(2.75), z_to = mm(-3.5)) {
            hull() {
                Hex(5.6);
                translate([0, 10])Hex(5.6);
            }
        }
    }
}
