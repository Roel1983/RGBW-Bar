use     <../../../../../Shared/3D/Box.scad>
include <../../../../../Shared/3D/Constants.inc>
use     <../../../../../Shared/3D/Units.scad>

include <MainboardKicadPcb.inc>

Mainboard_Pcb();
Mainboard_Components();

module Mainboard_Pcb() {
    color("DarkGreen") {
        linear_extrude(PCB_THICKNESS) {
            difference() {
                Mainboard_EdgeCuts();
            }
        }
    }
}

module Mainboard_EdgeCuts() {
    difference() {
        Box(bounds = PCB_BOUNDS_MAINBOARD);
        for(component = ALL_COMPONENTS) {
            ComponentPosition_Mainboard_2D(component) {
                Footprint(
                    layer     = "Edge.Cuts",
                    footprint = component_footprint(component)
                );
            }
        }
    }
}

module Mainboard_Components() {
    for(component = ALL_COMPONENTS) {
        ComponentPosition_Mainboard_3D(component) {
            Footprint(
                layer     = "3D",
                footprint = component_footprint(component)
            );
        }
    }
    
}

module Footprint(
    layer = "3D",
    footprint
) {
    if(footprint == "RGBW-Bar:perpendicular_pcb_1mm_female_2x6") {
        Footprint__RGBW_Bar__perpendicular_pcb_1mm_female_2x6(layer = layer);
    } else if(footprint == "MountingHole:MountingHole_4.3mm_M4" || 
              footprint == "RGBW-Bar:MountingHole_4.3mm_M4_modified1") {
        Footprint__MountingHole__MountingHole_4_3mm_M4(layer = layer);
    } else if(footprint == "Capacitor_THT:CP_Radial_D10.0mm_P5.00mm") {
        Footprint__Capacitor_THT__CP_Radial(layer = layer, D = mm(10.0), P = mm(5.00), H = mm(20.1));
    } else if(footprint == "LED_THT:LED_D3.0mm") {
        Footprint__LED_THT__LED_D3_0mm(layer = layer, h = mm(4.8));
    } else if(footprint == "RGBW-Bar:Fuseholder_Cylinder-5x20mm_BLX_A_Horizontal") {
        Footprint__RGBW_Bar__Fuseholder_Cylinder_5x20mm_BLX_A_Horizontal(layer = layer);
    } else if(footprint == "Battery:BatteryHolder_LINX_BAT-HLD-012-SMT") {
        Footprint__Battery_BatteryHolder_LINX_BAT_HLD_012_SMT(layer = layer);
    } else if(footprint == "Button_Switch_THT:SW_PUSH_6mm_H4.3mm") {
        Footprint__Button_Switch_THT__SW_PUSH_6mm_H4_3mm(layer = layer);
    } else if(footprint == "RGBW-Bar:B0505S-1W") {
        Footprint__RGBW_Bar__B0505S_1W(layer = layer);
    } else if(footprint == "Button_Switch_SMD:SW_SPST_CK_RS282G05A3") {
        Footprint__Button_Switch_SMD__SW_SPST_CK_RS282G05A3(layer = layer);
    } else if(footprint == "Button_Switch_THT:SW_DIP_SPSTx05_Slide_6.7x14.26mm_W7.62mm_P2.54mm_LowProfile") {
        Footprint__Button_Switch_THT__SW_DIP_SPSTx05_Slide_6_7x14_26mm_W7_62mm_P2_54mm_LowProfile(
            layer = layer,
            channels = 5
        );
    } else if(footprint == "Crystal:Crystal_HC49-U_Vertical") {
        Footprint__Crystal__Crystal_HC49_U_Vertical(layer = layer);
    } else if(footprint == "RGBW-Bar:ISP_P1.27mm_single_row") {
        Footprint__RGBW_Bar__ISP_single_row(layer = layer, P = mm(1.27));
    } else if(footprint == "RGBW-Bar:TestPoint_Pad_D1.0mm") {
        Footprint__RGBW_Bar__TestPoint_Pad(layer = layer, D = mm(1.0));
    } else if(footprint == "RGBW-Bar:15EDGRC-3.5-2P") {
        Footprint__RGBW_Bar__15EDGRC_3_5(layer = layer, pitch = mm(3.5), pins = 2);
    } else if(footprint == "RGBW-Bar:15EDGRC-3.5-3P") {
        Footprint__RGBW_Bar__15EDGRC_3_5(layer = layer, pitch = mm(3.5), pins = 3);
    } else if(footprint == "RGBW-Bar:2EDGRC-5.08-2P") {
    } else if(footprint == "Crystal:Crystal_C38-LF_D3.0mm_L8.0mm_Horizontal_1EP_style1") {
        Footprint__Crystal__Crystal_C38_LF_Horizontal_1EP_style1(layer = layer, D=mm(3.0), L=mm(8.0));
    }
}

module Footprint__RGBW_Bar__perpendicular_pcb_1mm_female_2x6(layer = "3D") {
    if(layer == "Edge.Cuts") {
        hull() {
            translate([0, inch( 0.04)]) circle(mm(0.52));
            translate([0, inch(-0.34)]) circle(mm(0.52));
        }
    }
}

module Footprint__MountingHole__MountingHole_4_3mm_M4(layer = "3D") {
    if(layer == "Edge.Cuts") {
        circle(d = mm(4.3));
    }
}



module Footprint__Capacitor_THT__CP_Radial(layer = "3D", D, P, H) {
    if(layer == "3D") {
        rounding = 0.5;
        foil_thickness = 0.15;
        
        translate([P/2, 0]) {
            render() rotate_extrude() {
                difference() {
                    union() {
                        offset(r=rounding) offset(-rounding)difference() {
                            square([D/2,H]);
                            translate([D/2 + 0.5, 2.0]) circle(d=2.0);
                        }
                        square([D/2-rounding,H]);
                    }
                    translate([0,H]) {
                        square([D-3.0, 2*foil_thickness], center=true);
                    }
                }
            }
        }
    }
}
module Footprint__LED_THT__LED_D3_0mm(layer = "3D", h=0.0) {
    d1 = mm(3.0);
    d2 = mm(3.5);
    t  = mm(1.0);
    h1 = mm(5.1);
    pitch = mill(10);
    h_cylinder = h1-d1/2;
    BIAS = 0.1;
    if(layer == "3D") {
        translate([pitch/2,0]) {
            translate([0, 0, h]) Head();
            cylinder(d= d2 - nozzle(1.5), h=h+BIAS);
        }
    }
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
}

module Footprint__RGBW_Bar__Fuseholder_Cylinder_5x20mm_BLX_A_Horizontal(layer = "3D") {
    if(layer == "3D") {
        w  = mm(28.3);
        d  = mm(10.0);
        h  = mm(13.6);
        px = mm(-4.0);
        translate([
            px,
            -d/2
        ]) cube([
            w, d, h
        ]);
    }
}

module Footprint__Battery_BatteryHolder_LINX_BAT_HLD_012_SMT(layer = "3D") {
    d1 = mm(12.5);
    d2 = mm(10.6);
    h1 = mm( 1.9);
    h2 = mm( 2.5);
    
    if (layer == "3D") {
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
                    mirror_copy(VEC_X) translate([mm(10),0])rotate(45)square(mm(11));
                }
            }
            translate([0,mm(1-.5),-.5])linear_extrude(mm(h2+mm(.5))) {
                 square([d1-mm(.5), mm(11.5)], center=true);
            }
        }
    }
    
    module Battery() {
        translate([0,0,h2]) mirror(VEC_Z) {
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
}

module Footprint__Button_Switch_THT__SW_PUSH_6mm_H4_3mm(layer = "3D", h=mm(4.3)) {
    if(layer == "3D") {
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
                mirror_copy(VEC_X) mirror_copy(VEC_Y) {
                    r = mm(.5);
                    translate(mm([(size-r)/2 ,(size-r)/2])) circle(r=r);
                }
            }
            mirror_copy(VEC_X) mirror_copy(VEC_Y) {
                $fn=16;
                translate([l2/2,l2/2,h1]) {
                    cylinder(d=d2,h=h2*2, center=true);
                }
            }
            translate([0,0,h1-BIAS]) {
                cylinder(d=d1, h=h-h1+BIAS);
            }
            mirror_copy(VEC_Y) {
                translate([0,pitch[1]/2, mm(1)/2]) {
                    cube([pitch[0]+2*pin_size[0], pin_size[1], mm(1)], center=true);
                }
            }
        }
    }
}

module Footprint__RGBW_Bar__B0505S_1W(layer = "3D") {
    if (layer == "3D") {
        pitch = mill(10);
        w  = mm(11.6);
        d  = mm( 6.1);
        h  = mm(10.0);
        py = mm(-0.7);
        px = -(w - pitch * 3) / 2;
        translate([px, py]) cube([w, d, h]);
    }
}

module Footprint__Button_Switch_SMD__SW_SPST_CK_RS282G05A3(layer = "3D") {
    if (layer == "3D") {
        linear_extrude(mm(0.15)) square(mm([8.0, nozzle(2)]), center=true);
        linear_extrude(mm(1.35)) square(mm([6.0, 3.6]), center=true);
        linear_extrude(mm(1.70)) square(mm([4.0, 2.0]), center=true);
        linear_extrude(mm(2.30)) square(mm([2.65, 1.3]), center=true);
    }
}

module Footprint__Button_Switch_THT__SW_DIP_SPSTx05_Slide_6_7x14_26mm_W7_62mm_P2_54mm_LowProfile(
    layer    = "3D",
    channels = 4
) {
    if (layer == "3D") {
        pitch = mill([10, 30]);
        
        a     = (channels - 1) * pitch[0];
        w     = a + mm(4.0);
        d     = mm(9.9);
        h     = mm(4.9);
        
        rotate(-90)translate([0, -(d-pitch[1])/2]) {
            difference() {
                translate([-(w-a)/2, 0]) {
                    cube([w, d, h]);
                }
                for(i=[0:channels-1]) translate([pitch[0]*i,d/2, h]) {
                    cube([pitch[0]-nozzle(2), mm(3.75), mm(2.0)], center=true);
                }
            }
            pattern = [0,1,1,0,1];
            for(i=[0:channels-1]) translate([pitch[0]*i,d/2, h]) {
                mirror_if(pattern[i], VEC_Y) {
                    translate([0,(mm(3.75)-nozzle(4))/2]) {
                        cube([pitch[0]-nozzle(2), nozzle(4), mm(2.1)], center=true);
                    }
                }
            }
        }     
    }
}

module Footprint__Crystal__Crystal_HC49_U_Vertical(layer = "3D", h=mm(3.4)) {
    w   = mm(10.5);
    d   = mm( 3.8);
    rim = mm([0.25, 0.75]);
    pitch = mill(20);

    l = (w - d);

    if (layer == "3D") {
        translate([pitch/2,0]) {
            shape(d + rim[0] * 2, rim[1]);
            shape(d, h);
        }
    }
    
    module shape(d, h) {
        linear_extrude(h) hull() {
            translate([-l/2, 0]) circle(d=d);
            translate([ l/2, 0]) circle(d=d);
        }
    }
}

module Footprint__RGBW_Bar__ISP_single_row(layer = "3D", P = mm(1.27)) {
    if(layer == "Edge.Cuts") {
        pins  = 6;
        pins_size = mm(.47);
        
        for(i=[0:pins-1]) translate([0,-i*P]) {
            circle(d=pins_size);
        }
    }
}

module Footprint__RGBW_Bar__TestPoint_Pad(layer = "3D", D = mm(1.0)) {
    if (layer == "3D") {
        cylinder(d=D, h = layer(1));
    }
}

module Footprint__RGBW_Bar__15EDGRC_3_5(layer = "3D", pitch, pins) {
    if (layer == "3D") {
        a     = (pins - 1) * pitch;
        b     = mm(4.4);
        w     = a + b;
        d     = mm(9.2);
        h     = mm(7.25);
        front_to_pin = mm(8.0);
        
        translate([-(w-a)/2, -(d-front_to_pin)]) {
            cube([w,d,h]);
        }
    }
}

module Footprint__Crystal__Crystal_C38_LF_Horizontal_1EP_style1(
    layer = "3D",
    D=mm(3.0),
    L=mm(8.0)
) {
    if (layer == "3D") {
        pitch = mm(1.9);
        translate([0, mm(-2.3), D/2])
        rotate(90, VEC_X) cylinder(d=D, h=L);
    }
}

module ComponentPosition_Mainboard_2D(component) {
    translate(component_at_loc(component)) {
        side = component_at_side(component);
        if (side == "F") {
            rotate(component_at_rot(component)) {
                children();
            }
        } else {
            rotate(-component_at_rot(component)) {
                children();
            }
        }
    }
}

module ComponentPosition_Mainboard_3D(component) {
    translate(component_at_loc(component)) {
        side = component_at_side(component);
        translate_if(side == "F", [0, 0, PCB_THICKNESS]) {
            rotate(component_at_rot(component)) {
                rotate_if(side == "B", 180, VEC_X)
                children();
            }
        }
    }
}

module translate_if(condition, vec) {
    if(condition) {
        translate(vec) children();
    } else {
        children();
    }
}

module rotate_if(condition, a, vec) {
    if(condition) {
        rotate(a, vec) children();
    } else {
        children();
    }
}

module mirror_if(condition, vec) {
    if(condition) {
        mirror(vec) children();
    } else {
        children();
    }
}
module mirror_copy(vec) {
    children();
    mirror(vec) children();
}