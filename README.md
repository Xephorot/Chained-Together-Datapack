# ⛓ Chained Together — Minecraft Datapack

A datapack for **Minecraft Java Edition** that physically chains 2–4 players together. Walk too far from your partner and you'll feel the pull — literally.

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

- **Chain physics** — Real-time tension based on distance
- **Elastic pull** — Pulled back when exceeding max distance  
- **Respawn teleport** — Entire cluster teleports to respawned player
- **Dimension teleport** — Entire cluster follows through Nether/End portals
- **Tension HUD** — Live actionbar showing tension % and distance
- **Visual chain** — Particle effects connecting linked members

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
