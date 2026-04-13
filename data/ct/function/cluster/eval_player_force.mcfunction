## ct:cluster/eval_player_force — No macros. Reads thresholds from global scoreboards.
## Executed AS each ct_member from apply_forces_per_player.
## Thresholds #half_thresh, #full_thresh, #res_mod, #elastic_flag are already set
## by apply_forces before calling this function.

## ── Position of @s ×1000 ─────────────────────────────────────────────────────
execute store result score #px ct.tick_counter run data get entity @s Pos[0] 1000
execute store result score #py ct.tick_counter run data get entity @s Pos[1] 1000
execute store result score #pz ct.tick_counter run data get entity @s Pos[2] 1000

## ── Centroid ×1000 ───────────────────────────────────────────────────────────
execute store result score #cx ct.tick_counter run data get storage ct:math centroid.x 1000
execute store result score #cy ct.tick_counter run data get storage ct:math centroid.y 1000
execute store result score #cz ct.tick_counter run data get storage ct:math centroid.z 1000

## ── Delta ×1000 ───────────────────────────────────────────────────────────────
scoreboard players operation #dx ct.tick_counter = #px ct.tick_counter
scoreboard players operation #dx ct.tick_counter -= #cx ct.tick_counter
scoreboard players operation #dy ct.tick_counter = #py ct.tick_counter
scoreboard players operation #dy ct.tick_counter -= #cy ct.tick_counter
scoreboard players operation #dz ct.tick_counter = #pz ct.tick_counter
scoreboard players operation #dz ct.tick_counter -= #cz ct.tick_counter

## ── Absolute values ─────────────────────────────────────────────────────────
scoreboard players operation #adx ct.tick_counter = #dx ct.tick_counter
execute if score #adx ct.tick_counter matches ..-1 run scoreboard players operation #adx ct.tick_counter *= #neg1 ct.tick_counter
scoreboard players operation #ady ct.tick_counter = #dy ct.tick_counter
execute if score #ady ct.tick_counter matches ..-1 run scoreboard players operation #ady ct.tick_counter *= #neg1 ct.tick_counter
scoreboard players operation #adz ct.tick_counter = #dz ct.tick_counter
execute if score #adz ct.tick_counter matches ..-1 run scoreboard players operation #adz ct.tick_counter *= #neg1 ct.tick_counter

## ── Chebyshev distance ×1000 ────────────────────────────────────────────────
scoreboard players operation #dist ct.tick_counter = #adx ct.tick_counter
execute if score #ady ct.tick_counter > #dist ct.tick_counter run scoreboard players operation #dist ct.tick_counter = #ady ct.tick_counter
execute if score #adz ct.tick_counter > #dist ct.tick_counter run scoreboard players operation #dist ct.tick_counter = #adz ct.tick_counter

## ── Store member tension ──────────────────────────────────────────────────
scoreboard players operation @s ct.tension = #dist ct.tick_counter

## ── Speed modifier (players only) ─────────────────────────────────────────
execute if entity @s[type=player] run attribute @s minecraft:movement_speed modifier remove ct:resist
execute if entity @s[type=player] run attribute @s minecraft:movement_speed modifier remove ct:stop
execute if entity @s[type=player] run attribute @s minecraft:jump_strength modifier remove ct:stop_jump
execute if entity @s[type=player] run attribute @s minecraft:gravity modifier remove ct:stop_grav

execute if entity @s[type=player] if score #dist ct.tick_counter >= #half_thresh ct.tick_counter store result storage ct:math res_val double 0.001 run scoreboard players get #res_mod ct.tick_counter
execute if entity @s[type=player] if score #dist ct.tick_counter >= #half_thresh ct.tick_counter run function ct:cluster/apply_resist with storage ct:math

## Stop gravity and jumping when exceeding max distance (firm hanging boundary)
execute if entity @s[type=player] if score #dist ct.tick_counter >= #full_thresh ct.tick_counter run attribute @s minecraft:jump_strength modifier add ct:stop_jump -1 add_multiplied_total
execute if entity @s[type=player] if score #dist ct.tick_counter >= #full_thresh ct.tick_counter run attribute @s minecraft:gravity modifier add ct:stop_grav -1 add_multiplied_total

## ── Elastic pull ──────────────────────────────────────────────────────────────
execute if score #dist ct.tick_counter >= #full_thresh ct.tick_counter if score #elastic_flag ct.tick_counter matches 1 run function ct:cluster/pull_to_centroid
