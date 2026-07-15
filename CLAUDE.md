# Vault 23

Fallout: New Vegas mod concept — design documents and a browsable/playable HTML dossier; no actual game assets or mod code yet.

## What's here

All source documents live in `project-notes/`; the repo root only holds the generated HTML site (`index.html`, `html/`, `assets/`) plus this file.

- `project-notes/outline-index.md` — start here; links to every topic file below
- `project-notes/lore.md` — premise, the twist, cover story, succession rule
- `project-notes/characters.md` — the Overseer, the son, the mother, the doctor, Clyde
- `project-notes/vault-layout.md` — the vault itself: room-by-room layout, life support, resident roster
- `project-notes/characters/` — one directory per named resident (schedule now, voice lines later), grouped into `ruling-family/`, `enforcement/`, `medical/`, `kitchen/`, `misc/`, `school/`. A resident's directory holds their `<name>.md` plus a `dialogue/` subdirectory with their playable dialogue trees, written in [Ink](https://www.inklestudios.com/ink/) (`.ink`), one file per conversation. Dialogue shared between characters (e.g. a scene both Clyde and the Overseer appear in) is duplicated across each participant's `dialogue/` directory.
- `project-notes/story-beats.md` — chronological story beats (3.1–3.7)
- `project-notes/endings.md` — ending paths (A/B/C/D)
- `project-notes/epilogues.md` — post-credits slideshow per ending
- `project-notes/open-questions.md` — open questions / next to flesh out
- `index.html` — single-file, dependency-free HTML rendering of the outline (styled as a Vault-Tec case file), styled via `assets/vault.css`. Opens directly in any browser, no build step; also served live via GitHub Pages at the repo root.
- `html/characters/` — one generated HTML page per named resident, mirroring `project-notes/characters/`, linked from `index.html`. Pages with a written dialogue tree embed a playable widget (`assets/dialogue-player.js`) that fetches and runs the matching `.ink` file client-side via the vendored [inkjs](https://github.com/y-lohse/inkjs) runtime (`assets/vendor/ink-full.js`) — no build step, no server.

## Conventions

- Never include a `Co-Authored-By` trailer in git commits in this repo.
