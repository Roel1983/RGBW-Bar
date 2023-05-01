use <BatteryHolder_LINX_BAT_HLD_012_SMT.scad>

module Battery (layer, footprint) {
    if(footprint == "BatteryHolder_LINX_BAT-HLD-012-SMT") {
        BatteryHolder_LINX_BAT_HLD_012_SMT(layer = layer);
    }
}
