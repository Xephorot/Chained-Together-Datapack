## ct:util/link — Links the executor player to cluster 0
## Usage: execute as <player> run function ct:util/link

## Add member tag and set status, clean death state
tag @s add ct_member
scoreboard players set @s ct.status 1
scoreboard players set @s ct.cluster_id 0
scoreboard players set @s ct.tension 0
scoreboard players operation @s ct.last_deaths = @s ct.deaths

## Clear any residual modifier from previous sessions
execute if entity @s[type=player] run attribute @s minecraft:movement_speed modifier remove ct:resist

## Blue outline through walls: team + glowing
team join ct_chain @s
effect give @s minecraft:glowing 999999 0 true

## Notify player (only if real player, not armor stand)
execute if entity @s[type=player] run title @s actionbar {"text":"⛓ Linked to cluster","color":"gold"}
execute if entity @s[type=player] at @s run playsound minecraft:block.chain.place master @s ~ ~ ~ 1.0 1.0

## Add member to storage list (avoiding duplicates via check)
## The cluster/collect_positions function rebuilds the list every tick,
## so we only need to mark the status here.
