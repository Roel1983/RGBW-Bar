use     <../../../../../Shared/3D/Utils/Box.scad>
use     <../../../../../Shared/3D/Utils/LinearExtrude.scad>
use     <../../../../../Shared/3D/Utils/Bounds.scad>

include <../../Config.inc>

difference() {
    CaseBasicShape(no_bevel=false);
    Box(
        x_to   =  100,
        y_to   =  100,
        z_from = -10,
        z_to   = 50
    );
}

module CaseBasicShape(no_bevel = false) {
    difference() {
        CaseBasicShapeOuter(no_bevel = no_bevel);
        CaseBasicShapeInner(no_bevel = no_bevel);
    }
}

module CaseBasicShapeOuter(no_bevel = false) {
    _CaseBasicShape(
        offset_horizontal = 0,
        offset_bottom     = 0,
        offset_top        = 0,
        no_bevel          = no_bevel
    );
}

module CaseBasicShapeInner(no_bevel = false) {
    _CaseBasicShape(
        offset_horizontal = -CASE_WALL_THICKNESS_VERTICAL,
        offset_bottom     = -CASE_WALL_THICKNESS_BOTTOM,
        offset_top        = -CASE_WALL_THICKNESS_TOP,
        no_bevel          = no_bevel
    );
}

module CaseBasicShapeOuterRelief() {
    _CaseBasicShape(
        offset_horizontal = nozzle(1),
        offset_bottom     = 0,
        offset_top        = nozzle(1),
        no_bevel          = false
    );
}

module _CaseBasicShape(
    offset_horizontal,
    offset_bottom,
    offset_top,
    no_bevel
) {
    if(no_bevel) {
        Box(
            bounds = bounds_margin(
                CASE_BOUNDS_XY,
                offset_horizontal),
            z_from = -offset_bottom,
            z_to   = CASE_HEIGHT_SIDE + offset_top
        );
    } else {
        bevel = CASE_BEVEL;        
        hull() {
            Box(
                bounds = bounds_margin(
                    CASE_BOUNDS_XY,
                    offset_horizontal),
                z_from = -offset_bottom,
                z_to   = CASE_HEIGHT_SIDE - bevel
            );
            Box(
                bounds = bounds_margin(
                    CASE_BOUNDS_XY,
                    -bevel
                    + offset_horizontal - offset_top),
                z_from = -offset_bottom,
                z_to   = CASE_HEIGHT_SIDE + offset_top
            );
        }
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
