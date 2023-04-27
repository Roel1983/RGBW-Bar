
function bounds_margin(bounds, margin) = [
    [bounds[0][0] - margin, bounds[0][1] + margin],
    [bounds[1][0] - margin, bounds[1][1] + margin],
];

assert(
    bounds_margin(
        bounds = [[-10, 20],[-30, 40]],
        margin = 3
    ) == (
        [[-13, 23],[-33,43]]
    )
);