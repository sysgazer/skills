# Contributing to Skills Collection

Thank you for your interest in contributing to this skills collection!

## How to Contribute

### 1. Adding a New Skill

1. **Check for existing skills**: Ensure a similar skill doesn't already exist
2. **Use the template**: Follow the structure in [TEMPLATE.md](./TEMPLATE.md)
3. **Create the skill**: Use the helper script:

```bash
npm run create-skill -- <skill-name> "<description>" [category]
```

4. **Implement the skill**:
   - Edit `SKILL.md` with clear instructions
   - Add scripts if needed (in `scripts/` directory)
   - Include examples and output format

5. **Validate your skill**:
```bash
npm run validate-skill skills/<skill-name>
```

6. **Test locally**:
```bash
# Create symlinks for OpenCode
npm run setup-symlinks

# Test with skills CLI
npx skills add . --skill <skill-name> --list
```

7. **Submit a Pull Request**

### 2. Improving Existing Skills

- Fix bugs or typos
- Add more examples
- Improve clarity of instructions
- Add missing functionality
- Update for compatibility changes

### 3. Reporting Issues

When reporting issues, please include:
- Skill name
- Description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Any error messages

## Skill Guidelines

### Quality Standards

1. **Clear purpose**: Each skill should have one well-defined purpose
2. **Actionable**: Provide clear steps the agent can follow
3. **Testable**: Include validation or verification steps
4. **Well-documented**: Clear examples and output format
5. **Maintainable**: Follow the established structure

### Technical Requirements

1. **Valid frontmatter**: Must include `name` and `description`
2. **Proper naming**: kebab-case, lowercase alphanumeric with hyphens
3. **Size limits**: SKILL.md under 500 lines, description under 1024 chars
4. **Script requirements**: Use `#!/bin/bash`, `set -e`, proper error handling
5. **Compatibility**: Follow Agent Skills specification

### Categories

Use appropriate categories for skills:
- **development**: Coding, testing, debugging
- **deployment**: CI/CD, hosting, infrastructure
- **productivity**: Workflow automation, task management
- **testing**: Test generation, validation, QA
- **documentation**: Docs generation, API documentation
- **security**: Security scanning, vulnerability checks

## Development Setup

```bash
# Clone repository
git clone <repo-url>
cd skills

# Install dependencies (if any)
npm install

# Setup symlinks for local testing
npm run setup-symlinks
```

## Testing

```bash
# Validate all skills
npm run validate

# Test specific skill with skills CLI
npx skills add . --skill <skill-name> --list

# Test installation to specific agent
npx skills add . --skill <skill-name> -a opencode -y
```

## Code of Conduct

Be respectful and constructive in all contributions. Focus on improving the skills collection for all users.

## Questions?

Open an issue or start a discussion for any questions about contributing.