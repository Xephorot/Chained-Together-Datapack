## ct:view/particles_emit — Emits the visual chain between members.
## Executed every 2 ticks.
## Connects members by drawing a line to the central anchor using draw_line.

## Draw line only from players (not from dummies to avoid duplication)
execute as @a[tag=ct_member] at @s run function ct:view/draw_member_line

## Critical tension: red particles above members
execute as @e[tag=ct_member] at @s if score @s ct.tension matches 6000.. run particle minecraft:flame ~ ~1 ~ 0.2 0.2 0.2 0.05 3 force
