## ct:view/sound — Plays metallic sounds proportional to group tension.
## Executed every 2 ticks.
## #group_tension (×1000 blocks) calculated in check_tension.

## No notable tension (< 2 blocks): silence
execute if score #group_tension ct.tick_counter matches ..2000 run return 0

## Low tension (2–4 blocks): soft sound, low pitch
execute if score #group_tension ct.tick_counter matches 2001..4000 at @a[tag=ct_member, limit=1] run playsound minecraft:block.chain.step master @a[tag=ct_member] ~ ~ ~ 0.4 0.6

## Medium tension (4–8 blocks): louder sound, medium pitch
execute if score #group_tension ct.tick_counter matches 4001..8000 at @a[tag=ct_member, limit=1] run playsound minecraft:block.chain.step master @a[tag=ct_member] ~ ~ ~ 0.7 0.9

## High tension (> 8 blocks / max_dist): loud sound, high pitch
execute if score #group_tension ct.tick_counter matches 8001.. at @a[tag=ct_member, limit=1] run playsound minecraft:block.chain.step master @a[tag=ct_member] ~ ~ ~ 1.0 1.4
