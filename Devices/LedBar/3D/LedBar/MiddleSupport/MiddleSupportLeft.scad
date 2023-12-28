//include <../../../../Shared/3D/Utils/Constants.inc>
//use     <../../../../Shared/3D/Utils/Git.scad>
//use     <../../../../Shared/3D/Utils/TransformCopy.scad>
//use     <../../../../Shared/3D/Utils/Units.scad>
use     <../../../../Shared/3D/KicadPcbComponent.scad>

use <../Shared/Support.scad>

include <../Config.inc>

$fn = 64;

MiddleSupportLeft();

module MiddleSupportLeft() {
    Support(
        height  = CASE_HEIGHT_TOP,
        width   = 2 * sqrt(.5) * (ANGLE_PROFILE_WIDTH - ANGLE_PROFILE_THICKENS),
        angle   = 0,
        is_open = false
    );
    
    echo(component_at_loc(COMPONENT_J1103)[Y]); // led 
    echo(component_at_loc(COMPONENT_J1101)[Y]);
    echo(component_at_loc(COMPONENT_H1102)[Y]); // Hole
}
