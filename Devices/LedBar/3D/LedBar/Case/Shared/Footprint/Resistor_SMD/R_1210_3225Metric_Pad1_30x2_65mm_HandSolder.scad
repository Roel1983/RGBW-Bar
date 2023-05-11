use     <../../../../../../../Shared/3D/Utils/Units.scad>

use <R_HandSolder.scad>

R_1210_3225Metric_Pad1_30x2_65mm_HandSolder("3D");

module R_1210_3225Metric_Pad1_30x2_65mm_HandSolder(layer = "3D") {
    R_HandSolder(
        layer = layer,
        l = inch(0.12),
        w = inch(0.10),
        h = mm(0.55),
        
        solder_l = mm(1.55 * 2 + 1.3) ,
        solver_w = mm(2.65)
    );
}
