## ct:cluster/calc_tension_nearest
## Calculates distance to the nearest other member.

execute unless entity @e[tag=ct_member,distance=0.5..] run scoreboard players set @s ct.tension 0
execute unless entity @e[tag=ct_member,distance=0.5..] run return 0

execute store result score #my_x ct.tick_counter run data get entity @s Pos[0] 1000
execute store result score #my_y ct.tick_counter run data get entity @s Pos[1] 1000
execute store result score #my_z ct.tick_counter run data get entity @s Pos[2] 1000

execute as @e[tag=ct_member,sort=nearest,limit=1,distance=0.5..] store result score #other_x ct.tick_counter run data get entity @s Pos[0] 1000
execute as @e[tag=ct_member,sort=nearest,limit=1,distance=0.5..] store result score #other_y ct.tick_counter run data get entity @s Pos[1] 1000
execute as @e[tag=ct_member,sort=nearest,limit=1,distance=0.5..] store result score #other_z ct.tick_counter run data get entity @s Pos[2] 1000

scoreboard players operation #dx ct.tick_counter = #my_x ct.tick_counter
scoreboard players operation #dx ct.tick_counter -= #other_x ct.tick_counter
scoreboard players operation #dy ct.tick_counter = #my_y ct.tick_counter
scoreboard players operation #dy ct.tick_counter -= #other_y ct.tick_counter
scoreboard players operation #dz ct.tick_counter = #my_z ct.tick_counter
scoreboard players operation #dz ct.tick_counter -= #other_z ct.tick_counter

execute if score #dx ct.tick_counter matches ..-1 run scoreboard players operation #dx ct.tick_counter *= #neg1 ct.tick_counter
execute if score #dy ct.tick_counter matches ..-1 run scoreboard players operation #dy ct.tick_counter *= #neg1 ct.tick_counter
execute if score #dz ct.tick_counter matches ..-1 run scoreboard players operation #dz ct.tick_counter *= #neg1 ct.tick_counter

scoreboard players operation @s ct.tension = #dx ct.tick_counter
execute if score #dy ct.tick_counter > @s ct.tension run scoreboard players operation @s ct.tension = #dy ct.tick_counter
execute if score #dz ct.tick_counter > @s ct.tension run scoreboard players operation @s ct.tension = #dz ct.tick_counter
