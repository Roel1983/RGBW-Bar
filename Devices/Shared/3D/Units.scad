include <Units.inc>

$UNITS_NOZZLE = mm(0.4);
$UNITS_LAYER  = mm(0.15);

assert(
    mm(42)
    == 
    42
);
assert(
    nozzle(2)
    ==
    mm(.8)
);
assert(
    mm(2) + nozzle(3)
    ==
    mm(3.2)
);
assert(
    layer(2)
    ==
    mm(0.30)
);
assert(
    m([1, 2])
    ==
    mm([1000, 2000])
);

assert(
    abs(
        radian(1)
        -
        degree(57.29)
    ) < 0.01
);

union() {
    $UNITS_NOZZLE = mm(0.6);

    assert(
        nozzle(2)
        ==
        mm(1.2)
    );
}
union() {
    $UNITS_LAYER  = mm(0.3);
    
    assert(
        layer(2)
        ==
        mm(0.60)
    );
}
