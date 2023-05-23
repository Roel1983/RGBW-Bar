include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

CP_Radial(layer = "3D", D = mm(10.0), P = mm(5.00), H = mm(20.1));

module CP_Radial(layer, D, P, H) {
    if(layer == "3D") {
        Layer3D();
    }
    
    module Layer3D() {
        rounding = 0.5;
        foil_thickness = 0.15;
        
        color("blue")translate([P/2, 0]) {
            render() rotate_extrude() {
                difference() {
                    union() {
                        offset(r=rounding) offset(-rounding)difference() {
                            square([D/2,H]);
                            translate([D/2 + 0.5, 2.0]) circle(d=2.0);
                        }
                        square([D/2-rounding,H]);
                    }
                    translate([0,H]) {
                        square([D-3.0, 3*foil_thickness], center=true);
                    }
                }
            }
        }
        color("silver") {
            translate([P/2, 0, H - foil_thickness]) {
                mirror(VEC_Z) cylinder(d = D - mm(2.0), foil_thickness);
            }
            for(x = [0, P]) translate([x, 0]) {
                Pin();
            }
        }
        
        module Pin() {
            pin_length   = mm(4.0);
            pin_diameter = mm(0.8);
            BIAS = 0.1;
            
            translate([0, 0, -pin_length]) {
                cylinder(d = pin_diameter, h = pin_length + BIAS);
            }
        }
    }
}