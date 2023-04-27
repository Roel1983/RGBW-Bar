use     <../../../../../Shared/3D/Box.scad>
use     <../../../../../Shared/3D/LinearExtrude.scad>
use     <../../../../../Shared/3D/Bounds.scad>

include <../../Config.inc>

difference() {
    CaseBasicShape();
    Box(
        x_to   =  100,
        y_to   =  100,
        z_from = -10,
        z_to   = 50
    );
}

module CaseBasicShape() {
    difference() {
        CaseBasicShapeOuter();
        CaseBasicShapeInner();
    }
}

module CaseBasicShapeOuter() {
    _CaseBasicShape(
        offset_horizontal = 0,
        offset_bottom     = 0,
        offset_top        = 0
    );
}

module CaseBasicShapeInner() {
    _CaseBasicShape(
        offset_horizontal = -CASE_WALL_THICKNESS_VERTICAL,
        offset_bottom     = -CASE_WALL_THICKNESS_BOTTOM,
        offset_top        = -CASE_WALL_THICKNESS_TOP
    );
}

module _CaseBasicShape(
    offset_horizontal,
    offset_bottom,
    offset_top
) {
    hull() {
        Box(
            bounds = bounds_margin(
                CASE_BOUNDS_XY,
                offset_horizontal),
            z_from = -offset_bottom,
            z_to   = CASE_HEIGHT_SIDE - CASE_BEVEL
        );
        Box(
            bounds = bounds_margin(
                CASE_BOUNDS_XY,
                -CASE_BEVEL
                + offset_horizontal - offset_top),
            z_from = -offset_bottom,
            z_to   = CASE_HEIGHT_SIDE + offset_top
        );
    }
    LinearExtrude(
        x_from = CASE_BOUNDS_XY[0][0] - offset_horizontal,
        x_to   = CASE_BOUNDS_XY[0][1] + offset_horizontal
    ) {
        polygon(points=[
            [
                0,
                CASE_HEIGHT_TOP + offset_horizontal
            ], [
                -CASE_HEIGHT_TOP - 2*offset_horizontal,
                -offset_bottom
            ], [
                CASE_HEIGHT_TOP + 2 * offset_horizontal,
                -offset_bottom
            ]
        ]);
    }
}
