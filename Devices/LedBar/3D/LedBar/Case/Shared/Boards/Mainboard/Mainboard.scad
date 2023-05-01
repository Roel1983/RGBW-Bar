use     <../../../../../../../Shared/3D/Utils/Box.scad>
use     <../../Footprint/Footprint.scad>
use     <../../PlaceFootprints.scad>

include <MainboardKicadPcb.inc>

$fn = 32;
Mainboard();

module Mainboard() {
    linear_extrude(PCB_THICKNESS_MAINBOARD) {
        difference() {
            Box(bounds = PCB_BOUNDS_MAINBOARD);
            PlaceFootprints(ALL_COMPONENTS_MAINBOARD, "Edge.Cuts");
        }
    }
    PlaceFootprints(ALL_COMPONENTS_MAINBOARD, "3D", PCB_THICKNESS_MAINBOARD);
}