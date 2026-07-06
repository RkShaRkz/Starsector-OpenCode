# AGENTS.md — Starsector-OpenCode

**What this repo is:** A starter setup for using [OpenCode](https://opencode.ai) with Starsector mod development on Windows via WSL + Ubuntu.

## Key facts

- **Only 2 tracked files as of this writing:** `README.md` and `.gitignore`. Treat this as a blank canvas for mod projects.
- **Java mod toolchain assumed:** `.gitignore` excludes `.class`, `.jar`, `.zip`, `*.log`, `*.ctxt` (BlueJ). Do not track compiled mod artifacts.
- **Target platform:** Windows → WSL2 → Ubuntu. OpenCode runs inside WSL.
- **GUI requirement:** XServer needed on Windows host to run Starsector from WSL (not covered in README yet).
- **No CI, no tests, no build scripts defined yet.** When adding them, prefer scripts under a `scripts/` dir or `Makefile`.

## Common workflows

- `wsl --install` — bootstrap WSL + Ubuntu (run from Windows admin cmd)
- `sudo apt update && sudo apt upgrade -y` — update fresh WSL Ubuntu
- `curl -fsSL https://opencode.ai/install | bash` — install OpenCode in WSL
