# AGENTS.md

**Goal:** Build a personal collection of AI agent skills that follows the Agent Skills open standard and can be installed via the skills CLI (`npx skills add`). Skills should be research-driven, using search tools to validate approaches and find best practices.

This file provides guidance to AI coding agents (OpenCode, Claude Code, Cursor, etc.) when working with code in this repository.

## Repository Overview

A collection of skills for AI coding agents. Skills are packaged instructions and scripts that extend agent capabilities. Skills follow the [Agent Skills specification](https://agentskills.io).

## Quick Start

When starting work on this repository:

1. **Read this file first** - Understand the repository goals and available commands
2. **Choose skill creation approach** - Use `skill-builder` for basic/intermediate skills or `hypercognitive-skill-compiler` for complex skills
3. **Use research-driven development** - Validate requirements and find best practices using search tools (`searxng_searxng_web_search`, `searxng_web_url_read`)
4. **Follow validation steps** - Run `npm run validate` after making changes
5. **Create symlinks for local testing** - Run `npm run setup-symlinks` for OpenCode discovery

## Available Commands

### Development Commands
```bash
# Validate all skills in the repository
npm run validate

# Validate a specific skill
npm run validate-skill skills/<skill-name>

# Create a new skill from template
npm run create-skill -- <skill-name> "<description>" [category]

# Setup symlinks for OpenCode discovery
npm run setup-symlinks
```

### Testing & Validation
```bash
# Validate skill structure and frontmatter
bash scripts/validate-skill.sh skills/<skill-name>

# Validate complete skill bundle
bash skills/hypercognitive-skill-compiler/scripts/validate-bundle.sh skills/<skill-name>

# Test with skills CLI
npx skills add . --skill <skill-name> --list

# Install skill locally for testing
npx skills add . --skill <skill-name> -a opencode -y
```

## Skill Creation Approaches

### For Basic to Intermediate Skills
Use **@skills/skill-builder/** which provides structured templates, validation tools, and systematic patterns for creating skills quickly.

### For Complex, Production-Ready Skills
Use **@skills/hypercognitive-skill-compiler/** which preserves all original hypercognitive compiler thinking modes, artifact registry, and compilation passes for exhaustive skill creation with rigorous quality gates.

## Code Style Guidelines

### Directory Structure
```
skills/
  {skill-name}/           # kebab-case directory name
    SKILL.md              # Required: skill definition
    scripts/              # Optional: executable scripts
      {script-name}.sh    # Bash scripts (preferred)
    references/           # Optional: supporting documentation
    assets/               # Optional: static files
```

### Naming Conventions
- **Skill directory**: `kebab-case` (e.g., `git-release`, `react-review`)
- **SKILL.md**: Always uppercase, always this exact filename
- **Scripts**: `kebab-case.sh` (e.g., `deploy.sh`, `analyze.sh`)
- **Skill name**: Must match regex `^[a-z0-9]+(-[a-z0-9]+)*$`

### SKILL.md Requirements
```markdown
---
name: {skill-name}
description: {One sentence describing when to use this skill}
license: MIT
compatibility: opencode
metadata:
  audience: {target-audience}
  category: {category}
---

# {Skill Title}

{Detailed description}

## When to use me

{Specific scenarios}

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

### Script Requirements
1. **Shebang**: `#!/bin/bash`
2. **Fail-fast**: `set -e`
3. **Error messages**: `echo "Message" >&2`
4. **Clean output**: Machine-readable to stdout
5. **Cleanup**: `trap 'cleanup' EXIT`
6. **Security**: Never include credentials, API keys, or secrets

### Script Best Practices
```bash
#!/bin/bash
set -e

echo "Status message" >&2

# Validate inputs
if [ -z "$required_var" ]; then
    echo "Error: required_var is missing" >&2
    exit 1
fi

# Main logic
if ! command_to_run; then
    echo "Error: command failed" >&2
    exit 1
fi

# Output JSON for machine parsing
echo '{"status": "success", "data": "..."}'
```

## Research-Driven Development

### Available Search Tools
- `searxng_searxng_web_search`: For broad web searches
- `searxng_web_url_read`: For reading specific URLs

### When to Use Search Tools
1. Validate skill requirements against Agent Skills specification
2. Research best practices for skill domain
3. Find examples and authoritative documentation
4. Confirm implementation approaches
5. Check security considerations and compatibility

### Research Protocol
1. **Start broad**: "Agent Skills [domain] best practices"
2. **Refine queries**: Based on initial results
3. **Read authoritative sources**: Official docs, GitHub repos, blog posts
4. **Cross-reference**: Confirm from 2+ independent sources
5. **Document findings**: Cite sources in skill references

## Quality Gates

### Pre-Implementation
- [ ] Requirements clearly defined
- [ ] Research completed for domain
- [ ] Scope boundaries established
- [ ] Success artifact designed
- [ ] Component plan created

### During Implementation
- [ ] Frontmatter valid (YAML syntax, name format, description length)
- [ ] Scripts executable and secure
- [ ] References complete and accurate
- [ ] Structure follows standards
- [ ] Examples working and realistic

### Post-Implementation
- [ ] Complete bundle validation passed
- [ ] Edge cases handled
- [ ] Security constraints satisfied
- [ ] Compatibility verified
- [ ] Research sources documented

## Error Handling

### Input Validation Errors
- **Detection**: Schema validation fails
- **Recovery**: Ask up to 7 precise questions
- **Fallback**: Use conservative defaults with warnings
- **Abort**: If critical security information missing

### Script Execution Errors
- **Detection**: Exit code ≠ 0
- **Recovery**: Retry logic (max 3 attempts)
- **Fallback**: Provide manual steps
- **Abort**: If security constraint violated

### Compatibility Errors
- **Detection**: Agent not supported
- **Recovery**: Adjust skill for target agents
- **Fallback**: Mark as agent-specific skill
- **Abort**: If required agent not supported

## Available Skills

### git-release
Create consistent releases and changelogs from merged PRs.

**Use when:** Preparing a tagged release, generating release notes, proposing version bumps.

### react-review
Review React components for best practices and performance issues.

**Use when:** Reviewing React component code, optimizing performance, checking best practices.

### vercel-deploy
Deploy applications to Vercel with automatic framework detection.

**Use when:** Deploying web applications, setting up hosting, testing deployment configuration.

### skill-builder
Build basic to intermediate Agent Skills using structured templates and validation tools.

**Use when:** Creating simple to moderately complex skills, validating skill structure, analyzing requirements.

### hypercognitive-skill-compiler
Transform complex skill requirements into complete Agent Skills using exhaustive hypercognitive compiler thinking patterns.

**Use when:** Building production-ready, complex skills with rigorous quality gates, error handling, and comprehensive validation.

## Installation

Users can install skills using the skills CLI:

```bash
npx skills add <owner>/skills
```

## Development

See [CONTRIBUTING.md](./CONTRIBUTING.md) for contribution guidelines and [TEMPLATE.md](./TEMPLATE.md) for skill templates.