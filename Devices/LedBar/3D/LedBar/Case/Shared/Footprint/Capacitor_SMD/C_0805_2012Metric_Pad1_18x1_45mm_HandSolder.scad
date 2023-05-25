use     <../../../../../../../Shared/3D/Utils/Units.scad>

use <../Shared/SMD_HandSolder.scad>

C_0805_2012Metric_Pad1_18x1_45mm_HandSolder("3D");

module C_0805_2012Metric_Pad1_18x1_45mm_HandSolder(layer = "3D") {
    SMD_HandSolder(
        layer = layer,
        l = inch(0.08),
        w = inch(0.05),
        h = mm(0.45),
        
        solder_l = mm(3.0),
        solder_w = mm(1.9)
    );
}
