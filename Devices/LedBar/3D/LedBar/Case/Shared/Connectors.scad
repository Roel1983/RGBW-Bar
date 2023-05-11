include <../../Config.inc>

use     <../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../Shared/3D/Utils/Units.scad>
include <../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../Shared/3D/KicadPcbComponent.scad>

Connectors("Case.Bottom.Add.Inner");

module Connectors(layer) {
    if (layer == "Case.Bottom.Add.Inner") {
        LayerCaseBottomAddInner();
    }
    
    module LayerCaseBottomAddInner() {
        BIAS = 0.1;
        
        PAD_SIZE_15EDGRC_3_5 = mm(2.0);
        wall                 = nozzle(2);
        
        Box(
            x_bounds = CASE_BOUNDS_XY[X],
            y_from   = CASE_BOUNDS_XY[Y][0],
            y_to     = component_at_loc(COMPONENT_J601)[Y] + PAD_SIZE_15EDGRC_3_5 / 2 + wall,
            z_from   = BIAS,
            z_to     = CASE_PCB_Z_BACK
        );
    }
}
