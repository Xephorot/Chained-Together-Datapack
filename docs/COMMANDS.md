# Commands Reference — Chained Together

> Complete list of all available commands for administrators and players.

---

## 🚀 Quick Start Commands

### Multiplayer — Link players together
```
/function ct:admin/create_cluster
```
All nearby players (within 8 blocks) are automatically linked.

### Unlink a specific player
```
/execute as <player> run function ct:util/unlink
```

### Unlink everyone
```
/execute as @a[tag=ct_member] run function ct:util/unlink
```

---

## ⚙️ Admin Commands

| Command | Description |
|---|---|
| `/function ct:admin/setup` | Re-initializes scoreboards and storage (useful after errors) |
| `/function ct:admin/create_cluster` | Creates a cluster linking players within 8 blocks |
| `/function ct:admin/cleanup` | Removes residual entities with `ct_member` tag |
| `/function ct:admin/set_physics {weight: 1.5, elastic: 1}` | Adjust cluster physics parameters |

---

## 🧪 Test Commands

| Command | Description |
|---|---|
| `/function ct:test/setup` | Create test environment with dummy armor stand |
| `/function ct:test/teardown` | Clean up test environment |
| `/function ct:test/tension` | Cycle dummy through test distances |

---

## ⚙️ Configuration

Modify settings directly via data storage:

```
/data modify storage ct:main config.max_dist set value 12.0d
/data modify storage ct:main config.resistance set value 0.6d
```

| Key | Type | Default | Description |
|---|---|---|---|
| `max_dist` | double | `8.0d` | Maximum distance before full tension triggers |
| `resistance` | double | `0.4d` | Speed penalty magnitude (0.0–1.0) |
| `weight` | double | `1.0d` | Group inertia factor |
| `elastic` | byte | `1b` | `1` = active pull; `0` = speed penalty only |

### Respawn & Dimension Timers

| Scoreboard | Purpose |
|---|---|
| `ct.time_since_death` | Tracks time since last death (0 = death screen, 1 = respawned) |
| `ct.respawn_timer` | Delay before teleport executes |
| `ct.dimension` | Current dimension ID (1=Overworld, 2=Nether, 3=End) |
| `ct.last_dimension` | Previous tick's dimension |

---

## 🔧 Utility Functions

These are used internally but can be called manually:

| Function | Purpose |
|---|---|
| `ct:util/link` | Link executing entity to cluster |
| `ct:util/unlink` | Unlink executing entity |
| `ct:cluster/rejoin` | Re-integrate a reconnected player |

---

## 📊 Scoreboards Reference

### Player Scoreboards
- `ct.status` — Linked status (1 = active member)
- `ct.cluster_id` — Cluster ID (default: 0)
- `ct.tension` — Current tension value (×1000)
- `ct.deaths` — Death counter (auto-updated by Minecraft)
- `ct.time_since_death` — Time since last death
- `ct.respawn_timer` — Active timer for delayed teleport
- `ct.dimension` — Current dimension ID
- `ct.last_dimension` — Previous dimension ID

### System Scoreboards
- `ct.tick_counter` — Internal tick counter and constants
- `ct.was_dead` — Death state flag
- `ct.last_deaths` — Previous death count
