## ct:cluster/calc_centroid — Calculates the cluster centroid.
## Reads ct:math points[] and ct:math member_count.
## Writes result to ct:math centroid {x,y,z}.
## Strategy: scoreboard integers (×1000 for sub-block precision).

## ── Reset accumulators ─────────────────────────────────────────────────────────
scoreboard players set #sum_x ct.tick_counter 0
scoreboard players set #sum_y ct.tick_counter 0
scoreboard players set #sum_z ct.tick_counter 0
scoreboard players set #count ct.tick_counter 0

## ── Accumulate positions from each member ─────────────────────────────────
## Each player writes its position (×1000 integer) to temporary scoreboards
execute at @e[tag=ct_member,limit=1] as @e[tag=ct_member] at @s run function ct:cluster/accumulate_pos

## ── Divide by member count to get the centroid ───────────────────────────
## Store count in a fake player and divide
execute store result score #count ct.tick_counter at @e[tag=ct_member,limit=1] if entity @e[tag=ct_member]

## Calculate centroid X
scoreboard players operation #cx ct.tick_counter = #sum_x ct.tick_counter
scoreboard players operation #cx ct.tick_counter /= #count ct.tick_counter

## Calculate centroid Y
scoreboard players operation #cy ct.tick_counter = #sum_y ct.tick_counter
scoreboard players operation #cy ct.tick_counter /= #count ct.tick_counter

## Calculate centroid Z
scoreboard players operation #cz ct.tick_counter = #sum_z ct.tick_counter
scoreboard players operation #cz ct.tick_counter /= #count ct.tick_counter

## ── Write centroid to storage (divide ×1000 back to double) ───────────────
execute store result storage ct:math centroid.x double 0.001 run scoreboard players get #cx ct.tick_counter
execute store result storage ct:math centroid.y double 0.001 run scoreboard players get #cy ct.tick_counter
execute store result storage ct:math centroid.z double 0.001 run scoreboard players get #cz ct.tick_counter

## ── Update the persistent cluster anchor ───────────────────────────────────────
data modify storage ct:main clusters[0].anchor.x set from storage ct:math centroid.x
data modify storage ct:main clusters[0].anchor.y set from storage ct:math centroid.y
data modify storage ct:main clusters[0].anchor.z set from storage ct:math centroid.z
