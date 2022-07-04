include<LedbarPcb.inc>
include<Constants.inc>
include<TransformCopy.inc>
include<TransformIf.inc>
include<Units.inc>

$fn=32;
MainBoard(with_child_board=true);

module MainBoard(with_child_board=true) {
    MainBoard_PCB();

    MainBoard_At(BT901_at) BattCr1225();

    MainBoard_At(C503_at)  CpRadialP2(d=mm(10.2), h=mm(20.7), pitch=mm(5.0));
    MainBoard_At(C505_at)  CpRadialP2(d=mm(10.2), h=mm(20.7), pitch=mm(5.0));

    MainBoard_At(D701_at)  Led3mm(h=mm(3.0), color="Blue");
    MainBoard_At(D702_at)  Led3mm(h=mm(3.0), color="Red");
    MainBoard_At(D703_at)  Led3mm(h=mm(3.0), color="Orange");
    MainBoard_At(D704_at)  Led3mm(h=mm(3.0), color="Yellow");
    MainBoard_At(D705_at)  Led3mm(h=mm(3.0), color="Lime");

    MainBoard_At(F301_at)  FuseHolder5x20mm();

    MainBoard_At(J301_at)  Conn15EDGRC(pins=2, pitch = mm(3.81));
    MainBoard_At(J401_at)  Conn15EDGRC(pins=3, pitch = mm(3.5));
    MainBoard_At(J501_at)  ConnPH(pins=5);
    if(with_child_board) {
        MainBoard_At(J502_at)  PerpendicularBoard();
    }
    MainBoard_At(J503_at)  ConnPH(pins=5);
    MainBoard_At(J601_at)  Conn15EDGRC(pins=2, pitch = mm(3.5));

    MainBoard_At(SW701_at) SwPuch6mm(mm(8.0));
    MainBoard_At(SW702_at) SmdSwitch();
    MainBoard_At(SW703_at) SwDip(channels=5);

    MainBoard_At(U402_at)  B0505S();

    MainBoard_At(Y701_at)  Hc49(h=mm(3.4));
}

module MainBoard_PCB() {
    module MainBoard_BoardOutline() {
        module MainBoard_BoardOutline_outer() {
            hull() {
                translate(inch([-1.23, -1.38])) circle(r=inch(0.02));
                translate(inch([ 1.23, -1.38])) circle(r=inch(0.02));
                translate(inch([ 1.23,  1.48])) circle(r=inch(0.02));
                translate(inch([-1.23,  1.48])) circle(r=inch(0.02));
            }
        }
        difference() {
            MainBoard_BoardOutline_outer();
            
            MainBoard_At_2D(H201_at) MountingHoleM4_BoardOutline();
            MainBoard_At_2D(H202_at) MountingHoleM4_BoardOutline();
            MainBoard_At_2D(H203_at) MountingHoleM4_BoardOutline();
            MainBoard_At_2D(H204_at) MountingHoleM4_BoardOutline();
            MainBoard_At_2D(J502_at) PerpendicularPcb1mmFemale_BoardOutline(6);
            
            MainBoard_At_2D(J701_at) ConnIsp1_27mm_BoardOutline();
        }
    }
    BIAS=0.01;
    Color("Green") linear_extrude(mainboard_pcb_thickness+BIAS) {
        MainBoard_BoardOutline();
    }
}



module PerpendicularBoard(with_child_board=true) {
    rotate(90, Y_AXIS)rotate(-90) {
        translate(mm([
            -(J1001_at[COMPONENT_AT_LOCATION][X] - mainboard_pcb_center_at[0]),
            -(mainboard_pcb_center_at[1] - J1001_at[COMPONENT_AT_LOCATION][Y]),
            -mainboard_pcb_thickness / 2
        ])) {
            PerpendicularBoard_PCB();
            MainBoard_At(J1002_at) {
                if (with_child_board) {
                    rotate(180) rotate(90, Y_AXIS) translate([-mm(1.5),0,mm(7.2)]) CenterBoard();
                }
                rotate(-90) rotate(90, X_AXIS) translate(mm([0,-.5])) {
                    Conn2mmFemale(2, 6);
                }
            }
        }
    }
}

module PerpendicularBoard_PCB() {
    module Outline() {
        $fn=16;
        mirror(Y_AXIS)translate(-mainboard_pcb_center_at)difference() {
            polygon(mm([
                [153.67, 47.879],
                [153.67, 64.516],
                [158.242, 69.088],
                [168.529, 58.801],
                [168.402, 56.896],
                [169.418, 55.88],
                [169.418, 47.879],
                [166.37, 47.879],
                [166.37, 45.466],
                [156.718, 45.466],
                [156.718, 47.879]
            ]));
            translate(mm([155.718, 47.879]))circle(r=mm(1));
            translate(mm([167.37, 47.879]))circle(r=mm(1));
            translate(mm([169.291, 57.785]))circle(r=mm(1.257237));
        }
    }
    BIAS=0.01;
    Color("Green") linear_extrude(mainboard_pcb_thickness+BIAS) {
        Outline();
    }
}
module CenterBoard() {
    translate(mm([
        -(J1202_at[COMPONENT_AT_LOCATION][X] - mainboard_pcb_center_at[0]),
        -(mainboard_pcb_center_at[1] - J1202_at[COMPONENT_AT_LOCATION][Y]),
        -mainboard_pcb_thickness/2
    ])) {
        CenterBoard_PCB();
        MainBoard_At(J1202_at) Conn2mmMale(2, 6);
    }
}
module CenterBoard_PCB() {
    module Outline() {
        $fn = 16;
        difference() {
            mirror(Y_AXIS)translate(-mainboard_pcb_center_at) hull() {
                translate([133.096, 45.974]) circle(r=0.508);
                translate([150.622, 45.974]) circle(r=0.508);
                translate([150.622, 68.072]) circle(r=0.508);
                translate([133.096, 68.072]) circle(r=0.508);
            }
            MainBoard_At_2D(H1204_at) MountingHoleM3_BoardOutline();
        }
    }
    BIAS=0.01;
    Color("Green") linear_extrude(mainboard_pcb_thickness+BIAS) {
        Outline();
    }
}

module PerpendicularPcb1mmFemale_BoardOutline(pins = 6) {
    hull() {
        translate(inch([0, 0.04                ])) circle(r=mm(0.52));
        translate(inch([0, - pins * 0.06 + 0.02])) circle(r=mm(0.52));
    }
}

module MountingHoleM4_BoardOutline() {
    circle(d=mm(4.3));
}
module MountingHoleM3_BoardOutline() {
    circle(d=mm(3.2));
}

module ConnIsp1_27mm_BoardOutline() {
    $fn=16;
    pitch = mm(1.27);
    pins  = 6;
    pins_size = mm(.47);
    
    for(i=[0:pins-1]) translate([0,-i*pitch]) {
        circle(d=pins_size);
    }
}

module Conn15EDGRC(pins, pitch) {
    a     = (pins - 1) * pitch;
    w     = a + mm(5.2);
    d     = mm(9.2);
    h     = mm(7.25);
    front_to_pin = mm(8.0);
    
    Color("MediumSeaGreen") translate([-(w-a)/2, -(d-front_to_pin)]) {
        cube([w,d,h]);
    }
}

module ConnPH(pins = 2) {
    pitch = mill(10);
    a     = (pins - 1) * pitch;
    w     = a + mm(4.6);
    d     = mm(7.0);
    h     = mm(5.9);
    front_to_pin = mm(7.0);
    
    Color("GhostWhite") rotate(-90) translate([-(w-a)/2, -(d-front_to_pin)]) {
        cube([w,d,h]);
    }
}

module Conn2mmFemale(rows, columns) {
    pitch = mm(2.0);
    Color("DimGray") translate([-pitch/2,-pitch/2]) {
        cube([pitch * columns, pitch * rows, mm(4.3)]);
    }
}
module Conn2mmMale(rows, columns) {
    pitch = mm(2.0);
    Color("DimGray") translate([-pitch/2,-pitch * columns+pitch/2]) {
        cube([pitch * rows, pitch * columns, mm(2.2)]);
    }
}
module SwDip(channels = 8) {
    pitch = mill([10, 30]);
    
    a     = (channels - 1) * pitch[0];
    w     = a + mm(4.0);
    d     = mm(9.9);
    h     = mm(4.9);
    
    rotate(-90)translate([0, -(d-pitch[1])/2]) {
        Color("Blue") difference() {
            translate([-(w-a)/2, 0]) {
                cube([w, d, h]);
            }
            for(i=[0:channels-1]) translate([pitch[0]*i,d/2, h]) {
                cube([pitch[0]-NOZZLE*2, mm(3.75), mm(2.0)], center=true);
            }
        }
        pattern = [0,1,1,0,1];
        Color("GhostWhite") for(i=[0:channels-1]) translate([pitch[0]*i,d/2, h]) {
            mirror_if(pattern[i], Y_AXIS) {
                translate([0,(mm(3.75)-NOZZLE*4)/2]) {
                    cube([pitch[0]-NOZZLE*2, NOZZLE*4, mm(2.1)], center=true);
                }
            }
        }
    }     
}

module CpRadialP2(d, h, pitch) {
    rounding = 0.5;
    foil_thickness = 0.15;
    
    translate([pitch/2, 0]) {
        Color("DodgerBlue") render() rotate_extrude() {
            difference() {
                union() {
                    offset(r=rounding) offset(-rounding)difference() {
                        square([d/2,h]);
                        translate([d/2 + 0.5, 2.0]) circle(d=2.0);
                    }
                    square([d/2-rounding,h]);
                }
                translate([0,h]) {
                    square([d-3.0, 2*foil_thickness], center=true);
                }
            }
        }
    }
}
module Led3mm(h=0.0, color="Red") {
    $fn = 32;
    d1 = mm(3.0);
    d2 = mm(3.5);
    t  = mm(1.0);
    h1 = mm(5.1);
    pitch = mill(5);
    h_cylinder = h1-d1/2;
    BIAS = 0.1;
    
    module Head() {
        render() {
            linear_extrude(t)intersection() {
                circle(d=d2);
                translate([(d2-d1)/2,0])square(d2, center=true);
            }
            cylinder(d=d1, h=h_cylinder);
            translate([0,0,h_cylinder]) sphere(d=d1);
        }
    }
    
    translate([pitch/2,0]) {
        Color(color) translate([0, 0, h]) Head();
        Color("black")cylinder(d= d2 - 1.5*NOZZLE, h=h+BIAS);
    }
} 

module FuseHolder5x20mm() {
    w = mm(28.3);
    d = mm(10.0);
    h = mm(13.6);
    px = mm(-4.0);
    Color("DimGray") translate([
        px,
        -d/2
    ]) cube([
        w, d, h
    ]);
}

module BattCr1225() {
    d1 = mm(12.5);
    d2 = mm(10.6);
    h1 = mm( 1.9);
    h2 = mm( 2.5);
    module Battery() {
        
        translate([0,0,h2]) mirror(Z_AXIS) {
            rotate_extrude() {
                disk_2D(d1, h1, mm(0.8));
                disk_2D(d2, h2, mm(0.4));
            }
        }
        
        module disk_2D(d, h, r) {
            $fn=16;
            polygon([
                [0,0],
                [d/2,0],
                [d/2,h-r],
                [d/2-r,h],
                [0,h]
            ]);
            translate([d/2-r,h-r]) circle(r=r);
        }
    }
    Color("LightGrey") {
        Battery();
        linear_extrude(mm(0.25)) square([mm(17), mm(2.5)], center=true);
        render() difference() {
            linear_extrude(mm(h2+mm(.5))) {
                difference() {
                    r = mm(1.5);
                    offset(r=r)offset(-r)difference() {
                        translate([0,mm(1)])square([d1+mm(.5), mm(11.5)], center=true);
                        translate([0, -d1/4*3]) circle(d=d1);
                    }
                    mirror_copy(X_AXIS) translate([mm(10),0])rotate(45)square(mm(11));
                }
            }
            translate([0,mm(1-.5),-.5])linear_extrude(mm(h2+mm(.5))) {
                 square([d1-mm(.5), mm(11.5)], center=true);
            }
        }
    }
}

module SwPuch6mm(h=mm(4.3)) {
    BIAS  = 0.1;
    size  = mm(6.0);
    pitch = mm([6.5, 4.5]);
    pin_size = mm([.7,.7]);
    h1    = mm(3.5);
    d1    = mm(3.5);
    d2    = mm(1.3);
    l2    = mm(4.0);
    h2    = mm(0.5);
    translate([pitch[0]/2, -pitch[1]/2]) {
        linear_extrude(h1) hull() {
            $fn=16;
            mirror_copy(X_AXIS) mirror_copy(Y_AXIS) {
                r = mm(.5);
                translate(mm([(size-r)/2 ,(size-r)/2])) circle(r=r);
            }
        }
        mirror_copy(X_AXIS) mirror_copy(Y_AXIS) {
            $fn=16;
            translate([l2/2,l2/2,h1]) {
                cylinder(d=d2,h=h2*2, center=true);
            }
        }
        Color([.2,.2,.2]) {
            translate([0,0,h1-BIAS]) {
                cylinder(d=d1, h=h-h1+BIAS);
            }
        }
        mirror_copy(Y_AXIS) {
            translate([0,pitch[1]/2, mm(1)/2]) {
                cube([pitch[0]+2*pin_size[0], pin_size[1], mm(1)], center=true);
            }
        }
    }
}

module SmdSwitch() {
    linear_extrude(mm(0.15)) square(mm([8.0, NOZZLE*2]), center=true);
    linear_extrude(mm(1.35)) square(mm([6.0, 3.6]), center=true);
    linear_extrude(mm(1.70)) square(mm([4.0, 2.0]), center=true);
    linear_extrude(mm(2.30)) square(mm([2.65, 1.3]), center=true);
}

module B0505S() {
    pitch = mill(10);
    w  = mm(11.6);
    d  = mm( 6.1);
    h  = mm(10.0);
    py = mm(-0.7);
    px = -(w - pitch * 3) / 2;
    Color("DimGray") translate([px, py]) cube([w, d, h]);
}

module Hc49(h=mm(3.4)) {
    w   = mm(10.5);
    d   = mm( 3.8);
    rim = mm([0.25, 0.75]);
    pitch = mill(20);
    
    l = (w - d);
    
    module shape(d, h) {
        linear_extrude(h) hull() {
            translate([-l/2, 0]) circle(d=d);
            translate([ l/2, 0]) circle(d=d);
        }
    }
    Color("LightGrey") translate([pitch/2,0]) {
        shape(d + rim[0] * 2, rim[1]);
        shape(d, h);
    }
}



module MainBoard_At(component_position) {
    if (component_position[COMPONENT_AT_SIDE][0] == "F") {
        MainBoard_At_Front(component_position) children();
    } else if (component_position[0][0] == "B") {
        MainBoard_At_Back(component_position) children();
    }
}

module MainBoard_At_Front(component_position) {
    MainBoard_At_2D(component_position) {
        translate([0,0,mainboard_pcb_thickness]) {
            children();
        }
    }
}

module MainBoard_At_Back(component_position) {
    MainBoard_At_2D(component_position) {
        rotate(180, [1,0,0]) children();
    }
}

function mainboard_at_xy(component_position) = mm([
    component_position[COMPONENT_AT_LOCATION][X] - mainboard_pcb_center_at[X],
    mainboard_pcb_center_at[Y] - component_position[COMPONENT_AT_LOCATION][Y]
]);
function mainboard_at_rotate(component_position) = (
    (len(component_position) < COMPONENT_AT_ROTATION) ? (
        0
    ) : (
        component_position[COMPONENT_AT_ROTATION]
    )
);
module MainBoard_At_2D(component_position, rotate=true) {
    translate(
        mainboard_at_xy(component_position)
    ) rotate_if(
        rotate,
        mainboard_at_rotate(component_position)
    ) {
            children();
    }
}
module Color(c) {
    color(c) children();
}