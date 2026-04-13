## ct:cluster/handle_portal — Called when a player traverses a dimension portal
## Executed AS the player who just entered the new dimension

## Update dimension tracker so it only fires once
scoreboard players operation @s ct.last_dimension = @s ct.dimension

## Temporarily pause physics by setting a timer (same as respawn)
scoreboard players set @s ct.respawn_timer 40

## Tell everyone
tellraw @a[tag=ct_member] {"text":"⛓ A member traversed a portal! Warping cluster...","color":"light_purple"}

## Note: The timer will naturally trigger `execute_respawn_teleport` 
## which will gracefully pull everyone to this player's new exact dimension and location.
