include <Units.inc>

translate([-10,0]) Hex(10);

module Hex(size = 1) {
    intersection_for(a=[0:120:359]) rotate(a) {
        square([size, 2 * size], true);
    }
}
