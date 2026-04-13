## ct:view/particles — Emits chain particles from each member toward the centroid.
## Executed every 2 ticks (controlled by ct.tick_counter % 2 in tick.mcfunction).
## Uses interpolation: emits particles along the player→centroid segment.

function ct:view/particles_emit
