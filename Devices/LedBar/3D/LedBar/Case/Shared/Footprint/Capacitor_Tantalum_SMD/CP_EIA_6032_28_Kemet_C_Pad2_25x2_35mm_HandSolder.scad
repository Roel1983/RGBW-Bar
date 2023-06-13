use     <../../../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/Units.scad>
$fn = 32;

CP_EIA_6032_28_Kemet_C_Pad2_25x2_35mm_HandSolder(layer = "3D");
#CP_EIA_6032_28_Kemet_C_Pad2_25x2_35mm_HandSolder(layer = "Case.Remove");
#CP_EIA_6032_28_Kemet_C_Pad2_25x2_35mm_HandSolder(layer = "Smd.Back.1mm");

module CP_EIA_6032_28_Kemet_C_Pad2_25x2_35mm_HandSolder(layer) {
    if (layer == "3D") {
        Layer3D();
    } else if (layer == "Case.Remove") {
        LayerCaseRemove();
    } else if (layer == "Smd.Back.1mm") {
        LayerSmdBack1mm();
    }
    
    module Layer3D() {
        color("yellow") Box(
            x_size = mm(5.6),
            y_size = mm(3.3),
            z_to   = mm(2.8)
        );
    }
    
    module LayerCaseRemove() {
        Box(
            x_size = mm(6.0),
            y_size = mm(3.7),
            z_to   = mm(3.0)
        );
    }
    
    module LayerSmdBack1mm() {
        Box(
            x_size = mm(7.84),
            y_size = mm(3.70)
        );
    }
}
