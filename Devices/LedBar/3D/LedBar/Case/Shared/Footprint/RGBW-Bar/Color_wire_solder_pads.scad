use     <../../../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

Color_wire_solder_pads(layer = "3D", channels = "RGBW", side = "R", pitch = mm(2.0));

module Color_wire_solder_pads(layer, channels, side, pitch) {
    if (layer == "3D") {
        Layer3D();
    }
    
    module Layer3D() {
        color("silver") {
            linear_extrude(layer(1)) {
                PinRectangle();
                for(i=[1:len(channels)]) translate([0, -i * pitch]) {
                    PinOval();
                }
            }
        }
        
        module PinRectangle() {
            Box(x_size = mm(4.05), y_size = mm(1.4));
        }
        
        module PinOval() {
            hull() {
                translate([-mm((4.05 - 1.4) / 2 ), 0]) circle(d=mm(1.4));
                translate([ mm((4.05 - 1.4) / 2 ), 0]) circle(d=mm(1.4));
            }
        }
    }
}
