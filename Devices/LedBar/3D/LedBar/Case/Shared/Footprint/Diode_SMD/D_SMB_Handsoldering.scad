use     <../../../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

#D_SMB_Handsoldering("Case.Remove");

module D_SMB_Handsoldering(layer) {
    if (layer == "Case.Remove") {
        LayerCaseRemove();
    }
    
    module LayerCaseRemove() {
        BIAS = .01;
        Box(
            x_size = mm(9.4),
            y_size = mm(4.5),
            z_from = -BIAS,
            z_to   = mm(1.0)
        );
        Box(
            x_size = mm(5.1),
            y_size = mm(4.5),
            z_from = -BIAS,
            z_to   = mm(2.6)
        );
    }
}