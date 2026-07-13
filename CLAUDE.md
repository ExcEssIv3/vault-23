# Vault 23

Fallout: New Vegas mod concept — design documents only, no game assets or code yet.

## What's here

All source documents live in `project-notes/`; the repo root only holds the generated HTML site (`index.html`, `html/`, `assets/`) plus this file.

- `project-notes/outline-index.md` — start here; links to every topic file below
- `project-notes/lore.md` — premise, the twist, cover story, succession rule
- `project-notes/characters.md` — the Overseer, the son, the mother, the doctor, Clyde
- `project-notes/vault-layout.md` — the vault itself: room-by-room layout, life support, resident roster
- `project-notes/characters/` — one markdown file per named resident (schedule now, voice lines later), grouped into `ruling-family/`, `enforcement/`, `medical/`, `kitchen/`, `misc/`, `school/`
- `project-notes/story-beats.md` — chronological story beats (3.1–3.7)
- `project-notes/endings.md` — ending paths (A/B/C/D)
- `project-notes/epilogues.md` — post-credits slideshow per ending
- `project-notes/open-questions.md` — open questions / next to flesh out
- `index.html` — single-file, dependency-free HTML rendering of the outline (styled as a Vault-Tec case file), styled via `assets/vault.css`. Opens directly in any browser, no build step; also served live via GitHub Pages at the repo root.
- `html/characters/` — one generated HTML page per named resident, mirroring `project-notes/characters/`, linked from `index.html`.

## Conventions

- Never include a `Co-Authored-By` trailer in git commits in this repo.
