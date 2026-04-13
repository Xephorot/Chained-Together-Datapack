## ct:cluster/check_tension — Applies damage/hunger to the cluster if any member
## exceeds max_dist. Tension is measured in ct.tension (×1000 blocks).
## Executed once per tick, after apply_forces.

## Calculate danger threshold: full_thresh from previous tick.
## Use fresh value from config.
execute store result score #full_thresh ct.tick_counter run data get storage ct:main config.max_dist 1000

## Calculate max group tension for the HUD and damage
scoreboard players set #group_tension ct.tick_counter 0
execute as @e[tag=ct_member] if score @s ct.tension > #group_tension ct.tick_counter run scoreboard players operation #group_tension ct.tick_counter = @s ct.tension

## Determine if any member is in critical tension
scoreboard players set #in_tension ct.tick_counter 0
execute as @e[tag=ct_member] if score @s ct.tension > #full_thresh ct.tick_counter run scoreboard players set #in_tension ct.tick_counter 1

## If in tension: apply hunger effect and alert sound
execute if score #in_tension ct.tick_counter matches 1 run function ct:cluster/apply_tension_damage
