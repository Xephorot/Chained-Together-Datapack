## ct:view/draw_line — Draws a particle line between two points.
## Required parameters:
## - The executor (AS and AT) must be the starting point.
## - Must be facing toward the destination point.
## - #line_dist in ct.tick_counter must contain the total distance in tenths of a block (e.g. 50 = 5 blocks).

## Base case: If distance is 0 or less, end recursion.
execute if score #line_dist ct.tick_counter matches ..0 run return 0

## Draw particle at current position (enchant is subtle and doesn't float)
particle minecraft:enchant ~ ~0.5 ~ 0.02 0.02 0.02 0 1 force

## Subtract 2 distance units (0.2 blocks)
scoreboard players remove #line_dist ct.tick_counter 2

## Recursively advance 0.2 blocks forward and continue
execute positioned ^ ^ ^0.2 run function ct:view/draw_line
