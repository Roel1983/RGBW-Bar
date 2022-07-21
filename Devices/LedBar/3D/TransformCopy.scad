include <Constants.inc>

include <TransformCopy.inc>

translate([0 , 30]) {
    mirror_copy() {
        linear_extrude(3) text("mirror_copy()");
    }
}
translate([0 , 10]) {
    mirror_copy(X_AXIS) {
        linear_extrude(3) text("mirror_copy(X_AXIS)");
    }
}

translate([0 , -10]) {
    mirror_copy(Y_AXIS) {
        linear_extrude(3) text("mirror_copy(Y_AXIS)");
    }
}
translate([0 , -30]) {
    mirror_copy(Z_AXIS) {
        linear_extrude(3) text("mirror_copy(Z_AXIS)");
    }
}

module mirror_copy(
    vec = undef
) {
    children();
    mirror(vec) children();
}

module rotate_copy(
    a,
    vec=undef
) {
    children();
    rotate(a, vec) children();
}

module translate_copy(
    vec
) {
    children();
    translate(vec) children();
}
