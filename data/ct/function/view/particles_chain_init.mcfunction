## ct:view/particles_chain_init — Initializes chain drawing.
## Runs every few ticks to draw lines between members and the centroid.
## For simplicity, we trace from each member to the centroid.

## 1. Summon or find the chain marker (we only need one)
execute unless entity @e[type=marker,tag=ct_chain_ray,limit=1] run summon marker ~ ~ ~ {Tags:["ct_chain_ray"]}

## 2. For each member, trace the chain to the centroid (already calculated)
execute as @e[tag=ct_member] run function ct:view/particles_chain_ray
