use     <../../../../../../../Shared/3D/Utils/Units.scad>

SW_SPST_CK_RS282G05A3(layer = "3D");

module SW_SPST_CK_RS282G05A3(layer) {
    if (layer == "3D") {
        linear_extrude(mm(0.15)) square(mm([8.0, nozzle(2)]), center=true);
        linear_extrude(mm(1.35)) square(mm([6.0, 3.6]), center=true);
        linear_extrude(mm(1.70)) square(mm([4.0, 2.0]), center=true);
        linear_extrude(mm(2.30)) square(mm([2.65, 1.3]), center=true);
    }
}
