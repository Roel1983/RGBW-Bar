use     <../../../../../../../Shared/3D/Utils/Units.scad>

CP_Radial(layer = "3D", D = mm(10.0), P = mm(5.00), H = mm(20.1));

module CP_Radial(layer, D, P, H) {
    if(layer == "3D") {
        rounding = 0.5;
        foil_thickness = 0.15;
        
        translate([P/2, 0]) {
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
                        square([D-3.0, 2*foil_thickness], center=true);
                    }
                }
            }
        }
    }
}