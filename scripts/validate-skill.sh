#!/bin/bash
set -e

# Validate a skill directory
validate_skill() {
    local skill_dir="$1"
    local skill_name=$(basename "$skill_dir")
    
    echo "Validating skill: $skill_name"
    
    # Check directory exists
    if [ ! -d "$skill_dir" ]; then
        echo "❌ Error: Skill directory not found: $skill_dir"
        return 1
    fi
    
    # Check SKILL.md exists
    if [ ! -f "$skill_dir/SKILL.md" ]; then
        echo "❌ Error: SKILL.md not found in $skill_dir"
        return 1
    fi
    
    # Check YAML frontmatter
    if ! head -20 "$skill_dir/SKILL.md" | grep -q "^---$"; then
        echo "❌ Error: SKILL.md missing YAML frontmatter (---)"
        return 1
    fi
    
    # Extract frontmatter
    local frontmatter=$(awk '/^---$/ {if (++count == 2) exit; next} count == 1' "$skill_dir/SKILL.md")
    
    # Check required fields
    if ! echo "$frontmatter" | grep -q "name:"; then
        echo "❌ Error: SKILL.md missing 'name' field"
        return 1
    fi
    
    if ! echo "$frontmatter" | grep -q "description:"; then
        echo "❌ Error: SKILL.md missing 'description' field"
        return 1
    fi
    
    # Validate name format (lowercase, hyphens, alphanumeric)
    local name=$(echo "$frontmatter" | grep "name:" | cut -d: -f2 | tr -d ' ' | tr -d '"' | tr -d "'")
    if [[ ! "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
        echo "❌ Error: Skill name '$name' must be lowercase alphanumeric with hyphens"
        return 1
    fi
    
    # Check name matches directory
    if [ "$name" != "$skill_name" ]; then
        echo "❌ Error: Skill name '$name' does not match directory name '$skill_name'"
        return 1
    fi
    
    # Check description length
    local desc=$(echo "$frontmatter" | grep "description:" | cut -d: -f2- | sed 's/^ *//')
    if [ ${#desc} -gt 1024 ]; then
        echo "⚠️  Warning: Description may be too long (max 1024 chars)"
    fi
    
    # Check for scripts directory
    if [ -d "$skill_dir/scripts" ]; then
        echo "Checking scripts..."
        for script in "$skill_dir/scripts"/*.sh; do
            if [ -f "$script" ]; then
                if [ ! -x "$script" ]; then
                    echo "⚠️  Warning: Script not executable: $(basename "$script")"
                fi
            fi
        done
    fi
    
    echo "✅ Skill '$skill_name' validation passed"
    return 0
}

# Main
if [ $# -eq 0 ]; then
    echo "Usage: $0 <skill-directory>"
    echo "Example: $0 skills/git-release"
    exit 1
fi

validate_skill "$1"