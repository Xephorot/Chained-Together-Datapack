## ct:cluster/handle_respawn — Called when a player just respawned
## Executed AS the respawned player AT their respawn coordinates

## Immediately notify the player that cluster is coming
tellraw @a[tag=ct_member] {"text":"⛓ Reassembling cluster... Please wait.","color":"gray","italic":true}

## Clear the respawn flags so it only runs once
scoreboard players operation @s ct.last_deaths = @s ct.deaths
scoreboard players set @s ct.time_since_death 20
scoreboard players set @s ct.was_dead 0

## Schedule the actual teleport in 40 ticks (2 seconds)
## We must use 'execute as @s' inside a scheduled function or store their ID, 
## but we can easily run it as all players who recently respawned in tick.mcfunction!

## Wait, we can just use a scoreboard timer instead of schedule for AS/AT context.
## Let's set a respawn_timer scoreboard to 40
scoreboard players set @s ct.respawn_timer 40
