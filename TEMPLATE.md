# Skill Template

Use this template to create new skills for the collection.

## Choosing a Skill Creation Approach

### For Basic to Intermediate Skills
Use **@skills/skill-builder/** which provides structured templates, validation tools, and systematic patterns for creating skills quickly.

### For Complex, Production-Ready Skills  
Use **@skills/hypercognitive-skill-compiler/** which preserves all original hypercognitive compiler thinking modes, artifact registry, and compilation passes for exhaustive skill creation with rigorous quality gates.

### Research-Driven Development
Both skill builders support **research-driven development** using available search tools (`searxng_searxng_web_search`, `searxng_web_url_read`):
- Validate requirements against Agent Skills specification
- Research best practices for skill domains
- Find examples and authoritative documentation
- Confirm implementation approaches
- Ensure comprehensive, validated skill creation

## Directory Structure

```
skills/
  {skill-name}/           # kebab-case directory name
    SKILL.md              # Required: skill definition
    scripts/              # Optional: executable scripts
      {script-name}.sh    # Bash scripts (preferred)
    references/           # Optional: supporting documentation
    assets/               # Optional: static files
```

## SKILL.md Format

```markdown
---
name: {skill-name}
description: {One sentence describing when to use this skill}
license: MIT
compatibility: opencode
metadata:
  audience: {maintainers/developers/designers/etc}
  category: {development/deployment/productivity/etc}
---

# {Skill Title}

{Detailed description of what the skill does}

## When to use me

{Describe specific scenarios where this skill should be used}

## What I do

{Bulleted list of key capabilities}

## Examples

```bash
# Example commands or usage patterns
```

## Output format

{Show example output the skill generates}

## Notes

{Any important implementation details or limitations}
```

## Best Practices

### Naming
- **Skill directory**: `kebab-case` (e.g., `git-release`, `react-review`)
- **SKILL.md**: Always uppercase, always this exact filename
- **Scripts**: `kebab-case.sh` (e.g., `deploy.sh`, `analyze.sh`)

### Content Guidelines
1. **Clear description**: Include trigger phrases users might say
2. **Specific scope**: Focus on one well-defined capability
3. **Progressive disclosure**: Keep SKILL.md concise, reference supporting files
4. **Actionable**: Provide clear steps and examples
5. **Testable**: Include validation or verification steps
6. **Research-driven**: Use search tools to validate approaches and find best practices

### Performance
- Keep SKILL.md under 500 lines
- Use scripts for complex logic (not inline code)
- Reference supporting files for detailed documentation
- Skills load on-demand, so optimize for quick understanding

## Creating a New Skill

1. Create directory: `mkdir -p skills/{skill-name}`
2. Create SKILL.md using template above
3. Add optional scripts/references/assets
4. Test locally: `npx skills add . --skill {skill-name} --list`
5. Create symlink: `npm run setup-symlinks`
6. Commit and push

## Validation

Run validation to ensure skill follows standards:

```bash
bash scripts/validate-skill.sh skills/{skill-name}
```