# Skills Collection

A personal collection of AI agent skills following the [Agent Skills](https://agentskills.io) open standard.

## Installation

Install all skills using the [skills CLI](https://github.com/vercel-labs/skills):

```bash
npx skills add <your-username>/skills
```

Or install specific skills:

```bash
npx skills add <your-username>/skills --skill git-release
```

## Quick Start

```bash
# Clone the repository
git clone <repository-url>
cd skills

# Setup symlinks for local development
npm run setup-symlinks

# Create a new skill
npm run create-skill -- my-new-skill "Description of my new skill"

# Validate all skills
npm run validate

# Install locally for testing
npx skills add . --skill my-new-skill
```

## Available Skills

### git-release

Create consistent releases and changelogs from merged PRs.

**Use when:** Preparing a tagged release, generating release notes, proposing version bumps.

**Features:**
- Draft release notes from merged PRs
- Propose semantic versioning bumps
- Provide ready-to-use `gh release create` commands

### react-review

Review React components for best practices and performance issues.

**Use when:** Reviewing React component code, optimizing performance, checking best practices.

**Features:**
- Analyze React components for performance issues
- Check for React best practices and anti-patterns
- Identify TypeScript usage and type safety
- Suggest optimizations and refactoring

### vercel-deploy

Deploy applications to Vercel with automatic framework detection.

**Use when:** Deploying web applications, setting up hosting, testing deployment configuration.

**Features:**
- Automatic framework detection (Next.js, Vite, Astro, etc.)
- Deployment configuration validation
- Environment variable guidance
- Multiple deployment method support

### skill-builder

Build basic to intermediate Agent Skills using structured templates and validation tools.

**Use when:** Creating simple to moderately complex skills, validating skill structure, analyzing requirements.

**Features:**
- Structured skill creation workflow with templates
- Skill validation and requirements analysis
- Template generation with proper frontmatter
- Reference documentation for skill creation
- *For complex skills, use hypercognitive-skill-compiler*

### hypercognitive-skill-compiler

Transform complex skill requirements into complete Agent Skills using exhaustive hypercognitive compiler thinking patterns.

**Use when:** Building production-ready, complex skills with rigorous quality gates, error handling, and comprehensive validation.

**Features:**
- Raw hypercognitive compiler preserving all original thinking modes
- Complete artifact registry (A0-A17) and compilation passes
- All internal thinking blocks from workflow prompt foundry
- Exhaustive internal cognition for complex skill creation
- *For basic skills, use skill-builder instead*

## Local Development

This repository includes a `.opencode/skills/` directory with symlinks to the main `skills/` directory. This allows OpenCode to discover skills locally while keeping the canonical source in the `skills/` folder.

To add a new skill:

1. Create a directory in `skills/<skill-name>/`
2. Add a `SKILL.md` file with proper frontmatter
3. Create a symlink in `.opencode/skills/`:

```bash
ln -s ../../skills/<skill-name> .opencode/skills/<skill-name>
```

## Development

### Scripts

The repository includes several helper scripts:

- `npm run setup-symlinks` - Create symlinks in `.opencode/skills/`
- `npm run validate` - Validate all skills
- `npm run validate-skill` - Validate a specific skill
- `npm run create-skill` - Create a new skill from template

### Creating Skills

See [TEMPLATE.md](./TEMPLATE.md) for a complete skill template and best practices.

For quick creation:

```bash
npm run create-skill -- my-new-skill "Description of my new skill" [category]
```

Categories: development, deployment, productivity, testing, documentation, security

### Testing

Test skills locally:

```bash
# Validate skill structure
npm run validate

# Test with skills CLI
npx skills add . --skill <skill-name> --list

# Install to OpenCode locally
npm run setup-symlinks
```

## Skill Structure

Each skill follows the standard Agent Skills format:

```
skills/
  <skill-name>/
    SKILL.md          # Required: skill definition with YAML frontmatter
    scripts/          # Optional: executable scripts
    references/       # Optional: supporting documentation
```

### SKILL.md Requirements

- Must start with YAML frontmatter containing `name` and `description`
- `name` must be lowercase alphanumeric with hyphens (1-64 chars)
- `description` must be 1-1024 characters
- Follows the [Agent Skills specification](https://agentskills.io/specification)

## Compatibility

Skills are compatible with any agent that supports the Agent Skills standard, including:

- OpenCode
- Claude Code
- Cursor
- Codex
- Antigravity
- And [37+ more agents](https://github.com/vercel-labs/skills#supported-agents)

## License

MIT