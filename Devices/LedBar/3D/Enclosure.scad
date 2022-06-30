$fn=64;

include<ComponentAt.inc>
include<Constants.inc>
include<Bar.inc>
include<Pcbs.inc>
include<Shapes.inc>
include<TransformCopy.inc>
include<TransformIf.inc>
include<Units.inc>

MainBoard(with_child_board=true);
Profile();
color("white") CasePart("bottom");
color("white") CasePart("top");

pcb_bottom_clearance = mm(3.2);
pcb_top_clearance    = mm(5.5);
pcb_xy_clearance     = mm(1.5);
case_thickness       = mm(0.8);
case_seam_zpos       = mainboard_pcb_thickness;
case_seam_height     = mm(0.8);
case_seam_thickness  = NOZZLE;
case_seam_clearance  = mm(0.1);

module CaseModifications(bottom_or_top, add_or_remove) {
    Guides(bottom_or_top, add_or_remove);
    PcbScrews(bottom_or_top, add_or_remove);
    SW701Support(bottom_or_top, add_or_remove);
    J502Support(bottom_or_top, add_or_remove);
    StatusLeds(bottom_or_top, add_or_remove);
    BackConnectors(bottom_or_top, add_or_remove);
}
module BackConnectors(bottom_or_top, add_or_remove) {
    Conn15EDGRC(J401_at, pins=3, pitch = mm(3.5));
    Conn15EDGRC(J601_at, pins=2, pitch = mm(3.5));
    Conn15EDGRC(J301_at, pins=2, pitch = mm(3.81));
    module Conn15EDGRC(component_position, pins, pitch) {
        a     = (pins - 1) * pitch;
        w     = a + mm(5.2) + 2 * case_thickness;
        d     = mm(9.2);
        h     = mm(7.25) + case_thickness;
        front_to_pin = mm(8.0);
        translate([component_position[COMPONENT_AT_LOCATION][X] - mainboard_pcb_center_at[X], 0]) {
            if(bottom_or_top=="top" && add_or_remove == "add_outside") {
                translate([(w-a)/2, 0, mainboard_pcb_thickness]) {
                    rotate(180) cube([
                        w,
                        mainboard_pcb_center[Y] + pcb_xy_clearance + mainboard_pcb_thickness,
                        h
                    ]);
                }
            }
        }
    }
}
module StatusLeds(bottom_or_top, add_or_remove) {
    module Hole() {
        pitch = mill(10);
        translate([pitch/4,0, mm(2.0)]) {
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
    if(bottom_or_top=="bottom" && add_or_remove == "add_inside") {
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
    }
    
    module Guide() {
        render() rotate(90, X_AXIS) {
            linear_extrude(mm(3.0), center=true) {
                BIAS = 0.01;
                polygon([
                    [0,0],
                    [mm(2.0), 0],
                    [mm(2.0), -pcb_bottom_clearance - BIAS],
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
            r = mm(4.3);
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
                            cylinder(d=mm(3.2) + 2 * NOZZLE, h = BIAS + mainboard_pcb_thickness);
                        }
                    }
                }
            }
            if(add_or_remove == "remove") {
                if (m3_or_m4 == "M3") {
                    cylinder(
                        d      = mm(3.2),
                        h      = 16,
                        center = true
                    );
                    translate([
                        0,
                        0,
                        max(
                            -pcb_bottom_clearance - case_thickness + mm(2.5),
                            mm(-1.5)
                        )
                    ]) {
                        hull() {
                            mirror(Z_AXIS) linear_extrude(mm(10)) Hex(d=mm(5.5));
                            cylinder(d=mm(3.2),h=mm(0.5));
                        }
                    }
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
                translate([
                    0,
                    0,
                    mainboard_pcb_thickness + pcb_top_clearance - mm(1.0)]
                ) {
                    if (m3_or_m4 == "M3") {
                        M3Screw(length=mm(20), head = mm(5));
                    } else {
                        M4Screw(length=mm(20), head = mm(5));
                    }
                }
            }
        }
    }  
}
module M3Screw(length, head) {
    r_head  = mm(2.5);
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
                        square(mm([w, d]), true);
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
