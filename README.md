# ⛓ Chained Together — Minecraft Datapack

A datapack for **Minecraft Java Edition** that physically chains 2–4 players together. Walk too far from your partner and you'll feel the pull — literally.

> **Inspired by** the game **Chained Together**

> **Version**: `0.1.0-beta` | **Minecraft**: Java Edition 26.1 – 26.1.2 | **Pack Format**: 71

---

## 🚀 Quick Start

### 1. Installation
```text
1. Copy Chained-Together/ to .minecraft/saves/<YourWorld>/datapacks/
2. In-game: /reload
3. Verify: /datapack list enabled
```

### 2. Admin Setup (Operator)
Add the operator tag to yourself to receive system and diagnostic messages:
```mcfunction
/tag @s add ct_op
```

### 3. Link Players
Stand near the players you want to chain (within 8 blocks) and run:
```mcfunction
/function ct:admin/create_cluster
```
*Note: This automatically assigns the `ct_member` tag to all linked players so they can see tension HUDs and group notifications.*

### 4. Test Single Player (Optional)
If you are alone and want to test the mechanics with an armor stand dummy:
```mcfunction
/function ct:test/setup    # Create test dummy
/function ct:test/teardown # Clean up
```

### 5. Unlink Players
```mcfunction
# Unlink a specific player
/execute as <player> run function ct:util/unlink

# Unlink everyone
/execute as @a[tag=ct_member] run function ct:util/unlink
```

---

## ✨ Key Features

### Core Physics
- **Real-time chain physics** — Tension calculated every tick using Chebyshev distance to nearest linked member
- **Speed resistance** — Gradual slowdown as tension increases (50%–100% of max distance)
- **Elastic pull** — Physically pulled back toward your partner when exceeding max distance
- **Collision-aware** — Pull verifies block passability to prevent clipping into terrain

### Damage & Survival
- **Tension damage** — Hunger at moderate tension, direct damage at critical levels (>3× max distance)
- **Slowness effect** — Movement slowed when chain is critically strained
- **Anti-sinking** — Y-position preserved during pull to prevent sinking into ground

### Visual & UI
- **Tension HUD** — Live actionbar showing tension percentage and distance in blocks
- **Color-coded warnings** — Green → Yellow → Red → Dark Red (critical)
- **Particle chain** — Enchant particles connecting linked members
- **Through-wall visibility** — Blue glowing outline on all linked players (team-based)
- **Sound feedback** — Chain step sounds with volume based on tension

### Respawn & Portals
- **Respawn teleport** — When a player dies, entire cluster teleports to their spawn after 2s delay
- **Dimension teleport** — When traversing Nether/End portals, cluster follows automatically
- **Safety effects** — Slow falling + resistance applied after teleport to prevent fall damage
- **Chunk forceload** — Test dummies stay loaded across dimensions for reliable testing

### Customization
- **Configurable** — Max distance, resistance strength, elastic toggle via data storage
- **Test mode** — Single-player testing with armor stand dummy
- **Admin commands** — `setup`, `create_cluster`, `cleanup`, `set_physics`

---

## 📚 Documentation

| File | Contents |
|---|---|
| [docs/TESTING.md](docs/TESTING.md) | Full testing guide, respawn/dimension tests, troubleshooting |
| [docs/COMMANDS.md](docs/COMMANDS.md) | All commands, configuration options, scoreboards |
| [docs/RELEASE_TEMPLATE.md](docs/RELEASE_TEMPLATE.md) | Template for future releases |
| [CHANGELOG.md](CHANGELOG.md) | Version history |

---

## 🎮 How It Works

1. **Link players** with `/function ct:admin/create_cluster`
2. **Walk apart** — feel the chain pull you back
3. **Die/Respawn** — cluster teleports to your spawn automatically
4. **Use portals** — cluster follows you to Nether/End automatically

---

## 📄 License

[MIT License](LICENSE) — Use freely, keep attribution.

---

Developed with AI assistance (Cascade / Claude) as a pair programming collaboration.
