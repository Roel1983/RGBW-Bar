use     <../../../../../Shared/3D/Utils/Box.scad>
include <../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../../Shared/3D/Utils/Git.scad>
use     <../../../../../Shared/3D/KicadPcbComponent.scad>

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
                    intersection() {
                        CaseBasicShapeOuterRelief();
                        Modifications("Case.Top.Relief");
                        Box(
                            bounds = bounds_margin(bounds=CASE_BOUNDS_XY, margin=mm(5)),
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
        render()Relief(layer);
        GitRevision(layer);
    }
    
    module Relief(layer) {
        if (layer == "Case.Top.Relief") {
            ProductTitle();
            SideConnectorLabels();
            RS485ConnectorLabel();
            AuxConnectorLabel();
            PowerConnectorLabel();
        }
        
        module ProductTitle() {
            linear_extrude(CASE_HEIGHT_TOP) {
                translate([
                    0,
                    mm(27)
                ]) {
                    rotate(180) {
                        offset(mm(.12)) text(
                            "LedBar",
                            size = 5,
                            font = "Arial",
                            halign = "center",
                            valign = "center"
                        );
                    }
                }
            }
        }
        
        module SideConnectorLabels() {
            pitch = mill(100);
            translate(component_at_loc(COMPONENT_J503)) {
                translate([
                    0,
                    -pitch * 2,
                    CASE_PCB_Z_FRONT + mm(12)
                ]) {
                    rotate(90, VEC_Y) rotate(90) {
                        linear_extrude(mm(20)) offset(mm(.1)) text(
                            "R",size = 8,
                            font = "Arial",
                            halign = "center",
                            valign = "center"
                        );
                    }
                }
            }
            translate(component_at_loc(COMPONENT_J501)) {
                translate([
                    0,
                    pitch * 2,
                    CASE_PCB_Z_FRONT + mm(12)
                ]) {
                    rotate(-90, VEC_Y) rotate(-90) {
                        linear_extrude(mm(20)) text(
                            "L",size = 8,
                            font = "Arial",
                            halign = "center",
                            valign = "center"
                        );
                    }
                }
            }
        }
        
        module RS485ConnectorLabel() {
            ConnectorPinLables(COMPONENT_J401, mm(3.5), "RS485") {
                PinGnd();
                Pin("A");
                Pin("B");
            }
        }
        
        module AuxConnectorLabel() {
            ConnectorPinLables(COMPONENT_J601, mm(3.5), "OUT") {
                PinGnd();
                Pinout();
            }
        }
        
        module PowerConnectorLabel() {
            ConnectorPinLables(COMPONENT_J301, mm(5.0), "PWR") {
                PinGnd();
                Pin("+");
            }
        }
        
        module ConnectorPinLables(component, pitch, label) {
            translate(component_at_loc(component)) {
                translate([-($children - 1) / 2 * pitch, mm(2)]) {
                    linear_extrude(CASE_HEIGHT_TOP) {
                        offset(delta=mm(.19)) text(
                            label,
                            size = mm(3.5),
                            font = "Arial",
                            halign = "center",
                            valign = "center"
                        );
                    }
                }
                for (i=[0:$children - 1]) {
                    translate([-i * pitch, mm(-2.5)]) {
                        linear_extrude(CASE_HEIGHT_TOP) {
                            children(i);
                        }
                    }
                }
            }
        }
        
        module Pin(text) {
            offset(delta=mm(.18)) text(
                text,
                size = mm(3.5),
                font = "Arial",
                halign = "center",
                valign = "center"
            );
        }
        
        module PinGnd() {
            Box(
                x_size = nozzle(2),
                y_size = mm(3.5)
            );
            Box(
                x_size = mm(3),
                y_size = nozzle(2),
                y_from = -mm(3.5) / 2
            );
        }
        
        module Pinout() {
            Box(
                x_size = nozzle(2),
                y_to   = mm(3.5) / 2,
                y_size = mm(3.0)
            );
            translate([0, -mm(3.5) / 2]) {
                mirror_copy(VEC_X) rotate(-45) Box(
                    x_to = 0,
                    x_size = mm(2),
                    y_size = nozzle(2),
                    y_from   = 0
                );
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
    module CenterBoard(layer) {
        translate([0, 0, CASE_HEIGHT_TOP]) {
            rotate(-45, VEC_X) {
                translate([
                    0,
                    -ANGLE_PROFILE_THICKENS + ANGLE_PROFILE_WIDTH / 2
                ]) {

                    translate(-CENTER_BOARD_CENTER) {
                        PlaceFootprints(
                            [COMPONENT_H1204, COMPONENT_J1202],
                            layer,
                            PCB_THICKNESS_SUBBOARDS
                        );
                    }
//                    translate(-CENTER_BOARD_CENTER) ComponentPosition(
//                        COMPONENT_H1204, pcb_thickness = PCB_THICKNESS_SUBBOARDS
//                    ) {
//                        #cube(2, center=true);
//                    }
                }
            }
        }
    }
}
