## ct:view/particles_chain_ray — Casts the visual ray (the chain) from the member to the anchor.
## Executed AS @e[tag=ct_member] (player or dummy).

## 1. Move the marker to the executor (player center + 1 block height)
execute at @s run teleport @e[type=marker,tag=ct_chain_ray,limit=1] ~ ~1 ~

## 2. Point the marker toward the global anchor (which is the centroid in storage)
## We use a second marker or the same temporary anchor to look at
## Trick: Create a dummy entity at the anchor to look at, or use macro
function ct:view/particles_chain_target with storage ct:main clusters[0].anchor

## 3. Initialize max distance counter (to prevent infinite loops)
scoreboard players set #ray_dist ct.tick_counter 100

## 4. Execute the drawing loop
execute as @e[type=marker,tag=ct_chain_ray,limit=1] at @s run function ct:view/particles_chain_loop
