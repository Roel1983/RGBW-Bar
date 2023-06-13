use     <RGBW-Bar/RGBW-Bar.scad>
use     <MountingHole/MountingHole.scad>
use     <Capacitor_THT/Capacitor_THT.scad>
use     <LED_THT/LED_THT.scad>
use     <Battery/Battery.scad>
use     <Button_Switch_THT/Button_Switch_THT.scad>
use     <Button_Switch_SMD/Button_Switch_SMD.scad>
use     <Crystal/Crystal.scad>
use     <Connector_PinHeader_2_00mm/Connector_PinHeader_2_00mm.scad>
use     <Connector_PinHeader_2_54mm/Connector_PinHeader_2_54mm.scad>
use     <Resistor_SMD/Resistor_SMD.scad>
use     <Capacitor_SMD/Capacitor_SMD.scad>
use     <Jumper/Jumper.scad>
use     <Diode_SMD/Diode_SMD.scad>
use     <Capacitor_Tantalum_SMD/Capacitor_Tantalum_SMD.scad>

module Footprint(
    layer = "3D",
    footprint
) {
    if(footprint[0]        == "RGBW-Bar") {
        RGBW_Bar                  (layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "MountingHole") {
        MountingHole              (layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "Capacitor_THT") {
        Capacitor_THT             (layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "LED_THT") {
        LED_THT                   (layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "Battery") {
        Battery                   (layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "Button_Switch_THT") {
        Button_Switch_THT         (layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "Button_Switch_SMD") {
        Button_Switch_SMD         (layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "Crystal") {
        Crystal                   (layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "Connector_PinHeader_2.00mm") {
        Connector_PinHeader_2_00mm(layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "Connector_PinHeader_2.54mm") {
        Connector_PinHeader_2_54mm(layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "Resistor_SMD") {
        Resistor_SMD              (layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "Capacitor_SMD") {
        Capacitor_SMD             (layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "Jumper") {
        Jumper                    (layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "Diode_SMD") {
        Diode_SMD                 (layer = layer, footprint = footprint[1]);
    } else if(footprint[0] == "Capacitor_Tantalum_SMD") {
        Capacitor_Tantalum_SMD    (layer = layer, footprint = footprint[1]);
    }
}
