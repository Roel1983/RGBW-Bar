include <TransformIf.inc>

translate([0,  5]) mirror_if(false) {
    text("mirror_if(false)");
}
translate([0, -5]) mirror_if(true) {
    text("mirror_if(true)");
}

module mirror_if(
    condition,
    vec = undef
) {
    if (condition) {
        mirror(vec) children();
    } else {
        children();
    }
}

module rotate_if(
    condition,
    a,
    vec = undef
) {
    if(condition) {
        rotate(a, vec) children();
    } else {
        children();
    }
}
