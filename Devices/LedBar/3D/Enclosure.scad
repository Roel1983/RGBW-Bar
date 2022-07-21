$fn=64;

// Command line arguments: -D val=val
part     = undef;
revision = undef;

// Default argument values
default_part     = "";
default_revision = "#1234567";

// Effective argument values
effective_part     = part     != undef ? part     : default_part;
effective_revision = revision != undef ? revision : default_revision;

// Includes
include<LedbarPcb.inc>
include<Constants.inc>
include<Bar.inc>
include<HexNutCavity.inc>
include<Pcbs.inc>
include<Shapes.inc>
include<TransformCopy.inc>
include<TransformIf.inc>
include<Units.inc>

if (effective_part == "case-bottom.stl") {
    echo("layer_height = 0.15mm");
    echo("Ensure vertical shell thickness = true");
    echo("Detect thinwalls = true");
    CasePart("bottom");
} else if (effective_part == "case-top.stl") {
    echo("layer_height = 0.15mm");
    echo("Detect bridge perimeters");
    echo("Generate support material");
    echo("Support on build plate only");
    echo("Manual remove support under bridge and side connectors");
    CasePart("top");
} else if (effective_part == "profile_support_mid.stl") {
    echo("layer_height = 0.15mm");
    ProfileSupportMid();
} else if (effective_part == "profile_support_end_straight.stl") {
    echo("layer_height = 0.15mm");
    ProfileSupportEnd(angle = 0);
} else if (effective_part == "profile_support_end_bend.stl") {
    echo("layer_height = 0.15mm");
    ProfileSupportEnd(angle = 45);
} else if (effective_part == "profile-drill-guide-center.stl") {
    echo("layer_height = 0.15mm");
    ProfileDrillGuideCenter();
} else if (effective_part == "profile-drill-guide-side.stl") {
    echo("layer_height = 0.15mm");
    ProfileDrillGuideSide();
} else if (effective_part == "case") {
    CasePart("bottom");
    CasePart("case-top");
} else if (effective_part == "profile") {
    Profile();
} else if (effective_part == "mainboard") {
    MainBoard(with_child_board=false);
} else if (effective_part == "perpendicular-board") {
    PerpendicularBoard(with_child_board=false);
} else if (effective_part == "center-board") {
    CenterBoard();
} else if (effective_part == "boards") {
    MainBoard(with_child_board=true);
} else {
    MainBoard(with_child_board=true, parts_only=false);
    %render() Profile();
    CasePart("bottom");
    CasePart("top");
    mirror_copy(X_AXIS) translate([mm(80),0]) {
        ProfileSupportMid();
    }    
    translate([(profile_lenght-profile_end_center_wall)/2,0]) {
        ProfileSupportEnd(angle=45);
    }
    translate([-(profile_lenght-profile_end_center_wall)/2,0]) {
        ProfileSupportEnd(angle=0);
    }
}

module ProfileDrillGuideBasis() {
    translate(mm([0,0,top_height])) {
        difference() {
            rotate(90, Y_AXIS) linear_extrude(mm(20), center=true) rotate(-45){
                difference() {
                    translate(mm([-profile_thicknes - 3,-profile_thicknes - 3]))square(mm([5,30]));
                    translate(mm([-profile_thicknes,-profile_thicknes]))square(profile_size);
                    square(mm(30));
                }
            }
            rotate(45, X_AXIS) rotate(-135, Z_AXIS)cube(10);
        }
    }
}

module ProfileDrillGuideSide() {
    difference() {
        ProfileDrillGuideBasis();
        SideBoard_At(H1102_at) {
            BIAS= 0.1;
            translate([0,0,-4]) cylinder(d=mm(3.1), h=mm(8));
        }
        pitch      = mm(2.0);
        pins       = [1, 5];
        SideBoard_At(J1102_at) {
            translate([
                -.5 * pitch,
                -(.5) * pitch,
                -2
            ]) linear_extrude(case_thickness + profile_thicknes + 5) {
                translate([0])
                square([
                    pins[X] * pitch,
                    pins[Y] * pitch,
                ]);
            }
        }
    }
}

module ProfileDrillGuideCenter() {
    difference() {
        ProfileDrillGuideBasis();
        CenterBoard_At(H1204_at) {
            BIAS= 0.1;
            translate([0,0,-4]) cylinder(d=mm(3.1), h=mm(8));
        }
        pitch      = mm(2.0);
        pins       = [2, 6];
        CenterBoard_At(J1202_at) {
            translate([
                .5 * pitch,
                -(pins[Y] - .5) * pitch,
                -5
            ]) linear_extrude(case_thickness + profile_thicknes + 5) {
                translate([0])
                square([
                    pins[X] * pitch,
                    pins[Y] * pitch,
                ]);
            }
        }
    }
}

pcb_bottom_clearance = mm(3.2);
pcb_top_clearance    = mm(7.5);
pcb_xy_clearance     = mm(1.5);
case_thickness       = mm(0.8);
case_seam_zpos       = mainboard_pcb_thickness;
case_seam_height     = mm(0.8);
case_seam_thickness  = NOZZLE;
case_seam_clearance  = mm(0.1);
profile_end_center_wall = 2 * NOZZLE;

module CaseModifications(bottom_or_top, add_or_remove) {
    Guides(bottom_or_top, add_or_remove);
    PcbScrews(bottom_or_top, add_or_remove);
    SW701Support(bottom_or_top, add_or_remove);
    J502Support(bottom_or_top, add_or_remove);
    StatusLeds(bottom_or_top, add_or_remove);
    BackConnectors(bottom_or_top, add_or_remove);
    SideConnectors(bottom_or_top, add_or_remove);
    CenterBoard(bottom_or_top, add_or_remove);
    BatteryHolder(bottom_or_top, add_or_remove);
    Revision(bottom_or_top, add_or_remove);
}
mainboard_pcb_front_right = [
    mainboard_pcb_center[X],
    + mainboard_pcb_size[Y] - mainboard_pcb_center[Y]
];
case_inner_front_right = [
    mainboard_pcb_front_right[X] + pcb_xy_clearance,
    mainboard_pcb_front_right[Y] + pcb_xy_clearance
];
mainboard_pcb_back_left = [
    - mainboard_pcb_size[X] + mainboard_pcb_center[X],
    - mainboard_pcb_center[Y]
];

case_inner_back_left = [
    mainboard_pcb_back_left[X] - pcb_xy_clearance,
    mainboard_pcb_back_left[Y] - pcb_xy_clearance
];
case_outer_back_left = [
    case_inner_back_left[X] - case_thickness,
    case_inner_back_left[Y] - case_thickness
];
case_center_wall_back_left = [
    case_inner_back_left[X] - case_thickness / 2,
    case_inner_back_left[Y] - case_thickness / 2
];
case_inner_size = [
    mainboard_pcb_size[X] + 2 * pcb_xy_clearance,
    mainboard_pcb_size[Y] + 2 * pcb_xy_clearance
];
case_outer_size = [
    case_inner_size[X] + 2 * case_thickness,
    case_inner_size[Y] + 2 * case_thickness,
];
case_center_wall_size = [
    case_inner_size[X] + case_thickness,
    case_inner_size[Y] + case_thickness,
];
case_inner_bottom       = -pcb_bottom_clearance;
case_outer_bottom       = case_inner_bottom - case_thickness;
case_center_wall_bottom = case_inner_bottom - case_thickness / 2;

module BackConnectors(bottom_or_top, add_or_remove) {
    pin_pad_diameter  = mm(2.8);
    pin_pad_clearance = mm(0.2);
    pin_lenght        = mm(3.0);
    pin_clearance_z   = mm(0.2);
    
    clearance_xy = 0.1;
    clearance_z  = 0.1;
    d     = mm(9.2);    
    front_to_pin = mm(8.0);
    
    Bar();
    Conn15EDGRC(J401_at, pins=3, pitch = mm(3.5),  b = mm(4.4));
    Conn15EDGRC(J601_at, pins=2, pitch = mm(3.5),  b = mm(4.4));
    Conn15EDGRC(J301_at, pins=2, pitch = mm(3.81), b = mm(4.75));
    Pack0805(C601_at);
    hull() {
        Pack0805(R601_at);
        Pack0805(R602_at);
        Pack0805(R603_at);
    }
    module Bar() {
        if (bottom_or_top == "bottom") {
            if (add_or_remove == "add") {
                wall              = 2 * NOZZLE;        
                mirror(Z_AXIS) linear_extrude(pcb_bottom_clearance) {
                    translate(case_center_wall_back_left)
                    square([
                        case_center_wall_size[X],
                        mainboard_at_xy(J601_at)[Y] - case_center_wall_back_left[Y] 
                        + pin_pad_diameter / 2 + pin_pad_clearance + wall
                    ]);
                }
            }            
        }
        if (bottom_or_top == "top") {
            if (add_or_remove == "add") {
                wall              = 2 * NOZZLE;        
                translate([0, 0, mainboard_pcb_thickness])
                linear_extrude(pcb_top_clearance) {
                    translate(case_center_wall_back_left)
                    square([
                        case_center_wall_size[X],
                        mainboard_at_xy(J601_at)[Y] - case_center_wall_back_left[Y] 
                        + d - front_to_pin + clearance_xy + wall
                    ]);
                }
            }            
        }
    }
    module Conn15EDGRC(component_position, pins, pitch, b) {
        MainBoard_At_2D(component_position) {
            if(bottom_or_top=="bottom" && add_or_remove == "remove") {
                hull() for (pin_nr = [0:pins-1]) translate([pin_nr * pitch, 0]) {
                    $fn= 16;               
                    cylinder(
                        d      = pin_pad_diameter+2*pin_pad_clearance,
                        h      = 2*(pin_lenght - mainboard_pcb_thickness + pin_clearance_z),
                        center = true
                    );
                }                
            }
            
            if(bottom_or_top=="top" && add_or_remove == "remove") {
                a     = (pins - 1) * pitch;
                w     = a + b;
                h     = mm(7.00);
                front_to_pin = mm(8.0);
                BIAS         = 0.1;
                
                y = front_to_pin - d - clearance_xy;
                translate([
                    (-w+a)/2 - clearance_xy,
                    y,
                    mainboard_pcb_thickness - BIAS
                ]) {                
                    cube([
                        w + 2 * clearance_xy,
                        d + 2 * clearance_xy,
                        h + 1 * clearance_z + BIAS]);
                    cube([
                        w + 2 * clearance_xy,
                        -case_inner_back_left[Y] - y + mainboard_at_xy(component_position)[Y],
                        pcb_top_clearance + BIAS]);
                }
            }
        }
        
        
        
        /*a     = (pins - 1) * pitch;
        w     = a + mm(5.2) + 2 * case_thickness;
        d     = mm(9.2);
        h     = mm(7.25) + case_thickness;
        front_to_pin = mm(8.0);
        translate([mainboard_at_xy(component_position)[X], 0]) {
            if(bottom_or_top=="top" && add_or_remove == "add_outside") {
                translate([(w-a)/2, 0, mainboard_pcb_thickness]) {
                    rotate(180) cube([
                        w,
                        mainboard_pcb_center[Y] + pcb_xy_clearance + mainboard_pcb_thickness,
                        h
                    ]);
                }
            }
        }*/
    }
    module Pack0805(component_position) {
        if(bottom_or_top=="bottom" && add_or_remove == "remove") {
            MainBoard_At_2D(component_position) {
                cube(mm([3.7, 1.9, 2 * 1.0]), center=true);
            }
        }
    }
}
module SideConnectors(bottom_or_top, add_or_remove) {
    MainBoard_At_2D(J501_at) Conn();
    MainBoard_At_2D(J503_at) Conn();
    
    module Conn() {
        pitch         = mill(10);
        pins          = 5;
        pin_size      = mm(1.7);
        pin_clearance = mm(0.2);
        pin_length    = mm(3.0);
        pin_clearance_z = mm(0.2);
        wall            = 2*NOZZLE;
        till_wall     = mm(20);
        
        if(bottom_or_top=="bottom") {
            if(add_or_remove == "add_inside") {
                mirror(Z_AXIS) linear_extrude(pcb_bottom_clearance) {
                    
                    polygon([
                        [
                            -(pin_size / 2 + pin_clearance) - wall, 
                            (pin_size / 2 + pin_clearance) + wall
                        ],[
                            -(pin_size / 2 + pin_clearance) - wall, 
                            -(pin_size / 2 + pin_clearance) - wall- pitch *(pins-1)
                        ], [
                            -(pin_size / 2 + pin_clearance) - wall + till_wall,
                            -(pin_size / 2 + pin_clearance) - wall - pitch *(pins-1) - till_wall / 2
                        ], [
                            -(pin_size / 2 + pin_clearance) -wall + till_wall, 
                            (pin_size / 2 + pin_clearance) + wall + till_wall / 2
                        ]
                    ]);
                }
            }
            if(add_or_remove == "remove") {
                linear_extrude(
                    2*(pin_length+pin_clearance_z - mainboard_pcb_thickness),
                    center=true
                ) {
                    hull() {
                        d = pin_size + 2 * pin_clearance;
                        square(d, true);
                        translate([0,-pitch * (pins-1)]) {
                            $fn=16;
                            circle(d=d, true);
                        }
                    }
                }
            }
        }
        if(bottom_or_top=="top" && add_or_remove == "remove") {
            pos_z = mm(4.05);
            clearance = mm(0.5);
            
            translate([
                0,
                - (pins-.5) * pitch - clearance,
                -pitch / 2 - clearance + mainboard_pcb_thickness + pos_z
            ]) cube([
                mm(15.0),
                pins * pitch + 2 * clearance,
                pitch + 2 * clearance
            ]);
        }
    }
}
module StatusLeds(bottom_or_top, add_or_remove) {
    module Hole() {
        pitch = mill(10);
        translate([pitch/2,0, mm(2.0)]) {
            cylinder(d=mm(3.2), h=mm(10));
        }
    }
    if(bottom_or_top=="top" && add_or_remove == "remove") {
        MainBoard_At_2D(D701_at) Hole();
        MainBoard_At_2D(D702_at) Hole();
        MainBoard_At_2D(D703_at) Hole();
        MainBoard_At_2D(D704_at) Hole();
        MainBoard_At_2D(D705_at) Hole();
    }
}
module J502Support(bottom_or_top, add_or_remove) {
    if(bottom_or_top=="bottom" && add_or_remove == "add_inside") {
        MainBoard_At_2D(J502_at) {
            mirror(Z_AXIS) linear_extrude(mm(8.0)) difference() {
                offset(delta = 3*NOZZLE) Square();
                Square();
            }
            translate([0,0,mm(-2.0)]) {
                for(y=[
                    mill(  7) + NOZZLE * 1.5,
                    mill(-37) - NOZZLE * 1.5
                ]) translate([0,y]) {
                    mirror(Z_AXIS) linear_extrude(mm(8.0)) difference() {
                        square([mainboard_pcb_size[0] + mm(20), 3 * NOZZLE], true);
                    }
                }
            }
            
        }
        
    }
    module Square() {
        translate(mill([-20/2,-37])) square(mill([20, 7+37]));
    }
}

module Guides(bottom_or_top, add_or_remove) {
   
    x1 = -mainboard_pcb_center[0];
    x2 = mainboard_pcb_size[0]-mainboard_pcb_center[0];
    y1 = -mainboard_pcb_center[1];
    y2 = mainboard_pcb_size[1]-mainboard_pcb_center[1];
    for(p=[
        [[x1, mm( 14)],   0],
        [[x1, mm(-14)],   0],
        [[mm( 7.4), y1],  90],
        [[x2, mm( 14)], 180],
        [[x2, mm(-14)], 180],
        [[mm( 14), y2], 270],
        [[mm(-14), y2], 270],
    ]) translate(p[0]) rotate(p[1]) {
        Guide();
    }
    
    module Guide() {
        if(bottom_or_top=="bottom" && add_or_remove == "add_inside") {
            render() rotate(90, X_AXIS) {
                linear_extrude(mm(3.0), center=true) {
                    BIAS = 0.01;
                    support = mm(0.0);
                    polygon([
                        [0,0],
                        [support, 0],
                        [support, -pcb_bottom_clearance - BIAS],
                        [-pcb_xy_clearance-BIAS, -pcb_bottom_clearance - BIAS],
                        [-pcb_xy_clearance, -pcb_bottom_clearance - BIAS],
                        [-pcb_xy_clearance, , case_seam_zpos],
                        [-pcb_xy_clearance+mm(.2), mainboard_pcb_thickness + mm(1.5)],
                        [-pcb_xy_clearance+mm(.2)+2*NOZZLE, mainboard_pcb_thickness + mm(1.5)],
                        [0, mainboard_pcb_thickness],
                    ]);
                }
            }
        }
        if(bottom_or_top=="top" && add_or_remove == "remove") {
            render() rotate(90, X_AXIS) {
                linear_extrude(mm(3.3), center=true) {
                    BIAS = 0.01;
                    translate([mm(0.15),0]) {
                        mirror(X_AXIS) square([
                            pcb_xy_clearance + mm(0.15),
                            mainboard_pcb_thickness + mm(1.7)
                        ]);
                    }
                }
            }
        }
    }
}

module PcbScrews(bottom_or_top, add_or_remove) {
    MainBoard_At_2D(H201_at, rotate=false) {
        rotate( 90) PcbScrew(bottom_or_top, add_or_remove, "M4");
    }
    MainBoard_At_2D(H202_at, rotate=false) {
        rotate(180) PcbScrew(bottom_or_top, add_or_remove, "M3");
    }
    MainBoard_At_2D(H203_at, rotate=false) {
        rotate(  0) PcbScrew(bottom_or_top, add_or_remove, "M3");
    }
    MainBoard_At_2D(H204_at, rotate=false) {
        rotate(270) PcbScrew(bottom_or_top, add_or_remove, "M4");
    }
    module PcbScrew(bottom_or_top, add_or_remove, m3_or_m4) {
        module Edge_2D() {
            l = mm(10.0);
            r = mm(4.5);
            circle(r=r);
            polygon([
                [-r,  0],
                [-r,  l],
                [ l,  l],
                [ l, -r],
                [ 0, -r]
            ]);
        }
        if (bottom_or_top == "bottom") {
            if(add_or_remove == "add_inside") {
                
                render() {
                    mirror(Z_AXIS) linear_extrude(mm(8)) {
                       Edge_2D(); 
                    }
                    if (m3_or_m4 == "M3") {
                        BIAS = 0.1;
                        translate([0,0,-BIAS]) {
                            cylinder(d=mm(4.15), h = BIAS + mainboard_pcb_thickness);
                        }
                    }
                }
            }
            if(add_or_remove == "remove") {
                if (m3_or_m4 == "M3") {
                    cylinder(
                        d      = mm(3.15),
                        h      = 16,
                        center = true
                    );
                    translate([
                        0,
                        0,
                        case_outer_bottom
                    ]) HexNutCavity(HEXNUT_SIZE_M3);
                    
                } else if (m3_or_m4 == "M4") {
                    cylinder(
                        d      = mm(4.3),
                        h      = 16,
                        center = true
                    );
                }
            }
        } else if (bottom_or_top == "top") {
            if(add_or_remove == "add_inside") {
                translate([0,0,mainboard_pcb_thickness]) {
                    linear_extrude(mm(8)) {
                       Edge_2D(); 
                    }
                }
            }
            if(add_or_remove == "remove") {
                screw_length = mm(10.0);
                if (m3_or_m4 == "M3") {
                    translate([
                        0,
                        0,
                        -pcb_bottom_clearance -case_thickness + screw_length
                    ]) {
                        M3Screw(length=mm(20), head = mm(5));
                    }
                } else {
                    translate([
                        0,
                        0,
                        mainboard_pcb_thickness + pcb_top_clearance - mm(1.0)
                    ]) {
                        M4Screw(length=mm(20), head = mm(5));
                    }
                }
            }
        }
    }  
}
module M3Screw(length, head) {
    r_head  = mm(2.9);
    r_shaft = mm(1.6);
    rotate_extrude() polygon([
        [r_head, 0],
        [r_shaft, -r_head + r_shaft],
        [r_shaft, -length],
        [0, -length],
        [0, head],
        [r_head, head]
    
    ]);
}
module M4Screw(length, head) {
    r_head  = mm(4.0);
    r_shaft = mm(2.15);
    rotate_extrude() polygon([
        [r_head, 0],
        [r_shaft, -r_head + r_shaft],
        [r_shaft, -length],
        [0, -length],
        [0, head],
        [r_head, head]
    
    ]);
}

module SW701Support(bottom_or_top, add_or_remove) {
    MainBoard_At_2D(SW701_at) {
        pitch = mm([6.5, 4.5]);
        translate([pitch[0]/2, -pitch[1]/2]) {
            if(bottom_or_top == "bottom" && add_or_remove == "add_inside") {
                mirror(Z_AXIS) linear_extrude(mm(8.0)) {
                    w = mm(6.5);
                    d = mm(4.5);
                    
                    difference() {
                        e = mm(10);
                        translate([0,-e/2]) {
                            square(mm([w, d + e]), true);
                        }
                        mirror_copy(X_AXIS) mirror_copy(Y_AXIS) {
                            translate(mm([
                                w/2, d/2
                            ])) circle(d=mm(2.2));
                        }
                    }
                }
            }
            if(bottom_or_top == "top" && add_or_remove == "remove") {
                cylinder(d=mm(3.7),h=mm(10));
            }
        }
    }
}
module IntersectionOrDifference(intersection_or_difference) {
    if(intersection_or_difference == "intersection") {
        intersection() {
            children(0);
            children(1);
        }
    } else if(intersection_or_difference == "difference") {
        difference() {
            children(0);
            children(1);
        }
    }
}

module CasePart(top_or_bottom) {
    difference() {
        union() {
            difference() {
                IntersectionOrDifference(
                    top_or_bottom == "bottom" ? "intersection" : "difference"
                ) {
                    CaseBasicShape("outer");
                    Seam();
                }
                CaseBasicShape("inner");
            }
            intersection() {
                union() {
                    CaseModifications(top_or_bottom, "add_inside");
                    cube(0); 
                }
                CaseBasicShape("inner");
            }
            difference() {
                union() {
                    CaseModifications(top_or_bottom, "add_outside");
                    cube(0); 
                }
                CaseBasicShape("inner");
            }
            CaseModifications(top_or_bottom, "add");
        }
        CaseModifications(top_or_bottom, "remove");
    }
    module Seam(rim=false) {
        translate([0,0,case_seam_zpos]) {
            BIAS = 0.1;
            difference() {
                mirror(Z_AXIS) linear_extrude(
                    case_seam_zpos + case_thickness + pcb_bottom_clearance + BIAS
                ) {    
                    offset(BIAS) projection() CaseBasicShape("outer");
                }
                if(rim) {
                    translate([0,0,-case_seam_height]) linear_extrude(case_seam_height + BIAS) {
                        offset(
                            top_or_bottom == "bottom" ? (
                                -case_seam_thickness
                            ) : (
                                -case_seam_thickness - case_seam_clearance
                            )
                        ) projection(cut=true) {
                            translate([0,0,-case_seam_zpos]) {
                                CaseBasicShape("outer");
                            }
                        }
                    }
                }
            }
        }
    }
}

module CaseBasicShape(inner_or_outer) {
    offset = (inner_or_outer == "inner") ? (
        -case_thickness
    ) : (
        0
    );
    
    
    rotate(90, Z_AXIS) rotate(90, X_AXIS) {
        translate([
            0, 0, -mainboard_pcb_center[0] -pcb_xy_clearance - case_thickness - offset
        ]) linear_extrude(
            mainboard_pcb_size[0] + 2 * pcb_xy_clearance + 2 * (case_thickness + offset)
        ) {
            CaseXzProfile(offset);
        }
    }

    module CaseXzProfile(offset) {
        module Inner() {
            translate([
                -mainboard_pcb_center[1] - pcb_xy_clearance,
                -pcb_bottom_clearance
            ]) square([
                mainboard_pcb_size[1] + 2 * pcb_xy_clearance,
                pcb_bottom_clearance + mainboard_pcb_thickness + pcb_top_clearance
            ]);
        }
        module Outer() {
            polygon([
                [ 0, top_height],
                [ top_height, 0],
                [-top_height, 0],
            ]);
        }
        offset(delta = case_thickness + offset) Inner();
        offset(delta = offset) Outer();
    }
}

module CenterBoard_At(at) {
    MainBoard_At(J502_at) {
        rotate(90, Y_AXIS)rotate(-90) {
            translate(mm([
                -(J1001_at[COMPONENT_AT_LOCATION][X] - mainboard_pcb_center_at[0]),
                -(mainboard_pcb_center_at[1] - J1001_at[COMPONENT_AT_LOCATION][Y]),
                -mainboard_pcb_thickness / 2
            ])) {
                MainBoard_At(J1002_at) {
                    rotate(180) rotate(90, Y_AXIS) translate([-mm(1.5),0,mm(7.2)]) {
                        translate(mm([
                            -(J1202_at[COMPONENT_AT_LOCATION][X] - mainboard_pcb_center_at[0]),
                            -(mainboard_pcb_center_at[1] - J1202_at[COMPONENT_AT_LOCATION][Y]),
                            -mainboard_pcb_thickness/2
                        ])) {
                            MainBoard_At(at) {
                                pitch = mm(2);
                                translate([-pitch/2,0]) {
                                    children();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

module ProfileScrewAndNutHole() {
    mirror(Z_AXIS) {
        cylinder(d=mm(3.2), h=mm(8.5));
        translate([0,0, mm(4.0)]) {
            
            linear_extrude(mm(2.35))
            hull() {
                Hex(5.5);
                translate([0,mm(2)] )Hex(5.5);
            }
        }
    }
}
module CenterBoard(bottom_or_top, add_or_remove) {
    BIAS       = mm(0.1);
    pitch      = mm(2.0);
    pins       = [2, 6];
    clearance1 = mm(.1);
    clearance2 = mm(.6);
    
    Connector();
    Bridge();
    Screw();
    
    for (x = mm([-30.0, 30.0])) translate([x,0]) {
        rotate(180) {
            Bridge();
            Screw();
        }
    }
    
    module Screw() {
        CenterBoard_At(H1204_at) {
            if(bottom_or_top == "top" && add_or_remove == "remove") {
                ProfileScrewAndNutHole();
            }
        }
    }
    
    module Bridge() {
        MainBoard_At(J502_at) {
            if(bottom_or_top=="top" && add_or_remove == "add_inside") {
                translate([
                    0, 0, mm(21.1)
                ]) difference() {
                    linear_extrude(
                        mm(20.0)
                    ) square([
                        max(
                            pins[X] * pitch + 2 * (clearance2 + case_thickness),
                            mm(5.5) + 2 * case_thickness
                        ),
                        mainboard_pcb_size[Y]
                    ], center = true);
                    LAYER_HEIGHT = mm(.15);
                    linear_extrude(
                        10 * LAYER_HEIGHT,
                        center = true
                    ) square([
                        max(
                            pins[X] * pitch + 2 * (clearance2 + case_thickness),
                            mm(5.5) + 2 * case_thickness
                        ) - 4 * NOZZLE,
                        mainboard_pcb_size[Y]
                    ], center = true);
                }
            }
        }
    }
    
    module Connector() {
        CenterBoard_At(J1202_at) {
            if(bottom_or_top == "top" && add_or_remove == "remove") {
                translate([
                    .5 * pitch - clearance1,
                    -(pins[Y] - .5) * pitch - clearance1,
                    -BIAS
                ]) linear_extrude(BIAS + case_thickness + profile_thicknes) {
                    square([
                        pins[X] * pitch + 2 * clearance1,
                        pins[Y] * pitch + 2 * clearance1,
                    ]);
                }
                hull() {
                    translate([
                        .5 * pitch - clearance1,
                        -(pins[Y] - .5) * pitch - clearance1,
                        case_thickness + profile_thicknes-BIAS
                    ]) linear_extrude(BIAS + case_thickness + profile_thicknes) {
                        square([
                            pins[X] * pitch + 2 * clearance1,
                            pins[Y] * pitch + 2 * clearance1,
                        ]);
                    }
                    l = mm(15.0);
                    translate([
                        .5 * pitch - clearance2,
                        -(pins[Y] - .5) * pitch - clearance2,
                        case_thickness + profile_thicknes-BIAS + clearance2
                    ]) linear_extrude(BIAS + case_thickness + profile_thicknes + l) {
                        square([
                            pins[X] * pitch + 2 * clearance2,
                            pins[Y] * pitch + 2 * clearance2,
                        ]);
                    }
                }
            }
        }
    }
}

module ProfileSupportBaseShape2D(tolerance, end=false) {
    thickness = 2 * NOZZLE / sqrt(2);
    
    a = sqrt(0.5) * (profile_size + 2 * tolerance) + thickness;
    b = end ? (
        sqrt(2) * (tolerance + profile_thicknes + thickness)
    ) : (
        0
    );
    
    polygon([
        [ 0, top_height + b],
        [ a, top_height - a + b],
        [ a, -pcb_bottom_clearance - case_thickness],
        [-a, -pcb_bottom_clearance - case_thickness],
        [-a, top_height - a + b],
        [ 0, top_height + b],
    ]);
}

module SideBoard_At(at) {
    CenterBoard_At(H1204_at) {
        translate([
            at[COMPONENT_AT_LOCATION][X] - H1102_at[COMPONENT_AT_LOCATION][X],
            at[COMPONENT_AT_LOCATION][Y] - H1102_at[COMPONENT_AT_LOCATION][Y]
        ]) rotate(
            at[COMPONENT_AT_ROTATION]    - H1102_at[COMPONENT_AT_ROTATION]
        ) {
            children();
        };
    }
}

module ProfileSupportMid() {
    profile_tolerance   = mm(.2);
    width = mm(10);
    
    difference() {
        rotate(90, Y_AXIS) linear_extrude(width, center=true) {
            difference() {
                rotate(90) ProfileSupportBaseShape2D(
                    tolerance=profile_tolerance, end=false);
                translate([-2,14]) hull() {
                    circle(d=3);
                    translate([-8,0]) circle(d=3);
                    translate([-10,-2]) circle(d=3);
                    translate([0,-12]) circle(d=3);
                }
            }
        }
        
        SideBoard_At(H1102_at) {
            ProfileScrewAndNutHole();
        }
        SideBoard_At(J1102_at) {
            pitch = mm(2.0);
            pins  = 5;
            e     = mm(0.6);
            header_male_female_height = mm(6.5);
            
            BIAS=0.01;
            rim = mm(0.5);
            gap = mm(8);
            tolerance = mm([.3,.5]);
            a = mainboard_pcb_thickness + header_male_female_height;
            translate([0, (pins - 1)/2 * pitch]) {
                rotate(-90, X_AXIS)linear_extrude(pins*pitch+e+tolerance[Y], center=true) {
                    mirror_copy() {
                        polygon([
                            [-BIAS, 0],
                            [(pitch+e)/2 + tolerance[X], 0],
                            [(pitch+e)/2 + tolerance[X], a],
                            [-BIAS, a]
                        ]);
                    }
                }
                rotate(-90, X_AXIS)linear_extrude(pins*pitch+e - rim, center=true) {
                    
                    mirror_copy() {
                        polygon([
                            [-BIAS, 0],
                            [(pitch+e)/2, 0],
                            [(pitch+e)/2, a],
                            [width, a ],
                            [width, a + gap],
                            [-BIAS, a + gap]
                        ]);
                        translate([-2,a + gap]) {
                            translate([4.5, 0]) {
                                square([width * 1.5, 3]);
                            }
                            translate([0,  mm(2)]) {
                                square([width * 1.5, 3]);
                            }
                            translate([6, mm(5)]) {
                                square([width * 1.5, 3]);
                            }
                            translate([0, mm(3+2+3)]) {
                                square([width * 1.5, 3]);
                            }
                        }
                        
                    }
                }
            }
        }
        BIAS = 0.01;
        translate([0,0,-pcb_bottom_clearance - case_thickness-BIAS]) {
            linear_extrude(mm(.15) + BIAS) rotate(90) mirror() text(
                text = effective_revision,
                size = mm(5.5),
                font = "Arial",
                halign = "center",
                valign = "center"
            );
        }
    }
    rotate_copy(180) {
        translate([width/2,0]) rotate(-90)Mount();
    }
}

module ProfileSupportEnd(angle) {
    width       = mm(10.0);
    tolerance   = mm(.2);
    
    module cut() {
        translate([profile_end_center_wall/2, 0, top_height]) {
            rotate(90, Y_AXIS) linear_extrude(width / 2) {
                offset(delta= tolerance)Profile2D();
            }
        }
    }
    
    pivot = [0, -sqrt(0.5) * profile_size - mm(2.0)];
    difference() {
        render() rotate(90, Y_AXIS) linear_extrude_bend(angle, width/2,width/2,pivot=pivot) {
            rotate(90) ProfileSupportBaseShape2D(tolerance= tolerance, end=true);
        }
        render() rotate(90, Y_AXIS) linear_extrude_bend(angle, width,width,pivot=pivot) {
            r=3;
            rotate(90) offset(r) offset(mm(-6-r)) ProfileSupportBaseShape2D(tolerance= tolerance, end=true);
        }
        
        mirror(X_AXIS) cut();
        pivot(-angle, pivot) cut();
        
        BIAS = 0.01;
        translate([0,0,-pcb_bottom_clearance - case_thickness-BIAS]) {
            pivot(-angle/2, pivot)linear_extrude(mm(.15) + BIAS) rotate(90) mirror() text(
                text = effective_revision,
                size = mm(5.5),
                font = "Arial",
                halign = "center",
                valign = "center"
            );
        }
    }
    translate([-width/2,0]) rotate(90)Mount();
    pivot(-angle, pivot) translate([width/2,0]) rotate(-90)Mount();
}

module Mount() {
    BIAS = 0.1;
    thickness = mm(1.5);
    height    = pcb_bottom_clearance + case_thickness;
    length    = mm(10);
    d1   = mm(4.0);
    d2   = mm(8.0);
    wall      = 4 * NOZZLE;
    
    inner_width = d2 + mm(.5);
    outer_width = inner_width + 2 * wall;
    
    translate([0,0, -pcb_bottom_clearance - case_thickness])difference() {
        rotate(-90, Y_AXIS)linear_extrude(outer_width, center=true) polygon([
            [0,-BIAS],
            [0, length],
            [thickness, length],
            [height, -BIAS]
        ]);
        translate([0, length/2, height/2 + thickness]) {
            cube([inner_width, length+ 4*BIAS, height], center=true);
        }
        translate([0, 5, -BIAS]) {
            cylinder(d1=d1, d2=d2, h = 2*BIAS + thickness);
        }
    }    
}

module BatteryHolder(bottom_or_top, add_or_remove) {
    if(bottom_or_top=="top" && add_or_remove == "remove") {
        MainBoard_At_2D(BT901_at) {
            BIAS = 0.1;
            h    = 1.0;
            translate([0,0, mainboard_pcb_thickness - BIAS]) {
                linear_extrude(h + BIAS) {
                    square(mm([18.5, 5.5]), center=true);
                }
            }
        }
    }
}    

module Revision(bottom_or_top, add_or_remove) {
    BIAS         = 0.1;
    LAYER_HEIGHT = mm(0.15);
    depth        = LAYER_HEIGHT;

    if (bottom_or_top == "bottom" && add_or_remove == "remove") {
        
        translate([0,mm(-15),case_inner_bottom - depth]) {
            linear_extrude(BIAS + depth) text(
                text = effective_revision,
                size = mm(7),
                font = "Arial",
                halign = "center",
                valign = "center"
            );
        }
    }
    if (bottom_or_top == "top" && add_or_remove == "add") {
        translate([
            0,
            case_inner_front_right[Y],
            (mainboard_pcb_thickness + pcb_top_clearance + case_thickness) / 2
        ]) rotate(90, X_AXIS)linear_extrude(BIAS + depth) text(
            text = effective_revision,
            size = mm(6),
            font = "Arial",
            halign = "center",
            valign = "center"
        );
    }
}

module linear_extrude_bend(angle, l1, l2, pivot = [0,0,0]) {
    BIAS=0.01;
    vec = [1,0,0];
    module mid() {
        translate(pivot) {
            rotate(angle/2, vec) scale([1, 1/cos(angle/2),1]) {
                translate(-pivot) {
                    linear_extrude(BIAS, center=true) children(); 
                }
            }
        }
    }
    hull() {
        mirror([0,0,1]) linear_extrude(l1) children();
        mid() children();
    }
    hull() {
        mid() children();
        pivot(angle, pivot, vec) linear_extrude(l2) children();
    }
}

module pivot(angle, pivot=[0,0,0], vec = undef) {
    translate(pivot) rotate(angle, vec) {
        translate(-pivot) children();
    }
}