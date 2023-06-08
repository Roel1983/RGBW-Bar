use     <../../../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>
use <../Footprint.scad>

MountingHole_4_3mm_M4_modified1("Edge.Cuts");
!MountingHole_4_3mm_M4_modified1("Case.Top.Remove");

module MountingHole_4_3mm_M4_modified1(layer) {
    if (layer == "Case.Top.Remove") {
        LayerCaseTopRemove();
    }
    else {
        Footprint(
            layer = layer,
            footprint = ["MountingHole", "MountingHole_4.3mm_M4"]
        );
    }
    
    module LayerCaseTopRemove() {
        BIAS = 0.1;
        Box(
            x_from = mm(-5.0),
            x_to   = mm( 2.5),
            y_to   = mm(-2.6),
            y_from = mm(-5.0),
            z_from = -BIAS,
            z_to   = mm(0.7)
        );
    }
}
