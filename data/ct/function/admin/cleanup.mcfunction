## ct:admin/cleanup — Removes residual entities with ct_member tag that are NOT valid players or dummies.
## Usage: /function ct:admin/cleanup

## Count ct_member entities before cleanup
scoreboard players set #cleanup_count ct.tick_counter 0

## Remove armor stands that have ct_member but NOT ct_dummy (residuals from previous tests)
execute as @e[tag=ct_member,type=armor_stand,tag=!ct_dummy] run scoreboard players add #cleanup_count ct.tick_counter 1
execute as @e[tag=ct_member,type=armor_stand,tag=!ct_dummy] run tag @s remove ct_member
execute as @e[tag=ct_member,type=armor_stand,tag=!ct_dummy] run kill @s

## Remove any entity that is not a player or armor_stand but has ct_member
execute as @e[tag=ct_member,type=!player,type=!armor_stand] run scoreboard players add #cleanup_count ct.tick_counter 1
execute as @e[tag=ct_member,type=!player,type=!armor_stand] run tag @s remove ct_member
execute as @e[tag=ct_member,type=!player,type=!armor_stand] run kill @s

## Clean up duplicate ct_dummy armor stands (keep only the nearest one to the player)
## We don't remove valid dummies here, only residuals without ct_dummy

tellraw @a[tag=ct_op] {"text":"[CT Cleanup] ","color":"gold","extra":[{"text":"Residual entities removed: ","color":"white"},{"score":{"name":"#cleanup_count","objective":"ct.tick_counter"},"color":"yellow"}]}
