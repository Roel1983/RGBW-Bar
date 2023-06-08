UNITS_NOZZLE = mm(.4);
UNITS_LAYER  = mm(0.15);
use     <Units.scad>
use     <TextFunctions.scad>
GIT_REVISION = "0123456789ABCDEF+";

DEFAULT_SIZE = nozzle(8);

CommitText();

module CommitText(
    size   = undef,
    len    = undef,
    font   = "Arial",
    halign = "center",
    valign = "center"
) {
    if(!is_undef(GIT_REVISION)) {
        _len      = is_undef(len)?7:len;
        l         = len(GIT_REVISION);
        last_char = ((l > 0)?(GIT_REVISION[l - 1]):"");
        _text = ((is_hexadecimal_char(last_char))?(
            sub_text(GIT_REVISION, len = _len)    
        ):(
            str(sub_text(GIT_REVISION, len = _len-1), GIT_REVISION[l - 1])
        ));
        text(
            text   = _text,
            size   = is_undef(size)?DEFAULT_SIZE:size,
            font   = font,
            valign = valign,
            halign = halign
        );
    }
}
