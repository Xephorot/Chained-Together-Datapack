## ct:cluster/handle_death — Called when a player has ct.deaths >= 1
## Executed AS the respawned player AT their spawn location.
## Because tick.mcfunction uses @e[type=player], this only fires AFTER they respawn.

## Teleport everyone to the respawned player
teleport @e[tag=ct_member] @s

## Prevent fall damage and apply safety effect
effect give @e[tag=ct_member] minecraft:slow_falling 3 0 true
effect give @e[tag=ct_member] minecraft:resistance 3 4 true

## Notify the group
tellraw @a[tag=ct_member] {"text":"⛓ The cluster has been brought together after a respawn.","color":"yellow"}

## Reset their death score
scoreboard players set @s ct.deaths 0
