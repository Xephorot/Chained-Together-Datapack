## ct:admin/create_cluster — Links all players within 8 blocks of the executor
## to cluster 0.
## Usage: /function ct:admin/create_cluster
## The executor must be a player (not a server entity).

## Unlink any previously linked nearby players
execute as @a[distance=..8, tag=ct_member] run function ct:util/unlink

## Also unlink the executor if they were already linked
execute if entity @s[tag=ct_member] run function ct:util/unlink

## Link the executor and players within 8 blocks
execute as @s run function ct:util/link
execute as @a[distance=..8, tag=!ct_member, limit=3] run function ct:util/link
## Include nearby test dummies
execute as @e[tag=ct_dummy, distance=..8] run tag @s add ct_member
execute as @e[tag=ct_dummy, distance=..8] run scoreboard players set @s ct.status 1
execute as @e[tag=ct_dummy, distance=..8] run scoreboard players set @s ct.cluster_id 0

## Count linked members
scoreboard players set #ct_count ct.tick_counter 0
execute as @e[tag=ct_member] run scoreboard players add #ct_count ct.tick_counter 1

## Initialize the cluster anchor at the executor's position
execute store result storage ct:main clusters[0].anchor.x double 1 run data get entity @s Pos[0]
execute store result storage ct:main clusters[0].anchor.y double 1 run data get entity @s Pos[1]
execute store result storage ct:main clusters[0].anchor.z double 1 run data get entity @s Pos[2]

## Feedback to executor
tellraw @s {"text":"[CT] ","color":"gold","extra":[{"text":"Cluster created. Members linked: ","color":"white"},{"score":{"name":"#ct_count","objective":"ct.tick_counter"},"color":"aqua"}]}
