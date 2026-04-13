## ct:view/actionbar — Shows "Group Tension" in the actionbar of all members.
## Executed every tick.
## Uses #group_tension (×1000) calculated in check_tension.

## Calculate tension percentage: (#group_tension / full_thresh) * 100
## Using integer scale: tension_pct = group_tension * 100 / full_thresh
scoreboard players operation #tension_pct ct.tick_counter = #group_tension ct.tick_counter
scoreboard players set #pct_scale ct.tick_counter 100
scoreboard players operation #tension_pct ct.tick_counter *= #pct_scale ct.tick_counter
execute if score #full_thresh ct.tick_counter matches 1.. run scoreboard players operation #tension_pct ct.tick_counter /= #full_thresh ct.tick_counter

## Calculate distance in blocks (tension / 1000)
scoreboard players operation #dist_blocks ct.tick_counter = #group_tension ct.tick_counter
scoreboard players set #divisor ct.tick_counter 1000
scoreboard players operation #dist_blocks ct.tick_counter /= #divisor ct.tick_counter

## Show based on tension level
execute if score #tension_pct ct.tick_counter matches ..50 run title @a[tag=ct_member] actionbar {"text":"⛓ Tension: ","color":"green","extra":[{"score":{"name":"#tension_pct","objective":"ct.tick_counter"}},{"text":"% (","color":"gray"},{"score":{"name":"#dist_blocks","objective":"ct.tick_counter"}},{"text":"m)","color":"gray"}]}
execute if score #tension_pct ct.tick_counter matches 51..85 run title @a[tag=ct_member] actionbar {"text":"⛓ Tension: ","color":"yellow","extra":[{"score":{"name":"#tension_pct","objective":"ct.tick_counter"}},{"text":"% (","color":"gray"},{"score":{"name":"#dist_blocks","objective":"ct.tick_counter"}},{"text":"m)","color":"gray"}]}
execute if score #tension_pct ct.tick_counter matches 86..99 run title @a[tag=ct_member] actionbar {"text":"⛓ Tension: ","color":"red","extra":[{"score":{"name":"#tension_pct","objective":"ct.tick_counter"}},{"text":"% (","color":"gray"},{"score":{"name":"#dist_blocks","objective":"ct.tick_counter"}},{"text":"m)","color":"gray"}]}
execute if score #tension_pct ct.tick_counter matches 100.. run title @a[tag=ct_member] actionbar {"text":"⛓ CRITICAL!","color":"dark_red","bold":true,"extra":[{"text":" ","bold":false},{"score":{"name":"#dist_blocks","objective":"ct.tick_counter"},"color":"white","bold":false},{"text":"m","color":"white","bold":false}]}
