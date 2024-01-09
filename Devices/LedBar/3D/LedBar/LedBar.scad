include <Config.inc>
use     <Case/Case.scad>
use     <LedProfile/LedProfile.scad>
use     <Support/MiddleSupport.scad>

$vpr = [ 43.10, 0.00, 202.70 ];
$vpd = 288.05;

translate([0,0,CASE_HEIGHT_TOP]) rotate(-45, VEC_X) {
    LedProfile();
}
Case();

color("white") {
    translate([-70, 0]) MiddleSupport();
    translate([ 70, 0]) MiddleSupport();
}
