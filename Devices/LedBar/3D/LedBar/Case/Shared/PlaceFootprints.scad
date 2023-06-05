use     <../../../../../Shared/3D/KicadPcbComponent.scad>
use     <Footprint/Footprint.scad>

module PlaceFootprints(components, layer, pcb_thickness, relative_to_component = undef) {
    $pcb_thickness = pcb_thickness;
    for(component = components) {
        ComponentPosition(component, pcb_thickness = pcb_thickness, 
            relative_to_component = relative_to_component
        ) {
            Footprint(
                layer     = layer,
                footprint = component_footprint(component)
            );
        }
    }
}
