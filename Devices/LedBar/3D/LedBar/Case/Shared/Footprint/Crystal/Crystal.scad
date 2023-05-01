use     <../../../../../../../Shared/3D/Utils/Units.scad>

use <Crystal_C38_LF_Horizontal_1EP_style1.scad>
use <Crystal_HC49_U_Vertical.scad>

module Crystal(layer, footprint) {
    if(footprint == "Crystal_HC49-U_Vertical") {
        Crystal_HC49_U_Vertical(layer = layer);
    } else if(footprint == "Crystal_C38-LF_D3.0mm_L8.0mm_Horizontal_1EP_style1") {
        Crystal_C38_LF_Horizontal_1EP_style1(layer = layer, D=mm(3.0), L=mm(8.0));
    }
}