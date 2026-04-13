## ct:test/tension_phase — Internal subfunction: executes the current phase and advances the counter.
## Called ONLY from ct:test/tension via execute if score.
## The phase parameter is read from the scoreboard at call time.

## Phase 1: 5 blocks — advance to 2 BEFORE the following phase lines
## Trick: save if we're in phase 1 to an aux variable, execute, advance, exit
scoreboard players set #was_phase1 ct.tick_counter 0
execute if score #test_phase ct.tick_counter matches 1 run scoreboard players set #was_phase1 ct.tick_counter 1
execute if score #was_phase1 ct.tick_counter matches 1 at @s run function ct:test/place_dummy {offset: 5.0}
execute if score #was_phase1 ct.tick_counter matches 1 run tellraw @s [{"text":"[CT Test] ","color":"aqua"},{"text":"Phase 1","color":"yellow","bold":true},{"text":" — Dummy at 5 blocks. Partial resistance active.","color":"white"}]
execute if score #was_phase1 ct.tick_counter matches 1 run scoreboard players set #test_phase ct.tick_counter 2
execute if score #was_phase1 ct.tick_counter matches 1 run return 0

## Phase 2: 10 blocks
scoreboard players set #was_phase2 ct.tick_counter 0
execute if score #test_phase ct.tick_counter matches 2 run scoreboard players set #was_phase2 ct.tick_counter 1
execute if score #was_phase2 ct.tick_counter matches 1 at @s run function ct:test/place_dummy {offset: 10.0}
execute if score #was_phase2 ct.tick_counter matches 1 run tellraw @s [{"text":"[CT Test] ","color":"aqua"},{"text":"Phase 2","color":"gold","bold":true},{"text":" — Dummy at 10 blocks. Max resistance + elastic pull.","color":"white"}]
execute if score #was_phase2 ct.tick_counter matches 1 run scoreboard players set #test_phase ct.tick_counter 3
execute if score #was_phase2 ct.tick_counter matches 1 run return 0

## Phase 3: 20 blocks
execute if score #test_phase ct.tick_counter matches 3 at @s run function ct:test/place_dummy {offset: 20.0}
execute if score #test_phase ct.tick_counter matches 3 run tellraw @s [{"text":"[CT Test] ","color":"aqua"},{"text":"Phase 3","color":"red","bold":true},{"text":" — Dummy at 20 blocks. Extreme tension damage to the group.","color":"white"}]
execute if score #test_phase ct.tick_counter matches 3 run scoreboard players set #test_phase ct.tick_counter 1
