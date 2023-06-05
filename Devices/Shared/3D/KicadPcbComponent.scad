include <Utils/Constants.inc>
use     <Utils/TransformIf.scad>

// Getter functions
function ref_id(ref)  = ref[0];
function ref_nr(ref)  = ref[1];
function ref_str(ref) = str(ref_id(ref), ref_nr(ref));

function at_side(at)  = at[0];
function at_loc(at)   = at[1];
function at_rot(at)   = at[2];

function component_ref      (component) = component[0];
function component_ref_id   (component) = ref_id (component_ref(component));
function component_ref_nr   (component) = ref_nr (component_ref(component));
function component_ref_str  (component) = ref_str(component_ref(component));
function component_at       (component) = component[1];
function component_at_side  (component) = at_side(component_at(component));
function component_at_loc   (component) = at_loc (component_at(component));
function component_at_rot   (component) = at_rot (component_at(component));
function component_footprint(component) = component[2];

module ComponentPosition(component, pcb_thickness, rotate = true, invert=false, relative_to_component = undef) {
    if(relative_to_component == undef) {
        a = invert?-1:1;
        if(!is_undef(pcb_thickness)) {
            translate(a * component_at_loc(component)) {
                side = component_at_side(component);
                translate_if(side == "F", [0, 0, pcb_thickness]) {
                    rotate_if(rotate, a * component_at_rot(component)) {
                        rotate_if(side == "B", 180, VEC_X)
                        children();
                    }
                }
            }
        } else {    
            translate(a * component_at_loc(component)) {
                side = component_at_side(component);
                if (side == "F") {
                    rotate_if(rotate, a * component_at_rot(component)) {
                        children();
                    }
                } else {
                    rotate_if(rotate, a * -component_at_rot(component)) {
                        children(); // TODO mirror
                    }
                }
            }
        }
    } else {
        ComponentPosition(component = relative_to_component, rotate=false, invert=true) {
            ComponentPosition(component = component, pcb_thickness = pcb_thickness) {
                children();
            }
        }
    }
}
