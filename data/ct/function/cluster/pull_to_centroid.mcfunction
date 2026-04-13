## ct:cluster/pull_to_centroid
## Pulls the player toward the nearest member when too far away.

execute if score @s ct.tension < #full_thresh ct.tick_counter run return 0
execute unless entity @e[tag=ct_member,sort=nearest,limit=1,distance=0.01..] run return 0

scoreboard players operation #excess ct.tick_counter = @s ct.tension
scoreboard players operation #excess ct.tick_counter -= #full_thresh ct.tick_counter

scoreboard players set #divisor ct.tick_counter 1000
scoreboard players operation #pull_force ct.tick_counter = #excess ct.tick_counter
scoreboard players operation #pull_force ct.tick_counter /= #divisor ct.tick_counter

execute if score #pull_force ct.tick_counter > #max_pull ct.tick_counter run scoreboard players operation #pull_force ct.tick_counter = #max_pull ct.tick_counter

## Save Y before tp to prevent sinking entities
execute store result score #pre_y ct.tick_counter run data get entity @s Pos[1] 1000

## Push toward the nearest member (facing feet = 3D direction)
execute store result score #step ct.tick_counter if score #pull_force ct.tick_counter matches 1..2 run scoreboard players set #step ct.tick_counter 80
execute store result score #step ct.tick_counter if score #pull_force ct.tick_counter matches 3..5 run scoreboard players set #step ct.tick_counter 150
execute store result score #step ct.tick_counter if score #pull_force ct.tick_counter matches 6..9 run scoreboard players set #step ct.tick_counter 250
execute store result score #step ct.tick_counter if score #pull_force ct.tick_counter matches 10..14 run scoreboard players set #step ct.tick_counter 350
execute store result score #step ct.tick_counter if score #pull_force ct.tick_counter matches 15.. run scoreboard players set #step ct.tick_counter 500

## Save original position to verify if pulled
scoreboard players set #pulled ct.tick_counter 0

## Horizontal pull only (rotated ~ 0) to avoid vertical camera jitter
execute if score #step ct.tick_counter matches 80 facing entity @e[tag=ct_member,sort=nearest,limit=1,distance=0.5..] feet rotated ~ 0 positioned ^ ^ ^0.08 if block ~ ~ ~ #ct:passable if block ~ ~1 ~ #ct:passable run teleport @s ~ ~ ~
execute if score #step ct.tick_counter matches 150 facing entity @e[tag=ct_member,sort=nearest,limit=1,distance=0.5..] feet rotated ~ 0 positioned ^ ^ ^0.15 if block ~ ~ ~ #ct:passable if block ~ ~1 ~ #ct:passable run teleport @s ~ ~ ~
execute if score #step ct.tick_counter matches 250 facing entity @e[tag=ct_member,sort=nearest,limit=1,distance=0.5..] feet rotated ~ 0 positioned ^ ^ ^0.25 if block ~ ~ ~ #ct:passable if block ~ ~1 ~ #ct:passable run teleport @s ~ ~ ~
execute if score #step ct.tick_counter matches 350 facing entity @e[tag=ct_member,sort=nearest,limit=1,distance=0.5..] feet rotated ~ 0 positioned ^ ^ ^0.35 if block ~ ~ ~ #ct:passable if block ~ ~1 ~ #ct:passable run teleport @s ~ ~ ~
execute if score #step ct.tick_counter matches 500 facing entity @e[tag=ct_member,sort=nearest,limit=1,distance=0.5..] feet rotated ~ 0 positioned ^ ^ ^0.50 if block ~ ~ ~ #ct:passable if block ~ ~1 ~ #ct:passable run teleport @s ~ ~ ~

## Smooth Vertical Pull (Levitation) to simulate hanging / pulling up
## Get partner Y
execute store result score #partner_y ct.tick_counter as @e[tag=ct_member,sort=nearest,limit=1,distance=0.5..] run data get entity @s Pos[1] 1000
scoreboard players operation #diff_y ct.tick_counter = #partner_y ct.tick_counter
scoreboard players operation #diff_y ct.tick_counter -= #pre_y ct.tick_counter

## Apply levitation based on how far down we are
execute if score #diff_y ct.tick_counter matches 1000..1999 run effect give @s minecraft:levitation 1 0 true
execute if score #diff_y ct.tick_counter matches 2000..3999 run effect give @s minecraft:levitation 1 2 true
execute if score #diff_y ct.tick_counter matches 4000.. run effect give @s minecraft:levitation 1 5 true

## Clear levitation if we are at the same level or above
execute if score #diff_y ct.tick_counter matches ..999 run effect clear @s minecraft:levitation
