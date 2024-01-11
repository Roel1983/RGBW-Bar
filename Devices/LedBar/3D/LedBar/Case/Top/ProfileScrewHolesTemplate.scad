use     <../../Shared/ScrewHole.scad>
include <../../Config.inc>
use     <ProfileScrewHoles.scad>

ProfileScrewHolesTemplate();

module ProfileScrewHolesTemplate() {
    difference() {
        translate([0,0,CASE_HEIGHT_TOP]) {
            rotate(90, VEC_Y) {
                linear_extrude(mm(68), center = true) {
                    difference() {
                        rotate(-45) square(mm(8));
                        translate([-.5,0]) {
                            square(mm(2), true);
                        }
                    }
                }
            }
        }
        
        ProfileScrewHoles_positions() {
            DrillHole();
            ScrewHole();
            DrillHole();
        }
    }
    
    module DrillHole() {
        translate([0,0,-11])
        cylinder(d=mm(3), h = mm(12), $fn=64);
    }
}