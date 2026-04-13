## ct:cluster/detect_portal — Detects if a player changed dimension
## Executed AS each living member player

## 1) Figure out current dimension and save it to ct.dimension
execute at @s if dimension minecraft:overworld run scoreboard players set @s ct.dimension 1
execute at @s if dimension minecraft:the_nether run scoreboard players set @s ct.dimension 2
execute at @s if dimension minecraft:the_end run scoreboard players set @s ct.dimension 3

## 2) If last_dimension is 0 (newly linked player), just set it to current and abort
execute if score @s ct.last_dimension matches 0 run scoreboard players operation @s ct.last_dimension = @s ct.dimension

## 3) Check if dimension changed! (current != last)
scoreboard players operation #diff ct.tick_counter = @s ct.dimension
scoreboard players operation #diff ct.tick_counter -= @s ct.last_dimension

## If difference is not 0, player just went through a portal!
execute unless score #diff ct.tick_counter matches 0 run function ct:cluster/handle_portal

## 4) Update last_dimension for next tick
scoreboard players operation @s ct.last_dimension = @s ct.dimension
