## ct:util/unlink — Unlinks the executor player from the cluster
## Usage: execute as <player> run function ct:util/unlink

## Clear speed modifier before removing the tag
execute if entity @s[type=player] run attribute @s minecraft:movement_speed modifier remove ct:resist

## Clear residual tension effects and glowing
effect clear @s hunger
effect clear @s slowness
effect clear @s glowing
team leave @s

## Remove tags and reset scoreboards
tag @s remove ct_member
scoreboard players set @s ct.status 0
scoreboard players set @s ct.cluster_id -1
scoreboard players set @s ct.tension 0

## Notify (real players only)
execute if entity @s[type=player] run title @s actionbar {"text":"⛓ Unlinked from cluster","color":"gray"}
execute if entity @s[type=player] at @s run playsound minecraft:block.chain.break master @s ~ ~ ~ 1.0 0.8
