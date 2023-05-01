use <../Footprint.scad>

MountingHole_4_3mm_M4_modified1("Edge.Cuts");

module MountingHole_4_3mm_M4_modified1(layer) {
    Footprint(
        layer = layer,
        footprint = ["MountingHole", "MountingHole_4.3mm_M4"]
    );
}
