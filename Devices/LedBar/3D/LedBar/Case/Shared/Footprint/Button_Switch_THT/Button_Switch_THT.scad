use <SW_DIP_SPSTx05_Slide_6_7x14_26mm_W7_62mm_P2_54mm_LowProfile.scad>
use <SW_PUSH_6mm_H4_3mm.scad>

module Button_Switch_THT(layer, footprint) {
    if(footprint == "SW_PUSH_6mm_H4.3mm") {
        SW_PUSH_6mm_H4_3mm(layer = layer);
    } else if(footprint == "SW_DIP_SPSTx05_Slide_6.7x14.26mm_W7.62mm_P2.54mm_LowProfile") {
        SW_DIP_SPSTx05_Slide_6_7x14_26mm_W7_62mm_P2_54mm_LowProfile(layer = layer, channels = 5);
    }
}
