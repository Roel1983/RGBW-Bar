use     <../../../../../../../Shared/3D/Utils/Units.scad>

use <../Shared/SMD_HandSolder.scad>

R_0805_2012Metric_Pad1_20x1_40mm_HandSolder("3D");

module R_0805_2012Metric_Pad1_20x1_40mm_HandSolder(layer = "3D") {
    SMD_HandSolder(
        layer = layer,
        l = inch(0.08),
        w = inch(0.05),
        h = mm(0.45),
        
        solder_l = mm(3.2),
        solder_w = mm(1.4)
    );
}
