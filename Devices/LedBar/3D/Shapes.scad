Hex(10);

module Hex(d) {
    intersection_for (a = [0,60, 120]) rotate(a) {
        square([d, 2*d], center=true);
    }
}