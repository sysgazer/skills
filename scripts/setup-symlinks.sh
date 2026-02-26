#!/bin/bash
set -e

echo "Setting up symlinks for OpenCode skills..."

# Create .opencode/skills directory if it doesn't exist
mkdir -p .opencode/skills

# Remove any broken symlinks
find .opencode/skills -type l ! -exec test -e {} \; -delete

# Create symlinks for each skill in skills/
for skill in skills/*; do
    if [ -d "$skill" ]; then
        skill_name=$(basename "$skill")
        target="../../$skill"
        link=".opencode/skills/$skill_name"
        
        if [ -L "$link" ]; then
            echo "  Symlink already exists: $skill_name"
        else
            ln -s "$target" "$link"
            echo "  Created symlink: $skill_name"
        fi
    fi
done

echo "Done!"