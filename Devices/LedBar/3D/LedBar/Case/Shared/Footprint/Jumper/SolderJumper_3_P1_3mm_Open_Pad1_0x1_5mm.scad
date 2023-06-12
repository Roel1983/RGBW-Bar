use     <../../../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

#SolderJumper_3_P1_3mm_Open_Pad1_0x1_5mm("Smd.Back.1mm");

module SolderJumper_3_P1_3mm_Open_Pad1_0x1_5mm(layer) {
    if (layer == "Smd.Back.1mm") {
        LayerSmdBack1mm();
    }
    
    module LayerSmdBack1mm() {
        BIAS = .01;
        Box(
            x_size = mm(4.6),
            y_size = mm(2.5)
        );
    }
}