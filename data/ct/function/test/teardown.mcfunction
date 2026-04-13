## ct:test/teardown — Cleans up the test environment

## 1) Unload the test dummy's chunk if it had one
execute at @e[tag=ct_dummy] run forceload remove ~ ~ ~ ~

## 2) Kill all entities tagged as dummy
kill @e[tag=ct_dummy]

## Unlink and remove all dummies
execute as @e[tag=ct_dummy] run scoreboard players reset @s ct.status
execute as @e[tag=ct_dummy] run scoreboard players reset @s ct.tension
kill @e[tag=ct_dummy]

## Remove residual entities (phantom armor stands with ct_member)
function ct:admin/cleanup

## Unlink the executor player if they were linked from the test
execute as @s[tag=ct_member] run function ct:util/unlink

## Reset test phase
scoreboard players set #test_phase ct.tick_counter 0

tellraw @s {"text":"[CT Test] ","color":"aqua","extra":[{"text":"Test environment cleaned up.","color":"gray"}]}
