## ct:view/particles_chain_target — Macro to orient the marker toward the centroid (anchor).
## Parameters from ct:main clusters[0].anchor: x, y, z (doubles)

$execute as @e[type=marker,tag=ct_chain_ray,limit=1] at @s facing $(x) $(y) $(z) run teleport @s ~ ~ ~ ~ ~
