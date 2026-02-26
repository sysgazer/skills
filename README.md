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

### Core Skills

#### git-release
Create consistent releases and changelogs from merged PRs.

**Use when:** Preparing a tagged release, generating release notes, proposing version bumps.

#### react-review
Review React components for best practices and performance issues.

**Use when:** Reviewing React component code, optimizing performance, checking best practices.

#### vercel-deploy
Deploy applications to Vercel with automatic framework detection.

**Use when:** Deploying web applications, setting up hosting, testing deployment configuration.

#### skill-builder
Build basic to intermediate Agent Skills using structured templates and validation tools.

**Use when:** Creating simple to moderately complex skills, validating skill structure, analyzing requirements.

#### hypercognitive-skill-compiler
Transform complex skill requirements into complete Agent Skills using exhaustive hypercognitive compiler thinking patterns.

**Use when:** Building production-ready, complex skills with rigorous quality gates, error handling, and comprehensive validation.

#### index
Maintain directory organization with index files (_index.md/_index.yaml/_index.json) and consistency prompts (_prompt.md).

**Use when:** Setting up project structure, maintaining directory documentation, ensuring file consistency, reducing context switching.

### Testing Ecosystem

#### Basic Test Types
- **testing-unit**: Run unit tests for individual code components
- **testing-integration**: Run integration tests for component interactions
- **testing-e2e**: Run end-to-end tests for complete user workflows
- **testing-api**: Test API endpoints and contracts
- **testing-performance**: Test application performance and load handling
- **testing-security**: Test application security vulnerabilities
- **testing-accessibility**: Test application accessibility compliance

#### Specialized Test Types
- **testing-regression**: Run regression tests to ensure new changes don't break existing functionality
- **testing-smoke**: Run smoke tests to verify basic application functionality
- **testing-compatibility**: Test application compatibility across browsers, devices, and platforms
- **testing-usability**: Test application usability and user experience
- **testing-database**: Test database interactions, schemas, and data integrity
- **testing-chaos**: Run chaos engineering tests to build resilient systems

#### Test Coordination & Management
- **test-orchestrator**: Orchestrate and coordinate different test types in proper order
- **test-dependency-mapper**: Map dependencies and relationships between different test types
- **test-planning**: Create comprehensive test plans considering all test types and dependencies
- **test-coverage**: Measure and report test coverage across all test types
- **testing-ecosystem**: Understand the complete testing ecosystem and relationships between test types

#### Testing Level Strategies
- **testing-level-poc**: Testing strategy for Proof of Concept projects
- **testing-level-mvp**: Testing strategy for Minimum Viable Product
- **testing-level-production**: Testing strategy for production deployment
- **testing-level-selector**: Select appropriate testing level based on project stage

#### Test Suites
- **testing-functional-suite**: Run comprehensive functional test suite
- **testing-nonfunctional-suite**: Run comprehensive non-functional test suite

#### Skeptical Verification
- **trust-but-verify**: Verify system claims and test results through independent validation rather than trusting assumptions
- **assumption-testing**: Identify, document, and explicitly test assumptions rather than leaving them implicit and untested
- **reality-validation**: Compare system behavior against real-world expectations and domain knowledge rather than just technical specifications

## Skill Reference

| Skill | Description | Directory | Documentation |
|-------|------------|-----------|---------------|
| git-release | Create consistent releases and changelogs | [skills/git-release/](./skills/git-release/) | [references/README.md](./skills/git-release/references/README.md) |
| react-review | Review React components for best practices | [skills/react-review/](./skills/react-review/) | [references/README.md](./skills/react-review/references/README.md) |
| vercel-deploy | Deploy applications to Vercel | [skills/vercel-deploy/](./skills/vercel-deploy/) | [references/README.md](./skills/vercel-deploy/references/README.md) |
| skill-builder | Build basic to intermediate Agent Skills | [skills/skill-builder/](./skills/skill-builder/) | [references/README.md](./skills/skill-builder/references/README.md) |
| hypercognitive-skill-compiler | Transform complex skill requirements | [skills/hypercognitive-skill-compiler/](./skills/hypercognitive-skill-compiler/) | [references/README.md](./skills/hypercognitive-skill-compiler/references/README.md) |
| index | Maintain directory organization with index files | [skills/index/](./skills/index/) | [references/README.md](./skills/index/references/README.md) |
| testing-unit | Run unit tests for individual components | [skills/testing-unit/](./skills/testing-unit/) | [references/README.md](./skills/testing-unit/references/README.md) |
| testing-integration | Run integration tests | [skills/testing-integration/](./skills/testing-integration/) | [references/README.md](./skills/testing-integration/references/README.md) |
| testing-e2e | Run end-to-end tests | [skills/testing-e2e/](./skills/testing-e2e/) | [references/README.md](./skills/testing-e2e/references/README.md) |
| testing-api | Test API endpoints and contracts | [skills/testing-api/](./skills/testing-api/) | [references/README.md](./skills/testing-api/references/README.md) |
| testing-performance | Test application performance | [skills/testing-performance/](./skills/testing-performance/) | [references/README.md](./skills/testing-performance/references/README.md) |
| testing-security | Test security vulnerabilities | [skills/testing-security/](./skills/testing-security/) | [references/README.md](./skills/testing-security/references/README.md) |
| testing-accessibility | Test accessibility compliance | [skills/testing-accessibility/](./skills/testing-accessibility/) | [references/README.md](./skills/testing-accessibility/references/README.md) |
| testing-regression | Run regression tests | [skills/testing-regression/](./skills/testing-regression/) | [references/README.md](./skills/testing-regression/references/README.md) |
| testing-smoke | Run smoke tests | [skills/testing-smoke/](./skills/testing-smoke/) | [references/README.md](./skills/testing-smoke/references/README.md) |
| testing-compatibility | Test compatibility across platforms | [skills/testing-compatibility/](./skills/testing-compatibility/) | [references/README.md](./skills/testing-compatibility/references/README.md) |
| testing-usability | Test usability and UX | [skills/testing-usability/](./skills/testing-usability/) | [references/README.md](./skills/testing-usability/references/README.md) |
| testing-database | Test database interactions | [skills/testing-database/](./skills/testing-database/) | [references/README.md](./skills/testing-database/references/README.md) |
| testing-chaos | Run chaos engineering tests | [skills/testing-chaos/](./skills/testing-chaos/) | [references/README.md](./skills/testing-chaos/references/README.md) |
| test-orchestrator | Orchestrate test execution | [skills/test-orchestrator/](./skills/test-orchestrator/) | [references/README.md](./skills/test-orchestrator/references/README.md) |
| test-dependency-mapper | Map test dependencies | [skills/test-dependency-mapper/](./skills/test-dependency-mapper/) | [references/README.md](./skills/test-dependency-mapper/references/README.md) |
| test-planning | Create comprehensive test plans | [skills/test-planning/](./skills/test-planning/) | [references/README.md](./skills/test-planning/references/README.md) |
| test-coverage | Measure test coverage | [skills/test-coverage/](./skills/test-coverage/) | [references/README.md](./skills/test-coverage/references/README.md) |
| testing-ecosystem | Understand testing ecosystem | [skills/testing-ecosystem/](./skills/testing-ecosystem/) | [references/README.md](./skills/testing-ecosystem/references/README.md) |
| testing-level-poc | Testing for Proof of Concept | [skills/testing-level-poc/](./skills/testing-level-poc/) | [references/README.md](./skills/testing-level-poc/references/README.md) |
| testing-level-mvp | Testing for Minimum Viable Product | [skills/testing-level-mvp/](./skills/testing-level-mvp/) | [references/README.md](./skills/testing-level-mvp/references/README.md) |
| testing-level-production | Testing for production deployment | [skills/testing-level-production/](./skills/testing-level-production/) | [references/README.md](./skills/testing-level-production/references/README.md) |
| testing-level-selector | Select testing level based on project | [skills/testing-level-selector/](./skills/testing-level-selector/) | [references/README.md](./skills/testing-level-selector/references/README.md) |
| testing-functional-suite | Run functional test suite | [skills/testing-functional-suite/](./skills/testing-functional-suite/) | [references/README.md](./skills/testing-functional-suite/references/README.md) |
| testing-nonfunctional-suite | Run non-functional test suite | [skills/testing-nonfunctional-suite/](./skills/testing-nonfunctional-suite/) | [references/README.md](./skills/testing-nonfunctional-suite/references/README.md) |
| trust-but-verify | Verify claims skeptically | [skills/trust-but-verify/](./skills/trust-but-verify/) | [references/README.md](./skills/trust-but-verify/references/README.md) |
| assumption-testing | Test implicit assumptions | [skills/assumption-testing/](./skills/assumption-testing/) | [references/README.md](./skills/assumption-testing/references/README.md) |
| reality-validation | Validate against real-world | [skills/reality-validation/](./skills/reality-validation/) | [references/README.md](./skills/reality-validation/references/README.md) |

## Local Development

This repository includes a `.opencode/skills/` directory with symlinks to the main `skills/` directory. This allows OpenCode to discover skills locally while keeping the canonical source in the `skills/` folder.

Each skill includes comprehensive documentation:
- **SKILL.md**: Primary skill definition with usage instructions, examples, and output format
- **references/README.md**: Detailed reference documentation, implementation notes, and additional context
- **scripts/**: Optional executable scripts for skill functionality

To add a new skill:

1. Create a directory in `skills/<skill-name>/`
2. Add a `SKILL.md` file with proper frontmatter
3. Add skill documentation in `references/README.md`
4. Create a symlink in `.opencode/skills/`:

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