## ct:test/death_test_respawn — Test respawn functionality
## Usage: /function ct:test/death_test_respawn

## This test simulates a respawn by incrementing deaths
tellraw @a[tag=ct_op] {"text":"[CT TEST] Simulating respawn (incrementing deaths)...","color":"yellow"}
scoreboard players add @a[tag=ct_member,limit=1] ct.deaths 1
execute as @a[tag=ct_member,limit=1] run function ct:cluster/detect_death

tellraw @a[tag=ct_op] {"text":"[CT TEST] Respawn simulated. Cluster should have teleported to them.","color":"green"}
tellraw @a[tag=ct_op] {"text":"[CT TEST] Physics should resume normally.","color":"green"}
