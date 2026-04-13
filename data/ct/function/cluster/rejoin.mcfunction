## ct:cluster/rejoin — Re-integrates a recently connected player into the cluster.
## Executed AS the player with ct.status=1 but without the ct_member tag yet
## (detected in tick.mcfunction as players with ct.status=1 score but no tag).

## Restore member tag and clean death state
tag @s add ct_member

## TP to cluster anchor (centroid position saved in storage)
function ct:cluster/tp_to_anchor

## Re-activate scoreboard
scoreboard players set @s ct.tension 0
scoreboard players operation @s ct.last_deaths = @s ct.deaths

## Notify
title @s actionbar {"text":"⛓ Re-linked to cluster","color":"yellow"}
playsound minecraft:block.chain.place master @s ~ ~ ~ 1.0 1.2
