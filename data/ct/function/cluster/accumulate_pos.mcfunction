## ct:cluster/accumulate_pos — Helper for calc_centroid.
## Executed AS each ct_member. Adds its position (×1000) to the accumulators.
## Uses temporary fake players #tmp_pos to NOT interfere with the player's ct.tension.

execute store result score #tmp_pos ct.tick_counter run data get entity @s Pos[0] 1000
scoreboard players operation #sum_x ct.tick_counter += #tmp_pos ct.tick_counter

execute store result score #tmp_pos ct.tick_counter run data get entity @s Pos[1] 1000
scoreboard players operation #sum_y ct.tick_counter += #tmp_pos ct.tick_counter

execute store result score #tmp_pos ct.tick_counter run data get entity @s Pos[2] 1000
scoreboard players operation #sum_z ct.tick_counter += #tmp_pos ct.tick_counter
