## ct:cluster/apply_forces — Applies resistance and pull to each member.
## Executed once per tick from tick.mcfunction.

## ── Thresholds from config (integers ×1000) ─────────────────────────────────────
execute store result score #full_thresh ct.tick_counter run data get storage ct:main config.max_dist 1000
execute store result score #half_thresh ct.tick_counter run data get storage ct:main config.max_dist 500

## resistance_i: negated ×1000
execute store result score #res_mod ct.tick_counter run data get storage ct:main config.resistance 1000
scoreboard players operation #res_mod ct.tick_counter *= #neg1 ct.tick_counter

## max pull config (max elastic pull force)
scoreboard players set #max_pull ct.tick_counter 15

## elastic_flag: byte→int
execute store result score #elastic_flag ct.tick_counter run data get storage ct:main config.elastic 1

## ── Calculate tension per member (distance to nearest member) ──────────────
execute as @e[tag=ct_member] at @s run function ct:cluster/calc_tension_nearest

## Always clear resistance (restore speed when returning to center)
execute as @a[tag=ct_member] run attribute @s minecraft:movement_speed modifier remove ct:resist

## Soft resistance: tension >= half_thresh
execute as @a[tag=ct_member] if score @s ct.tension >= #half_thresh ct.tick_counter at @s store result storage ct:math res_val double 0.001 run scoreboard players get #res_mod ct.tick_counter
execute as @a[tag=ct_member] if score @s ct.tension >= #half_thresh ct.tick_counter at @s run function ct:cluster/apply_resist with storage ct:math

## Pull members with tension >= full_thresh
execute as @e[tag=ct_member] if score @s ct.tension >= #full_thresh ct.tick_counter if score #elastic_flag ct.tick_counter matches 1 at @s run function ct:cluster/pull_to_centroid
