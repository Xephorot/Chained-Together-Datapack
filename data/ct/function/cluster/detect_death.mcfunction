## ct:cluster/detect_death — Detects when CT members die and respawn
## Executed AS each member player (only when they are alive/respawned)

## We use time_since_death to detect the EXACT moment after clicking "Respawn".
## When a player dies, time_since_death becomes 0.
## When they click respawn, it starts counting up from 1.

## If player JUST respawned (time_since_death is EXACTLY 1)
## We call the setup function right away, which will schedule the actual TP
execute if score @s ct.time_since_death matches 1 at @s run function ct:cluster/handle_respawn
