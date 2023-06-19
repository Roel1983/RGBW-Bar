use <Bottom/Bottom.scad>
use <Top/Top.scad>
use <Shared/Boards/Mainboard/Mainboard.scad>
include <../Config.inc>

Case(see_in_side=true);

module Case(see_in_side=false) {
    alpha = see_in_side?0.5:1.0;
    if($vpr[0] < 90) {
        color("white") render() Bottom();
        translate([0, 0, CASE_PCB_Z_BACK]) Mainboard();
        color("white", alpha=alpha) render() Top();
    } else {
        color("white") render() Top();
        translate([0, 0, CASE_PCB_Z_BACK]) Mainboard();
        color("white", alpha=alpha) render() Bottom();
    }
}