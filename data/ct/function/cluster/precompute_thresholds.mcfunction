## ct:cluster/precompute_thresholds — Macro: converts max_dist (double) to integers ×1000
## and writes thresholds to ct:math storage for use in eval_player_force.
## Parameters: max_dist (double), resistance (double), weight (double), elastic (byte)

## full_thresh_i = max_dist * 1000 (pure integer, no suffix)
execute store result storage ct:math thresholds.full_i int 1000 run data get storage ct:main config.max_dist 1
## half_thresh_i = max_dist * 500 (pure integer)
execute store result storage ct:math thresholds.half_i int 500 run data get storage ct:main config.max_dist 1

## resistance_i: negated integer ×1000 (e.g. 0.4 -> -400)
execute store result score #res_i ct.tick_counter run data get storage ct:main config.resistance 1000
scoreboard players operation #res_i ct.tick_counter *= #neg1 ct.tick_counter
execute store result storage ct:math thresholds.resistance_i int 1 run scoreboard players get #res_i ct.tick_counter

## elastic: convert byte to int (1b -> 1, 0b -> 0) no suffix
execute store result storage ct:math thresholds.elastic_i int 1 run data get storage ct:main config.elastic 1
