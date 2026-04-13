## ct:admin/trace_tension — Full trace of tension calculation in real time.
## Manually runs apply_forces with logging.

## Read centroid
execute store result score #cx ct.tick_counter run data get storage ct:math centroid.x 1000
execute store result score #cz ct.tick_counter run data get storage ct:math centroid.z 1000

tellraw @a [{"text":"[TRACE] Centroid: cx=","color":"yellow"},{"score":{"name":"#cx","objective":"ct.tick_counter"}},{"text":" cz="},{"score":{"name":"#cz","objective":"ct.tick_counter"}}]

## Step 1: store px in cluster_id
execute as @e[tag=ct_member] store result score @s ct.cluster_id run data get entity @s Pos[0] 1000
execute as @e[tag=ct_member] run tellraw @a [{"text":"[TRACE] ","color":"gray"},{"selector":"@s"},{"text":" px="},{"score":{"name":"@s","objective":"ct.cluster_id"}}]

## Step 2: store pz in tension
execute as @e[tag=ct_member] store result score @s ct.tension run data get entity @s Pos[2] 1000
execute as @e[tag=ct_member] run tellraw @a [{"text":"[TRACE] ","color":"gray"},{"selector":"@s"},{"text":" pz="},{"score":{"name":"@s","objective":"ct.tension"}}]

## Step 3: dx = px - cx
execute as @e[tag=ct_member] run scoreboard players operation @s ct.cluster_id -= #cx ct.tick_counter
execute as @e[tag=ct_member] run tellraw @a [{"text":"[TRACE] ","color":"gray"},{"selector":"@s"},{"text":" dx="},{"score":{"name":"@s","objective":"ct.cluster_id"}}]

## Step 4: |dx|
execute as @e[tag=ct_member] if score @s ct.cluster_id matches ..-1 run scoreboard players operation @s ct.cluster_id *= #neg1 ct.tick_counter
execute as @e[tag=ct_member] run tellraw @a [{"text":"[TRACE] ","color":"gray"},{"selector":"@s"},{"text":" |dx|="},{"score":{"name":"@s","objective":"ct.cluster_id"}}]

## Step 5: dz = pz - cz
execute as @e[tag=ct_member] run scoreboard players operation @s ct.tension -= #cz ct.tick_counter
execute as @e[tag=ct_member] run tellraw @a [{"text":"[TRACE] ","color":"gray"},{"selector":"@s"},{"text":" dz="},{"score":{"name":"@s","objective":"ct.tension"}}]

## Step 6: |dz|
execute as @e[tag=ct_member] if score @s ct.tension matches ..-1 run scoreboard players operation @s ct.tension *= #neg1 ct.tick_counter
execute as @e[tag=ct_member] run tellraw @a [{"text":"[TRACE] ","color":"gray"},{"selector":"@s"},{"text":" |dz|="},{"score":{"name":"@s","objective":"ct.tension"}}]

## Step 7: max
execute as @e[tag=ct_member] if score @s ct.cluster_id > @s ct.tension run scoreboard players operation @s ct.tension = @s ct.cluster_id
execute as @e[tag=ct_member] run tellraw @a [{"text":"[TRACE FINAL] ","color":"gold"},{"selector":"@s"},{"text":" tension="},{"score":{"name":"@s","objective":"ct.tension"}}]

## Restore cluster_id
execute as @e[tag=ct_member] run scoreboard players set @s ct.cluster_id 0
