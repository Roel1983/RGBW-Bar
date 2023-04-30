use     <../../../../../../../Shared/3D/KicadPcbComponent.scad>
use     <../../../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../../../../Shared/3D/Utils/TransformIf.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>
use     <../../Footprint/Footprint.scad>
use     <../../PlaceFootprints.scad>

include <MainboardKicadPcb.inc>

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