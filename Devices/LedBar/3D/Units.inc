function inch(v) = (
    len(v) == undef ? (
        v * 25.4
    ) : [
        for(i = v) (
            inch(i)
        )
    ]
);
function mill(v) = (
    len(v) == undef ? (
        v * 0.254
    ) : [
        for(i = v) (
            mill(i)
        )
    ]
);
function mm(v) = (
    v
);