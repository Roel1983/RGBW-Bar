use     <../../../../../../../Shared/3D/Utils/Units.scad>

MountingHole_4_3mm_M4(layer = "Edge.Cuts");

module MountingHole_4_3mm_M4(layer) {
    if(layer == "Edge.Cuts") {
        circle(d = mm(4.3));
    }
}
