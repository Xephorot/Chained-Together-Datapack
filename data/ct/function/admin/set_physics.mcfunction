## ct:admin/set_physics — Macro to adjust cluster physics parameters
## Usage: function ct:admin/set_physics {weight: 1.5, elastic: 1}
## Available parameters:
##   weight   (double)  : group inertia factor. Default: 1.0
##   elastic  (byte)    : 1 = active pull; 0 = speed penalty only. Default: 1
##   max_dist (double)  : max distance in blocks. Default: 8.0
##   resistance (double): speed penalty magnitude (0.0–1.0). Default: 0.4

$data modify storage ct:main config.weight set value $(weight)
$data modify storage ct:main config.elastic set value $(elastic)

## Feedback
tellraw @a[tag=ct_op] {"text":"[CT] ","color":"gold","extra":[{"text":"Physics updated. weight=$(weight) elastic=$(elastic)","color":"white"}]}
