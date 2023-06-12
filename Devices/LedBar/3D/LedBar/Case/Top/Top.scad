use     <../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../Shared/3D/Utils/Git.scad>

include <../../Config.inc>

include <../Shared/Boards/Mainboard/MainboardKicadPcb.inc>
use     <../Shared/Boards/Mainboard/Mainboard.scad>

use     <../Shared/Bridge.scad>
use     <../Shared/CaseBaseShape.scad>
use     <../Shared/PlaceFootprints.scad>
use     <../Shared/ScrewHoles.scad>
use     <../Shared/Guides.scad>

$fn = 16;

translate([0, 0, CASE_PCB_Z_BACK]) {
    *Mainboard();
}
Top();

module Top() {
    difference() {
        union() {
            difference() {
                intersection() {
                    union() {
                        CaseBasicShapeOuter();
                        Modifications("Case.Top.Add.Outer");
                        intersection() {
                            CaseBasicShapeOuterRelief();
                            Modifications("Case.Top.Relief");
                        }
                    }
                    Box(
                        bounds = CASE_BOUNDS_XY,
                        z_from = CASE_PCB_Z_FRONT,
                        z_to   = CASE_HEIGHT_TOP
                    );
                }
                difference() {
                    CaseBasicShapeInner();
                    Modifications("Case.Top.Add.Inner");
                }
            }
            intersection() {
                translate([0, 0, CASE_PCB_Z_BACK]) {
                    PlaceFootprints(
                        ALL_COMPONENTS_MAINBOARD,
                        "Case.Top.Add.Outer.NoBevel",
                        PCB_THICKNESS_MAINBOARD
                    );
                }
                CaseBasicShapeOuter(no_bevel = true);
            }
        }
        Modifications("Case.Remove");
        Modifications("Case.Top.Remove");
        intersection() {
            Modifications("Case.Top.Remove.Inner");
            CaseBasicShapeInner();
        }
    }
    
    module Modifications(layer) {
        translate([0, 0, CASE_PCB_Z_BACK]) {
            PlaceFootprints(
                ALL_COMPONENTS_MAINBOARD,
                layer,
                PCB_THICKNESS_MAINBOARD
            );
        }
        ScrewHoles(layer);
        Guides(layer);
        Bridge(layer);
        ProductDescription(layer);
        GitRevision(layer);
    }
    
    module ProductDescription(layer) {
        if (layer == "Case.Top.Relief") {
            linear_extrude(CASE_HEIGHT_TOP) {
                translate([
                    0,
                    mm(26)
                ]) {
                    rotate(180) {
                        offset(mm(.1)) text(
                            "LedBar",
                            size = 8,
                            font = "Arial",
                            halign = "center",
                            valign = "center"
                        );
                    }
                }
            }
        }
    }
    
    module GitRevision(layer) {
        if (layer == "Case.Top.Add.Inner") {
            LayerCaseTopAddInner();
        }
        module LayerCaseTopAddInner() {
            translate([
                CASE_BOUNDS_XY[X][0] + CASE_WALL_THICKNESS_VERTICAL,
                mm(0),
                CASE_PCB_Z_FRONT + mm(12)
            ]) {
                rotate(90) rotate(90, VEC_X) {
                    linear_extrude(nozzle(2), center = true) {
                        offset(mm(.1)) CommitText(size=mm(5));
                    }
                }
            }
        }
    }
}