## ct:view/particles_chain_loop — Draws a particle segment and advances 0.25 blocks toward the anchor.
## Repeats recursively until reaching or exceeding 100 steps.

## Decrement safety counter (max 25 blocks long)
scoreboard players remove #ray_dist ct.tick_counter 1

## Check if we're within 0.5 blocks of the centroid (anchor)
## We use distance=..0.5 against a marker or calculate,
## For optimization: we calculate remaining Chebyshev distance or simple check:
## To avoid heavy logic, we calculate dx, dy, dz from storage:

## Advance 0.25 blocks forward (facing the centroid)
tp @s ^ ^ ^0.25

## Emit chain link particle
particle minecraft:end_rod ~ ~ ~ 0.02 0.02 0.02 0 1 force
particle minecraft:smoke ~ ~ ~ 0.05 0.05 0.05 0 1 force

## Distance check using math
execute store result score #mx ct.tick_counter run data get entity @s Pos[0] 1000
execute store result score #my ct.tick_counter run data get entity @s Pos[1] 1000
execute store result score #mz ct.tick_counter run data get entity @s Pos[2] 1000

## Read centroid
execute store result score #cx ct.tick_counter run data get storage ct:math centroid.x 1000
execute store result score #cy ct.tick_counter run data get storage ct:math centroid.y 1000
execute store result score #cz ct.tick_counter run data get storage ct:math centroid.z 1000

## Delta X
scoreboard players operation #dx ct.tick_counter = #mx ct.tick_counter
scoreboard players operation #dx ct.tick_counter -= #cx ct.tick_counter
execute if score #dx ct.tick_counter matches ..-1 run scoreboard players operation #dx ct.tick_counter *= #neg1 ct.tick_counter

## Delta Y
scoreboard players operation #dy ct.tick_counter = #my ct.tick_counter
scoreboard players operation #dy ct.tick_counter -= #cy ct.tick_counter
execute if score #dy ct.tick_counter matches ..-1 run scoreboard players operation #dy ct.tick_counter *= #neg1 ct.tick_counter

## Delta Z
scoreboard players operation #dz ct.tick_counter = #mz ct.tick_counter
scoreboard players operation #dz ct.tick_counter -= #cz ct.tick_counter
execute if score #dz ct.tick_counter matches ..-1 run scoreboard players operation #dz ct.tick_counter *= #neg1 ct.tick_counter

## Current max distance
scoreboard players operation #mdist ct.tick_counter = #dx ct.tick_counter
execute if score #dy ct.tick_counter > #mdist ct.tick_counter run scoreboard players operation #mdist ct.tick_counter = #dy ct.tick_counter
execute if score #dz ct.tick_counter > #mdist ct.tick_counter run scoreboard players operation #mdist ct.tick_counter = #dz ct.tick_counter

## If #mdist (×1000) > 250 (0.25 blocks) and counter > 0, repeat loop
execute if score #mdist ct.tick_counter matches 251.. if score #ray_dist ct.tick_counter matches 1.. run function ct:view/particles_chain_loop
