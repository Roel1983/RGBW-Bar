include <../../../../../../../Shared/3D/Utils/Constants.inc>
use     <../../../../../../../Shared/3D/Utils/TransformCopy.scad>
use     <../../../../../../../Shared/3D/Utils/Units.scad>

BatteryHolder_LINX_BAT_HLD_012_SMT(layer = "3D");

module BatteryHolder_LINX_BAT_HLD_012_SMT(layer) {
    d1 = mm(12.5);
    d2 = mm(10.6);
    h1 = mm( 1.9);
    h2 = mm( 2.5);
    
    if (layer == "3D") {
        Layer3D();
    }
    
    module Layer3D() {
        color("silver") {
            Battery();
            linear_extrude(mm(0.25)) square([mm(17), mm(2.5)], center=true);
            render() difference() {
                linear_extrude(mm(h2+mm(.5))) {
                    difference() {
                        r = mm(1.5);
                        offset(r=r)offset(-r)difference() {
                            translate([0,mm(1)])square([d1+mm(.5), mm(11.5)], center=true);
                            translate([0, -d1/4*3]) circle(d=d1);
                        }
                        mirror_copy(VEC_X) translate([mm(10),0])rotate(45)square(mm(11));
                    }
                }
                translate([0,mm(1-.5),-.5])linear_extrude(mm(h2+mm(.5))) {
                     square([d1-mm(.5), mm(11.5)], center=true);
                }
            }
        }
    }
    
    module Battery() {
        translate([0,0,h2]) mirror(VEC_Z) {
            rotate_extrude() {
                disk_2D(d1, h1, mm(0.8));
                disk_2D(d2, h2, mm(0.4));
            }
        }
        
        module disk_2D(d, h, r) {
            $fn=16;
            polygon([
                [0,0],
                [d/2,0],
                [d/2,h-r],
                [d/2-r,h],
                [0,h]
            ]);
            translate([d/2-r,h-r]) circle(r=r);
        }
    }
}