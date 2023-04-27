include <Case/MainboardKicadPcb.inc>
use     <../../../Shared/3D/Bounds.scad>
include <../../../Shared/3D/Units.inc>

$UNITS_NOZZLE                     = mm(0.4);
$UNITS_LAYER                      = mm(0.15);

CASE_WALL_THICKNESS_VERTICAL      = nozzle(3);
CASE_WALL_THICKNESS_BOTTOM        = layer(5);
CASE_WALL_THICKNESS_TOP           = layer(5);

CASE_PCB_TOLERANCE_VERTICAL       = mm(0.05);
CASE_PCB_TOLERANCE_HORIZONTAL     = mm(0.1);

CASE_PCB_WALL_CLEARANCE_HORIZONAL = mm(1);
CASE_PCB_WALL_CLEARANCE_BOTTOM    = mm(3);
CASE_PCB_WALL_CLEARANCE_TOP       = mm(8);

CASE_BEVEL                        = mm(2);

/* Dirived */

CASE_BOUNDS_XY = bounds_margin(
    bounds = PCB_BOUNDS,
    margin = (
        CASE_PCB_WALL_CLEARANCE_HORIZONAL
        + CASE_WALL_THICKNESS_VERTICAL
    )
);
CASE_SEAM_Z = (
    CASE_WALL_THICKNESS_BOTTOM
    + CASE_PCB_WALL_CLEARANCE_BOTTOM
);
CASE_PCB_Z_BOTTOM = (
    CASE_SEAM_Z
    + CASE_PCB_TOLERANCE_VERTICAL
);
CASE_PCB_Z_TOP = (
    CASE_PCB_Z_BOTTOM
    + PCB_THICKNESS
);
CASE_HEIGHT_SIDE = (
    CASE_PCB_Z_TOP
    + CASE_PCB_TOLERANCE_VERTICAL
    + CASE_PCB_WALL_CLEARANCE_TOP
    + CASE_WALL_THICKNESS_TOP
);
CASE_HEIGHT_TOP = mm(35); // TODO calculate