## ct:cluster/mark_respawned — Handles player respawn and teleports cluster

## Remove dead tag
tag @s remove ct_dead

## Teleport entire cluster to respawned player
teleport @e[tag=ct_member] @s

## Apply safety effects
effect give @e[tag=ct_member] minecraft:slow_falling 3 0 true
effect give @e[tag=ct_member] minecraft:resistance 3 4 true

## Notify the group
tellraw @a[tag=ct_member] {"text":"⛓ The cluster has been brought together after a respawn.","color":"yellow"}
