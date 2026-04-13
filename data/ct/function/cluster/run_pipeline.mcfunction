## ct:cluster/run_pipeline — Main pipeline executed with world context.
## Called from tick.mcfunction with "execute in minecraft:overworld positioned 0 0 0".
## This ensures all @e selectors work correctly.

## Guard: exit if no members (now with world context)
execute unless entity @e[tag=ct_member] run return 0

## 1. Apply forces (calculates tension to nearest member)
function ct:cluster/apply_forces

## 2. Check tension
function ct:cluster/check_tension

## 3. View (rate-limited every 2 ticks)
execute if score #global_tick ct.tick_counter matches 0 run function ct:view/particles
execute if score #global_tick ct.tick_counter matches 0 run function ct:view/sound

## 4. Increment global counter
scoreboard players add #global_tick ct.tick_counter 1
execute if score #global_tick ct.tick_counter matches 2.. run scoreboard players set #global_tick ct.tick_counter 0

## 5. Actionbar every tick
function ct:view/actionbar
