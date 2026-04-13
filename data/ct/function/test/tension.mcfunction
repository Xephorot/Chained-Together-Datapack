## ct:test/tension — Cycles the dummy between 3 test distances with each call.
## Usage: /function ct:test/tension  (call multiple times to cycle phases)
##
##   Phase 1 → dummy at  5 blocks  (partial resistance)
##   Phase 2 → dummy at 10 blocks  (max tension + pull)
##   Phase 3 → dummy at 20 blocks  (extreme tension → damage)

## Initialize phase if never used
execute unless score #test_phase ct.tick_counter matches 1.. run scoreboard players set #test_phase ct.tick_counter 1

## Dispatch to subfunction that handles the cycle correctly
function ct:test/tension_phase
