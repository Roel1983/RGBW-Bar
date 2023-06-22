use     <../../../../../Shared/3D/Utils/Git.scad>

include <../../Config.inc>

GitRevision("Case.Top.Add.Inner");

module GitRevision(layer) {
    if (layer == "Case.Top.Add.Inner") {
        LayerCaseTopAddInner();
    }
    
    module LayerCaseTopAddInner() {
        translate([
            CASE_BOUNDS_XY[X][0] + CASE_WALL_THICKNESS_VERTICAL,
            mm(0),
            CASE_PCB_Z_FRONT + mm(12)
        ]) {
            rotate(90) rotate(90, VEC_X) {
                linear_extrude(nozzle(2), center = true) {
                    offset(mm(.1)) CommitText(size=mm(5));
                }
            }
        }
    }
}
