#!/bin/bash
set -e

echo "Validating all skills..."
echo "========================="

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

failed=0
total=0

for skill_dir in "$PROJECT_ROOT"/skills/*; do
    if [ -d "$skill_dir" ]; then
        total=$((total + 1))
        if ! "$SCRIPT_DIR/validate-skill.sh" "$skill_dir"; then
            failed=$((failed + 1))
        fi
        echo ""
    fi
done

echo "========================="
if [ $failed -eq 0 ]; then
    echo "✅ All $total skills passed validation"
    exit 0
else
    echo "❌ $failed out of $total skills failed validation"
    exit 1
fi