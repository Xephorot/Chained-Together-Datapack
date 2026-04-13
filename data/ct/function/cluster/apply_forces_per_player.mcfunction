## ct:cluster/apply_forces_per_player — Applies eval_player_force to each member.
## No macros: eval_player_force reads thresholds from global scoreboards.

execute positioned 0 0 0 as @e[tag=ct_member] run function ct:cluster/eval_player_force
