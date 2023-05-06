use     <../../../../../Shared/3D/KicadPcbComponent.scad>
use     <Footprint/Footprint.scad>

module PlaceFootprints(components, layer, pcb_thickness) {
    $pcb_thickness = pcb_thickness;
    for(component = components) {
        ComponentPosition(component, pcb_thickness = pcb_thickness) {
            Footprint(
                layer     = layer,
                footprint = component_footprint(component)
            );
        }
    }
}
