# Testing Guide — Chained Together

> Complete guide for testing all datapack features in single-player and multiplayer modes.

---

## 🧪 Test Environment (Single Player)

Test all chain mechanics without a second player using an armor stand dummy.

> **⚠️ IMPORTANT:** `test/setup` automatically links the executor — do **NOT** also run `create_cluster` when using the test environment.

### Full test flow

**Step 1 — Load the datapack** *(only needed after code changes)*
```
/reload
```

**Step 2 — Prepare the world** *(recommended)*
```
/gamemode creative
/gamerule keepInventory true
```

**Step 3 — Start the test environment**
```
/function ct:test/setup
```
This will:
- Link you as a `ct_member` (with blue outline)
- Spawn dummy `[CT] Dummy A` at 3 blocks away
- Force-load the dummy's chunk (so it persists across dimensions)
- Start the physics pipeline automatically

You should see:
- Chain particles between you and the dummy
- Actionbar showing `⛓ Tension: X% (Ym)`
- Blue glowing outline on both (visible through walls)

**Testing respawn teleport:**
- Die with `/kill` or fall damage
- Click "Respawn"
- After 2 seconds, the dummy will appear at your spawn location

**Testing dimension teleport:**
- Build a Nether portal nearby
- Enter the portal
- After 2 seconds in the Nether, the dummy will appear with you
- Exit the portal — the dummy follows you back to the Overworld

**Step 4 — Cycle through test distances** *(call multiple times)*
```
/function ct:test/tension
```

| Call | Dummy moves to | What to verify |
|---|---|---|
| 1st | 5 blocks | Yellow actionbar, slightly reduced speed |
| 2nd | 10 blocks | Red actionbar, active elastic pull (micro-TP toward dummy) |
| 3rd | 20 blocks | `CRITICAL TENSION!` in dark red, damage received |
| 4th | Back to 5 blocks | Cycle restarted |

**Step 5 — Move the dummy manually** *(optional)*
```
/data modify entity @e[tag=ct_dummy,limit=1] Pos set value [X, Y, Z]
```

**Step 6 — Clean up**
```
/function ct:test/teardown
```
Removes the dummy, unlinks the player, removes chunk forceload, and resets all state.

---

## 🔬 Diagnostic Commands

| Command | Purpose |
|---|---|
| `/scoreboard players list @s` | View your scoreboard state |
| `/scoreboard objectives list` | List all datapack scoreboards |
| `/data get storage ct:main config` | View current cluster configuration |
| `/data get storage ct:main clusters[0].anchor` | View cluster anchor position |
| `/scoreboard players get @s ct.tension` | View your current tension value |
| `/tag @e[distance=..10] list` | Check tags on nearby entities |
| `/team list ct_chain` | List all members in the chain team |

### Full state reset (without losing config)
```
/execute as @e[tag=ct_member] run function ct:util/unlink
/kill @e[tag=ct_dummy]
/function ct:admin/setup
```

---

## 🐛 Troubleshooting

**Datapack not showing in `/datapack list enabled`**
- Make sure the `pack.mcmeta` file is directly inside the `Chained-Together/` folder.

**"Unknown scoreboard objective" error**
- Run `/function ct:admin/setup` manually to re-create scoreboards.

**Players don't get linked**
- Ensure you're within 8 blocks of the other players when running `create_cluster`.
- Check with `/scoreboard players list` that `ct.status` exists.
- **If using test mode:** Do NOT run `create_cluster` — use only `/function ct:test/setup`.

**Dummy doesn't teleport with me through portals or on respawn**
- Ensure you're using `test/setup` — it force-loads the dummy's chunk.
- If you manually spawned the dummy without `test/setup`, it won't be force-loaded.
- Run `test/teardown` then `test/setup` to get a properly configured test dummy.

**Particles connect to the wrong location**
- Residual entities with the `ct_member` tag exist. Run `/function ct:admin/cleanup`.

**`test/tension` fires all 3 phases at once**
- Run `/reload` to ensure the latest version is loaded.

**Blue outline not visible**
- Run `/function ct:admin/setup` to create the `ct_chain` team.

---

## 🏗️ Datapack Structure

```
Chained-Together/
├── pack.mcmeta
├── README.md
├── CHANGELOG.md
├── docs/
│   ├── TESTING.md          (this file)
│   ├── COMMANDS.md         (all admin commands)
│   └── RELEASE_TEMPLATE.md (for future releases)
└── data/
    └── ct/function/
        ├── tick.mcfunction
        ├── admin/
        ├── test/
        ├── cluster/
        ├── view/
        └── util/
```
