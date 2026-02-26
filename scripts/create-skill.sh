#!/bin/bash
set -e

# Create a new skill from template
create_skill() {
    local skill_name="$1"
    local description="$2"
    local category="${3:-development}"
    
    # Validate skill name
    if [[ ! "$skill_name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
        echo "❌ Error: Skill name must be lowercase alphanumeric with hyphens"
        echo "Example: git-release, react-review, deploy-vercel"
        exit 1
    fi
    
    # Check if skill already exists
    if [ -d "skills/$skill_name" ]; then
        echo "❌ Error: Skill '$skill_name' already exists"
        exit 1
    fi
    
    # Create directory structure
    echo "Creating skill: $skill_name"
    mkdir -p "skills/$skill_name/scripts"
    mkdir -p "skills/$skill_name/references"
    mkdir -p "skills/$skill_name/assets"
    
    # Create SKILL.md from template
    cat > "skills/$skill_name/SKILL.md" << EOF
---
name: $skill_name
description: $description
license: MIT
compatibility: opencode
metadata:
  audience: developers
  category: $category
---

# $(echo "$skill_name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1')

$description

## When to use me

Use this skill when you need to...

## What I do

- First capability
- Second capability  
- Third capability

## Examples

\`\`\`bash
# Example usage
\`\`\`

## Output format

\`\`\`
Example output format
\`\`\`

## Notes

- Important implementation details
- Any limitations or requirements
EOF
    
    # Create example script
    cat > "skills/$skill_name/scripts/example.sh" << 'EOF'
#!/bin/bash
set -e

# Example script for skill
echo "Running $0"
echo "Skill: $(basename $(dirname $(dirname "$0")))"
echo "Arguments: $@"

# Add your script logic here
EOF
    
    chmod +x "skills/$skill_name/scripts/example.sh"
    
    # Create reference documentation
    cat > "skills/$skill_name/references/README.md" << EOF
# $skill_name - Reference Documentation

Add detailed documentation, API references, or implementation notes here.

This file can be referenced from SKILL.md using links.
EOF
    
    echo "✅ Skill '$skill_name' created successfully"
    echo ""
    echo "Next steps:"
    echo "1. Edit skills/$skill_name/SKILL.md with detailed instructions"
    echo "2. Add scripts to skills/$skill_name/scripts/"
    echo "3. Run validation: ./scripts/validate-skill.sh skills/$skill_name"
    echo "4. Create symlink: npm run setup-symlinks"
    echo "5. Test locally: npx skills add . --skill $skill_name --list"
}

# Main
if [ $# -lt 2 ]; then
    echo "Usage: $0 <skill-name> <description> [category]"
    echo "Example: $0 git-release 'Create consistent releases and changelogs' deployment"
    echo ""
    echo "Categories: development, deployment, productivity, testing, documentation, security"
    exit 1
fi

create_skill "$1" "$2" "$3"