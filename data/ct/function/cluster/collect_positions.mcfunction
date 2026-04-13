## ct:cluster/collect_positions — Collects positions of all members
## into ct:math points[] for centroid calculation.

## Clear position list from previous tick
data modify storage ct:math points set value []

## Collect position of each linked member
execute as @e[tag=ct_member] run data modify storage ct:math points append from entity @s Pos

## Count members (result in ct:math member_count)
execute store result storage ct:math member_count int 1 if entity @e[tag=ct_member]
