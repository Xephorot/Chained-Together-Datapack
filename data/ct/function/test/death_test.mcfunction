## ct:test/death_test — Test death handling functionality
## Usage: /function ct:test/death_test

## This test simulates a death by manually setting time_since_death to 0
tellraw @a[tag=ct_op] {"text":"[CT TEST] Simulating death (setting time_since_death to 0)...","color":"yellow"}
scoreboard players set @a[tag=ct_member,limit=1] ct.time_since_death 0
tellraw @a[tag=ct_op] {"text":"[CT TEST] Death simulated. Physics should be paused.","color":"yellow"}
tellraw @a[tag=ct_op] {"text":"[CT TEST] Now run: /function ct:test/death_test_respawn","color":"gray"}
