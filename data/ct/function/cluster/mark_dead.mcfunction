## ct:cluster/mark_dead — Marks a player as dead

## Mark as dead
tag @s add ct_dead

## Notify
tellraw @a[tag=ct_member] {"text":"⛓ A cluster member has died!","color":"red"}
