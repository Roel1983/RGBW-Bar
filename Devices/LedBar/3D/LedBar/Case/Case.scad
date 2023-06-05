use <Bottom/Bottom.scad>
use <Top/Top.scad>
use <Shared/Boards/CaseBoards.scad>
include <../Config.inc>

if($vpr[0] < 90) {
    color("white") render() Bottom();
    translate([0, 0, CASE_PCB_Z_BACK]) CaseBoards();
    color("white", alpha=0.5) render() Top();
} else {
    color("white") render() Top();
    translate([0, 0, CASE_PCB_Z_BACK]) CaseBoards();
    color("white", alpha=0.5) render() Bottom();
}
