## ct:cluster/apply_tension_damage — Applies negative effects to the entire cluster
## when there is critical tension (someone exceeds max_dist).
## Effect: hunger + slowness, and damage at extreme tension.

## Calculate threshold limits
scoreboard players set #two ct.tick_counter 2
scoreboard players operation #double_thresh ct.tick_counter = #full_thresh ct.tick_counter
scoreboard players operation #double_thresh ct.tick_counter *= #two ct.tick_counter

## Apply hunger and slowness to everyone
execute if score #group_tension ct.tick_counter > #full_thresh ct.tick_counter run effect give @a[tag=ct_member] minecraft:hunger 2 1 true
execute if score #group_tension ct.tick_counter > #full_thresh ct.tick_counter run effect give @a[tag=ct_member] minecraft:slowness 2 0 true

## Manage damage tick counter (triggers damage every 20 ticks = 1 second)
scoreboard players add #dmg_tick ct.tick_counter 1
execute if score #dmg_tick ct.tick_counter matches 20.. run scoreboard players set #dmg_tick ct.tick_counter 0

## Apply 1 damage every 1 second if tension is critical (> full_thresh)
execute if score #group_tension ct.tick_counter > #full_thresh ct.tick_counter if score #dmg_tick ct.tick_counter matches 0 as @a[tag=ct_member,gamemode=!creative] run damage @s 1 generic
