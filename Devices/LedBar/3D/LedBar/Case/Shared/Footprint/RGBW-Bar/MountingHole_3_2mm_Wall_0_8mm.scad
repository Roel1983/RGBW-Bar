use     <../../../../../../../Shared/3D/Utils/Units.scad>

$fn=32;

MountingHole_3_2mm_Wall_0_8mm("Edge.Cuts");

module MountingHole_3_2mm_Wall_0_8mm(layer) {
    if(layer == "Edge.Cuts") {
        circle(d = mm(3.2));
    }
}
