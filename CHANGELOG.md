# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0-beta] - 2026-04-13

### Added
- Core chain physics system using nearest-member Chebyshev distance
- Elastic pull mechanic — pulls players back toward their nearest linked member when exceeding max distance
- Speed resistance that scales smoothly with tension (50%–100% of max distance)
- Enchant particle chain visualization between linked members (subtle purple line)
- Real-time tension HUD in the actionbar showing percentage and distance in blocks
- Color-coded HUD: green (safe) → yellow (warning) → red (danger) → dark red (critical)
- Tension damage system: hunger at moderate tension, direct damage at critical levels
- Blue glowing outline through walls for all linked members (team-based)
- Single-player test environment using an armor stand dummy with chunk forceload
- Admin commands: `setup`, `create_cluster`, `cleanup`, `set_physics`
- Configurable parameters via storage: `max_dist`, `resistance`, `weight`, `elastic`
- Anti-sinking system: Y-position is preserved during elastic pull to prevent entities from clipping into terrain
- Cleanup command to remove residual entities from previous test sessions
- **Automatic cluster teleport on respawn** — When a player dies and respawns, the entire cluster is teleported to their new spawn location after a 2-second delay
- **Automatic cluster teleport on dimension change** — When any player traverses a Nether/End portal, all linked members are teleported with them (cross-dimensional teleport)
- Death detection system using `time_since_death` scoreboard
- Dimension detection system using `ct.dimension` and `ct.last_dimension` scoreboards
- 2-second delay timer for teleport to ensure chunks/dimensions are fully loaded
- Safety effects (slow falling + resistance) on teleport to prevent fall damage

### Known Issues
- Particles may briefly connect to residual entities if `test/setup` is run multiple times without `test/teardown` first — use `/function ct:admin/cleanup` to fix
- Pull direction uses `facing feet` which works best on relatively flat terrain; steep slopes may cause minor visual artifacts
- Tension calculation uses Chebyshev distance (max of |dx|, |dy|, |dz|) rather than Euclidean distance, so diagonal distances may feel slightly different
- When players are at different elevations and one moves away, the distant player may be pulled upward until both players are closer together
