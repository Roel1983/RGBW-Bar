use     <../../../../../../../Shared/3D/Utils/Units.scad>

use <../Shared/SMD_HandSolder.scad>

R_2512_6332Metric_Pad1_40x3_35mm_HandSolder("3D");

module R_2512_6332Metric_Pad1_40x3_35mm_HandSolder(layer = "3D") {
    SMD_HandSolder(
        layer = layer,
        l = inch(0.25),
        w = inch(0.12),
        h = mm(0.6),
        
        solder_l = mm(3.05 * 2 + 1.4) ,
        solder_w = mm(3.35)
    );
}
