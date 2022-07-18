include<Constants.inc>
include<Units.inc>

include<Bar.inc>

Profile();

module Profile() {
    color("white") translate(mm([0,0,top_height])) {
        rotate(90, Y_AXIS) linear_extrude(mm(profile_lenght), center=true) {
            Profile2D();
        }
    }
}
module Profile2D() {
    rotate(-45){
        difference() {
            translate(mm([-profile_thicknes,-profile_thicknes]))square(mm(25.4));
            square(profile_size);
        }
    }
}