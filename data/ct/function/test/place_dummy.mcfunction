## ct:test/place_dummy — Macro: places the dummy N blocks east of the executor.
## Parameters: offset (double) — distance in blocks along X+ axis
## Executed AT the executor player via: execute at @s run function ... {offset: X.0}

$tp @e[tag=ct_dummy,limit=1] ~$(offset) ~ ~
