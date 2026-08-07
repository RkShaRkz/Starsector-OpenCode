#!/usr/bin/env bash
set -e

echo "=== Step 1: Pulling updates for all submodules ==="
# Recursively pull the latest commits for all your submodules
git submodule update --init --recursive --remote

echo "=== Step 2 & 3: Copying and flattening folders to ../skills ==="
DEST="../skills"

# 1. Clean the destination so we don't keep deleted or stale skills
if [ -d "$DEST" ]; then
    # Delete contents but keep the folder to avoid breaking Git's tracking state
    rm -rf "$DEST"/*
else
    mkdir -p "$DEST"
fi

# 2. Deploy Andrej Karpathy's skills
# Copies the 'karpathy-guidelines' folder directly into ../skills/
if [ -d "andrej-karpathy-skills/skills/karpathy-guidelines" ]; then
    cp -r "andrej-karpathy-skills/skills/karpathy-guidelines" "$DEST/"
fi

# 3. Deploy Superpowers skills
# Copies individual skill folders out of superpowers/skills/* directly into ../skills/
if [ -d "superpowers/skills" ]; then
    for d in superpowers/skills/*/; do
        # Strip the trailing slash for safe copying
        d_trimmed="${d%/}"
        if [ -d "$d_trimmed" ]; then
            cp -r "$d_trimmed" "$DEST/"
        fi
    done
fi

# 4. Deploy Matt Pocock's skills
# Loops through categories and copies individual skill folders directly into ../skills/
if [ -d "skills" ]; then
    for cat in engineering in-progress misc personal productivity; do
        if [ -d "skills/skills/$cat" ]; then
            for d in skills/skills/$cat/*/; do
                d_trimmed="${d%/}"
                if [ -d "$d_trimmed" ]; then
                    cp -r "$d_trimmed" "$DEST/"
                fi
            done
        fi
    done
fi

echo "=== Success: Real folders copied to $DEST! Ready for git commit. ==="
