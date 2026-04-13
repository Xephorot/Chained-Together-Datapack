## ct:test/setup — Creates a test environment without needing a second real player.
## Usage: /function ct:test/setup
##
## What it does:
##   1. Links the executor as a real ct_member.
##   2. Spawns an Armor Stand "dummy player" with ct_member tag 3 blocks away.
##
## To move the dummy: /data modify entity @e[tag=ct_dummy,limit=1] Pos set value [X,Y,Z]
## To clean up:       /function ct:test/teardown

## ── Clean up previous test ────────────────────────────────────────────────────
function ct:test/teardown

## ── Link the executor ───────────────────────────────────────────────
execute as @s run function ct:util/link
## Force scores directly as fallback (ensures they exist)
tag @s add ct_member
scoreboard players set @s ct.status 1
scoreboard players set @s ct.cluster_id 0
scoreboard players set @s ct.tension 0
team join ct_chain @s
effect give @s minecraft:glowing 999999 0 true

## ── Create dummy 3 blocks away (within normal range) ────────────────────────
summon minecraft:armor_stand ~3 ~ ~0 {Tags:["ct_member","ct_dummy"],CustomName:'"[CT] Dummy A"',CustomNameVisible:1b,NoGravity:0b,Invisible:0b,Small:0b,Glowing:1b}
team join ct_chain @e[tag=ct_dummy,limit=1]

## Assign scoreboards to the dummy
scoreboard players set @e[tag=ct_dummy,limit=1] ct.status 1
scoreboard players set @e[tag=ct_dummy,limit=1] ct.cluster_id 0
scoreboard players set @e[tag=ct_dummy,limit=1] ct.tension 0

## Force-load the chunk the dummy is in so it never unloads during teleport tests!
execute at @e[tag=ct_dummy,limit=1] run forceload add ~ ~ ~ ~

## ── Feedback ──────────────────────────────────────────────────────────
tellraw @s {"text":"[CT Test] ","color":"aqua","extra":[{"text":"Dummy A created 3 blocks away. Chunk force-loaded.\n","color":"white"},{"text":"Test tension: ","color":"gray"},{"text":"/function ct:test/tension","color":"yellow"},{"text":"\nClean up: ","color":"gray"},{"text":"/function ct:test/teardown","color":"yellow"}]}
