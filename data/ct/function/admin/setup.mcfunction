## ct:admin/setup — Creates scoreboards, initializes storage and default config

## ── Scoreboards (idempotent: add ignores if already exists in 26.1.x) ─────────────
## Don't destroy existing objectives — preserves player scores across /reload
scoreboard objectives add ct.status dummy "CT Status"
scoreboard objectives add ct.cluster_id dummy "CT Cluster ID"
scoreboard objectives add ct.tension dummy "CT Tension"
scoreboard objectives add ct.deaths deathCount
scoreboard objectives add ct.time_since_death minecraft.custom:minecraft.time_since_death
scoreboard objectives add ct.respawn_timer dummy "CT Respawn Timer"
scoreboard objectives add ct.dimension dummy "CT Dimension"
scoreboard objectives add ct.last_dimension dummy "CT Last Dimension"
scoreboard objectives add ct.was_dead dummy "CT Was Dead"
scoreboard objectives add ct.last_deaths dummy "CT Last Deaths"
scoreboard objectives add ct.tick_counter dummy "CT Tick Counter"

## ── Storage: math workspace ─────────────────────────────────────────────────────
data modify storage ct:math points set value []
data modify storage ct:math centroid set value {x: 0.0d, y: 64.0d, z: 0.0d}
data modify storage ct:math member_count set value 0
data modify storage ct:math thresholds set value {full_i: 8000, half_i: 4000, resistance_i: -400, elastic_i: 1}
data modify storage ct:math res_val set value -0.4d
data modify storage ct:math pull set value {x: 0.0d, y: 0.0d, z: 0.0d}

## ── Storage: cluster configuration ────────────────────────────────────────
## max_dist    : max distance in blocks from centroid before tension triggers
## resistance  : speed modifier magnitude (0.0 to 1.0, negative)
## weight      : group inertia factor (resistance multiplier per member)
## elastic     : 1 = active pull; 0 = speed penalty only
data modify storage ct:main config set value {max_dist: 8.0d, resistance: 0.4d, weight: 1.0d, elastic: 1b}

## ── Storage: cluster data ─────────────────────────────────────────────────
## Initialize cluster 0 only if it doesn't exist yet (preserves data across reloads)
execute unless data storage ct:main clusters run data modify storage ct:main clusters set value [{id: 0, anchor: {x: 0.0d, y: 64.0d, z: 0.0d}, members: []}]

## ── Fake-player constants (shared by all functions) ────────────────────────
scoreboard players set #neg1 ct.tick_counter -1
scoreboard players set #two ct.tick_counter 2
scoreboard players set #global_tick ct.tick_counter 0
scoreboard players set #group_tension ct.tick_counter 0
scoreboard players set #full_thresh ct.tick_counter 8000
scoreboard players set #pull_mag ct.tick_counter 500
scoreboard players set #pct_scale ct.tick_counter 100

## ── Team for glowing effect (only create if not exists) ───────────────────────
team add ct_chain
team modify ct_chain color blue
team modify ct_chain seeFriendlyInvisibles true

## ── Confirmation ─────────────────────────────────────────────────────────────────
tellraw @a[tag=ct_op] {"text":"[CT] ","color":"gold","extra":[{"text":"System initialized successfully.","color":"white"}]}
