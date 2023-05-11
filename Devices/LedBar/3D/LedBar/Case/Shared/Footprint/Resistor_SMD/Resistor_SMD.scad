use <R_0805_2012Metric_Pad1_20x1_40mm_HandSolder.scad>
use <R_1210_3225Metric_Pad1_30x2_65mm_HandSolder.scad>
use <R_2512_6332Metric_Pad1_40x3_35mm_HandSolder.scad>

module Resistor_SMD(layer, footprint) {
    if(footprint == "R_0805_2012Metric_Pad1.20x1.40mm_HandSolder") {
        R_0805_2012Metric_Pad1_20x1_40mm_HandSolder(layer);
    } else if(footprint == "R_1210_3225Metric_Pad1.30x2.65mm_HandSolder") {
        R_1210_3225Metric_Pad1_30x2_65mm_HandSolder(layer);
    } else if(footprint == "R_2512_6332Metric_Pad1.40x3.35mm_HandSolder") {
        R_2512_6332Metric_Pad1_40x3_35mm_HandSolder(layer);
    }
}
