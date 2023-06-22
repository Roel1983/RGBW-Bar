use     <../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../../Shared/3D/Utils/Units.scad>

include <../../Config.inc>

Relief("Case.Top.Relief");

module Relief(layer) {
    if (layer == "Case.Top.Relief") {
        render() {
            ProductTitle();
            SideConnectorLabels();
            RS485ConnectorLabel();
            AuxConnectorLabel();
            PowerConnectorLabel();
        }
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