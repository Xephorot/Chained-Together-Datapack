## ct:admin/debug_tension — Minimal tension calculation test.
## Usage: /function ct:admin/debug_tension
## Runs the distance calculation manually and reports results.

## Read executor player position
execute store result score #px ct.tick_counter run data get entity @s Pos[0] 1000
execute store result score #py ct.tick_counter run data get entity @s Pos[1] 1000
execute store result score #pz ct.tick_counter run data get entity @s Pos[2] 1000

## Read centroid
execute store result score #cx ct.tick_counter run data get storage ct:math centroid.x 1000
execute store result score #cy ct.tick_counter run data get storage ct:math centroid.y 1000
execute store result score #cz ct.tick_counter run data get storage ct:math centroid.z 1000

## Delta
scoreboard players operation #dx ct.tick_counter = #px ct.tick_counter
scoreboard players operation #dx ct.tick_counter -= #cx ct.tick_counter
scoreboard players operation #dz ct.tick_counter = #pz ct.tick_counter
scoreboard players operation #dz ct.tick_counter -= #cz ct.tick_counter

## Abs dx
scoreboard players operation #adx ct.tick_counter = #dx ct.tick_counter
execute if score #adx ct.tick_counter matches ..-1 run scoreboard players operation #adx ct.tick_counter *= #neg1 ct.tick_counter
scoreboard players operation #adz ct.tick_counter = #dz ct.tick_counter
execute if score #adz ct.tick_counter matches ..-1 run scoreboard players operation #adz ct.tick_counter *= #neg1 ct.tick_counter

## Dist = max(adx, adz)
scoreboard players operation #dist ct.tick_counter = #adx ct.tick_counter
execute if score #adz ct.tick_counter > #dist ct.tick_counter run scoreboard players operation #dist ct.tick_counter = #adz ct.tick_counter

## Write to player's ct.tension
scoreboard players operation @s ct.tension = #dist ct.tick_counter

## Report
tellraw @s [{"text":"[DBG] px=","color":"gray"},{"score":{"name":"#px","objective":"ct.tick_counter"}},{"text":" cx=","color":"gray"},{"score":{"name":"#cx","objective":"ct.tick_counter"}},{"text":" dx=","color":"gray"},{"score":{"name":"#dx","objective":"ct.tick_counter"}},{"text":" dist=","color":"gold"},{"score":{"name":"#dist","objective":"ct.tick_counter"}},{"text":" tension=","color":"green"},{"score":{"name":"@s","objective":"ct.tension"}}]
