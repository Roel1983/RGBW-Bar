include <Case/Shared/Boards/Mainboard/MainboardKicadPcb.inc>
include <Case/Shared/Boards/Subboards/SubboardsKicadPcb.inc>
use     <../../../Shared/3D/Utils/Bounds.scad>
include <../../../Shared/3D/Utils/Constants.inc>
include <../../../Shared/3D/Utils/Units.inc>
use     <../../../Shared/3D/KicadPcbComponent.scad>

$UNITS_NOZZLE                     = mm(0.4);
$UNITS_LAYER                      = mm(0.15);

CASE_WALL_THICKNESS_VERTICAL      = nozzle(3);
CASE_WALL_THICKNESS_BOTTOM        = layer(5);
CASE_WALL_THICKNESS_TOP           = layer(5);

CASE_PCB_TOLERANCE_VERTICAL       = mm(0.05);
CASE_PCB_TOLERANCE_HORIZONTAL     = mm(0.1);

CASE_PCB_WALL_CLEARANCE_HORIZONAL = mm(1);
CASE_PCB_WALL_CLEARANCE_BOTTOM    = mm(3.2);
CASE_PCB_WALL_CLEARANCE_TOP       = mm(9.5);

CASE_BEVEL                        = mm(2);

CASE_LED_WALL_CLEARANCE           = mm(0.15);
CASE_BUTTON_WALL_CLEARANCE        = mm(0.2);

HEX_NUT_DIAMETER                  = mm(5.45);
HEX_NUT_HEIGHT                    = mm(2.3);
HEX_NUT_TOLERANCE                 = mm(0.05);

CASE_BRIDGE_WIDTH                 = HEX_NUT_DIAMETER + 2 * (nozzle(2) + HEX_NUT_TOLERANCE);

ANGLE_PROFILE_WIDTH               = mm(25.2);
ANGLE_PROFILE_THICKENS            = mm(1.1);

PAD_SIZE_15EDGRC_3_5              = mm(3.2);

PCB_THICKNESS_MAINBOARD_TOLERANCE = mm(.1);

/* Dirived */

CASE_BOUNDS_XY = bounds_margin(
    bounds = PCB_BOUNDS_MAINBOARD,
    margin = (
        CASE_PCB_WALL_CLEARANCE_HORIZONAL
        + CASE_WALL_THICKNESS_VERTICAL
    )
);
CASE_SEAM_Z = (
    CASE_WALL_THICKNESS_BOTTOM
    + CASE_PCB_WALL_CLEARANCE_BOTTOM
);
CASE_PCB_Z_BACK = (
    CASE_SEAM_Z
    + CASE_PCB_TOLERANCE_VERTICAL
);
CASE_PCB_Z_FRONT = (
    CASE_PCB_Z_BACK
    + PCB_THICKNESS_MAINBOARD
    + PCB_THICKNESS_MAINBOARD_TOLERANCE
);
CASE_HEIGHT_SIDE = (
    CASE_PCB_Z_BACK
    + CASE_PCB_TOLERANCE_VERTICAL
    + CASE_PCB_WALL_CLEARANCE_TOP
    + CASE_WALL_THICKNESS_TOP
);

PCB_BOUNDS_CENTER_BOARD = [[mm(102.235), mm(120.777)], PCB_BOUNDS_SUBBOARDS[Y]];
CENTER_BOARD_SIZE = [
    PCB_BOUNDS_CENTER_BOARD[X][1]-PCB_BOUNDS_CENTER_BOARD[X][0],
    PCB_BOUNDS_CENTER_BOARD[Y][1]-PCB_BOUNDS_CENTER_BOARD[Y][0]
];
CENTER_BOARD_CENTER = [
    (PCB_BOUNDS_CENTER_BOARD[X][1] + PCB_BOUNDS_CENTER_BOARD[X][0]) / 2,
    (PCB_BOUNDS_CENTER_BOARD[Y][1] + PCB_BOUNDS_CENTER_BOARD[Y][0]) / 2
];

COMPONENT_J1002_POSITION=[
    component_at_loc(COMPONENT_J502)[X],
    component_at_loc(COMPONENT_J502)[Y] + (
        component_at_loc(COMPONENT_J1002)[X]
        - component_at_loc(COMPONENT_J1001)[X]
    ),
    CASE_PCB_Z_FRONT + (
        component_at_loc(COMPONENT_J1001)[Y]
        - component_at_loc(COMPONENT_J1002)[Y]
    )
];

CASE_HEIGHT_TOP = COMPONENT_J1002_POSITION[Z] + (component_at_loc(COMPONENT_J1202)[Y] - PCB_BOUNDS_SUBBOARDS[Y][0] + (ANGLE_PROFILE_WIDTH - CENTER_BOARD_SIZE[Y]) / 2 - ANGLE_PROFILE_THICKENS) * sqrt(2) - COMPONENT_J1002_POSITION[Y];

PCB_BOUNDS_LEFT_BOARD = [[mm(89.027), mm(99.695)], PCB_BOUNDS_SUBBOARDS[Y]];
LEFT_BOARD_SIZE = [
    component_at_loc(COMPONENT_H1204)[X],
    PCB_BOUNDS_LEFT_BOARD[Y][1]-PCB_BOUNDS_LEFT_BOARD[Y][0]
];
LEFT_BOARD_CENTER = [
    component_at_loc(COMPONENT_H1102)[X],
    (PCB_BOUNDS_LEFT_BOARD[Y][1] + PCB_BOUNDS_LEFT_BOARD[Y][0]) / 2
];