use     <../../../../../Shared/3D/Utils/Box.scad>

include <../../Config.inc>

use     <../Shared/Bridge.scad>
use     <../Shared/CaseBaseShape.scad>
use     <../Shared/PlaceFootprints.scad>
use     <../Shared/ScrewHoles.scad>
use     <../Shared/Guides.scad>
use     <Relief.scad>
use     <GitRevision.scad>
use     <CenterBoard.scad>
use     <ProfileScrewHoles.scad>

$fn = 16;

translate([0, 0, CASE_PCB_Z_BACK]) {
    *Mainboard();
}
Top();

module Top() {
    difference() {
        union() {
            difference() {
                union() {
                    intersection() {
                        union() {
                            CaseBasicShapeOuter();
                            Modifications("Case.Top.Add.Outer");
                        }
                        Box(
                            bounds = CASE_BOUNDS_XY,
                            z_from = CASE_PCB_Z_FRONT,
                            z_to   = CASE_HEIGHT_TOP
                        );
                    }
                    render() intersection() {
                        CaseBasicShapeOuterRelief();
                        Modifications("Case.Top.Relief");
                        Box(
                            bounds = bounds_margin(
                                        bounds = CASE_BOUNDS_XY,
                                        margin = mm(5)
                            ),
                            z_from = CASE_PCB_Z_FRONT,
                            z_to   = CASE_HEIGHT_TOP
                        );
                    }
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
        CenterBoard(layer);
        ScrewHoles(layer);
        Guides(layer);
        Bridge(layer);
        Relief(layer);
        GitRevision(layer);
        ProfileScrewHoles(layer);
    }
}
