## ct:cluster/apply_resist — Macro: applies the speed resistance modifier.
## Parameters (from ct:math): res_val (double, already negated)
## Executed AS the player/member entity.

$attribute @s minecraft:movement_speed modifier add ct:resist $(res_val) add_multiplied_base
