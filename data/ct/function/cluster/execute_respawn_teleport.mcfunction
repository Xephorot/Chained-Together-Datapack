## ct:cluster/execute_respawn_teleport — Called 2 seconds after respawn (ct.respawn_timer = 1)
## Executed AS the respawned player, AT their new respawn coordinates

## Teleport all cluster members to THIS player's exact location, without needing @p
execute at @s run teleport @e[tag=ct_member] ~ ~ ~

## Update the cluster anchor to the new respawn position
execute store result storage ct:main clusters[{id: 0}].anchor.x double 1.0 run data get entity @s Pos[0]
execute store result storage ct:main clusters[{id: 0}].anchor.y double 1.0 run data get entity @s Pos[1]
execute store result storage ct:main clusters[{id: 0}].anchor.z double 1.0 run data get entity @s Pos[2]

## Apply safety effects to all members
effect give @e[tag=ct_member] minecraft:slow_falling 3 0 true
effect give @e[tag=ct_member] minecraft:resistance 3 4 true

## Notify the group
tellraw @a[tag=ct_member] {"text":"⛓ The cluster has been brought together!","color":"yellow"}

## Reset timer
scoreboard players set @s ct.respawn_timer 0
