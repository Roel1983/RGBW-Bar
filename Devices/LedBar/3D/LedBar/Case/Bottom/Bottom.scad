use     <../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../Shared/3D/Utils/Git.scad>
use     <../../../../../Shared/3D/Utils/LinearExtrude.scad>
include <../../Config.inc>

include <../Shared/Boards/Mainboard/MainboardKicadPcb.inc>
use     <../Shared/Boards/Mainboard/Mainboard.scad>

use     <../Shared/CaseBaseShape.scad>
use     <../Shared/PlaceFootprints.scad>
use     <../Shared/ScrewHoles.scad>
use     <../Shared/Connectors.scad>
use     <../Shared/Guides.scad>
use     <../Shared/MountingFeet.scad>

    translate([0, 0, CASE_PCB_Z_BACK]) {
    *Mainboard();
}
Bottom();

module Bottom() {
    difference() {
        union() {
            difference() {
                intersection() {
                    CaseBasicShapeOuter();
                    Box(
                        bounds = CASE_BOUNDS_XY,
                        z_to   = CASE_PCB_Z_FRONT
                    );
                }
                difference() {
                    CaseBasicShapeInner();
                    Modifications("Case.Bottom.Add.Inner");
                }
            }
            Modifications("Case.Bottom.Add");
        }
        Modifications("Case.Remove");
        Modifications("Case.Bottom.Remove");
    }
    
    module Modifications(layer) {
        ScrewHoles(layer);
        Connectors(layer);
        translate([0, 0, CASE_PCB_Z_BACK]) {
            PlaceFootprints(
                ALL_COMPONENTS_MAINBOARD,
                layer,
                PCB_THICKNESS_MAINBOARD);
        }
        Guides(layer);
        GitRevision(layer);
        MountingFeet(layer);
        SmdBack(layer);
    }
    
    module SmdBack(layer) {
        if(layer=="Case.Bottom.Remove") {
            translate([0, 0, CASE_PCB_Z_BACK]) {
                BIAS = 0.01;
                LinearExtrude(
                    z_to   = BIAS,
                    z_from = -mm(1.0)
                ) {
                    glue = nozzle(2);
                    offset(delta=-glue) offset(delta=glue) {
                        PlaceFootprints(
                            ALL_COMPONENTS_MAINBOARD,
                            "Smd.Back.1mm");
                    }
                }
            }
        }
    }
    
    module GitRevision(layer) {
        if (layer == "Case.Bottom.Remove") {
            LayerCaseBottomRemove();
        }
        module LayerCaseBottomRemove() {
            translate([0,mm(-15), CASE_WALL_THICKNESS_BOTTOM]) {
                linear_extrude(layer(2), center=true) borderize() CommitText();
            }
        }
        module borderize() {
            $fn = 32;
            difference() {
                hull() offset(2) offset(-2) offset(mm(1.0)) hull() children();
                children();
            }
        }
    }
}

