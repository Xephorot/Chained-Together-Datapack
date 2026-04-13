## ct:tick — Main dispatcher. Executed every tick by minecraft:tick.
## Guard: only acts if there is at least one linked member in the world.

## ── Re-entry: restore tag for reconnected players ────────────────────────────
execute as @a[tag=!ct_member, scores={ct.status=1}] run function ct:cluster/rejoin

## ── Death detection: handle players who just respawned ────────────────────────
## Run death detection for all living members
execute as @a[tag=ct_member] run function ct:cluster/detect_death

## Run portal detection for all living members
execute as @a[tag=ct_member] run function ct:cluster/detect_portal

## Handle respawn timer logic for those who recently respawned
execute as @a[tag=ct_member,scores={ct.respawn_timer=2..}] run scoreboard players remove @s ct.respawn_timer 1
execute as @a[tag=ct_member,scores={ct.respawn_timer=1}] at @s run function ct:cluster/execute_respawn_teleport

## ── Main pipeline (ALWAYS with world context) ───────────────────────
## Pause physics if anyone is dead. We use time_since_death to pause while on death screen
## time_since_death doesn't exist (score null) or is 0 when dead
scoreboard players set #anyone_dead ct.tick_counter 0

## Check for players missing time_since_death or with time_since_death = 0
execute as @a[tag=ct_member] unless score @s ct.time_since_death matches 1.. run scoreboard players set #anyone_dead ct.tick_counter 1

## Guard and pipeline run within the overworld context
execute if score #anyone_dead ct.tick_counter matches 0 in minecraft:overworld positioned 0 0 0 run function ct:cluster/run_pipeline
