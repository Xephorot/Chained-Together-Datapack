## ct:view/draw_member_line — Sets up the particle line for a member and draws it.
## Executed AS @e and AT @s (the starting position).
## Reads tension (distance to nearest member) and faces toward them to draw the line.

## If no other member is more than 0.5 blocks away, don't draw a line
execute unless entity @e[tag=ct_member,distance=0.5..] run return 0

## Set drawing distance (tension = distance x1000)
scoreboard players operation #line_dist ct.tick_counter = @s ct.tension
scoreboard players set #divisor ct.tick_counter 100
scoreboard players operation #line_dist ct.tick_counter /= #divisor ct.tick_counter

## Limit: maximum 25 blocks
execute if score #line_dist ct.tick_counter matches 250.. run scoreboard players set #line_dist ct.tick_counter 250

## Draw line toward the OTHER nearest member (excluding self with distance=0.5..)
execute facing entity @e[tag=ct_member,sort=nearest,limit=1,distance=0.5..] feet run function ct:view/draw_line
