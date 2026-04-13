# Release Template

Use this template when creating a new GitHub release.

---

## Title format
```
v{VERSION} — Chained Together Datapack for MC {MC_VERSION}
```

## Tag format
```
v{VERSION}
```
Example: `v0.1.0-beta`

## Release body template

Copy and paste the following into the GitHub release description, replacing placeholders:

---

```markdown
# Chained Together v{VERSION}

**Minecraft Java Edition**: {MC_VERSION}
**Pack Format**: {PACK_FORMAT}

## What's New
<!-- Paste relevant section from CHANGELOG.md here -->

## Download & Install

1. Download `Chained-Together-v{VERSION}.zip` from the assets below
2. Extract the `Chained-Together/` folder into your world's `datapacks/` directory:
   ```
   .minecraft/saves/<YourWorld>/datapacks/Chained-Together/
   ```
3. In-game, run `/reload`
4. Verify: `/datapack list enabled` — you should see `[file/Chained-Together]`

## Quick Start

**Multiplayer:**
```
/function ct:admin/create_cluster
```
Links all players within 8 blocks.

**Single Player (test mode):**
```
/function ct:test/setup
```
Creates a dummy armor stand to test chain mechanics solo.

## Known Issues
<!-- List any known issues for this version -->

## Full Changelog
See [CHANGELOG.md](CHANGELOG.md) for the complete history.
```

---

## How to create a release

1. Update version string in `pack.mcmeta` description
2. Add new entry to `CHANGELOG.md`
3. Zip the `Chained-Together/` folder (the folder itself must be the root inside the zip)
4. Go to GitHub → Releases → Draft a new release
5. Create tag: `v{VERSION}` (e.g. `v0.1.0-beta`)
6. Title: `v{VERSION} — Chained Together Datapack for MC {MC_VERSION}`
7. Paste the release body from the template above
8. Attach the `.zip` file
9. Check "Pre-release" if it's alpha/beta
10. Publish
