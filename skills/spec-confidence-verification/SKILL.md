---
name: spec-confidence-verification
description: Systematic deep-read verification protocol for specs, PRDs, and implementation plans — audits UI/UX integration points, database migrations, API routes, type interfaces, component wiring, design tokens, state management, and loading patterns to achieve 97%+ implementation confidence before execution
license: MIT
compatibility: opencode
metadata:
  audience: developers, architects, spec writers, AI agents
  category: verification
  tags: spec, confidence, audit, ui, ux, database, routes, wiring, verification, architecture
---

# Spec Confidence Verification

Systematic deep-read verification protocol that audits every integration point in a spec, PRD, or implementation plan before execution. Produces a per-story confidence score and identifies every file, interface, line number, and pattern that the implementation will touch — ensuring nothing breaks, disappears, or regresses.

## When to use me

Use this skill when:
- A spec or PRD has been written and needs verification before execution
- You need 95%+ confidence that implementation won't break existing functionality
- A feature touches multiple files, components, routes, and database tables
- You're adding UI elements to existing panels, action bars, or tab systems
- Database schema changes (migrations, column additions) are part of the plan
- New API endpoints need to wire into existing route patterns
- Component interfaces need extension without breaking existing consumers
- You need to verify icon imports, type propagation, and design token compliance
- Loading, error, and empty states must match established patterns
- Real-time systems (SSE, WebSocket, WAL events) need correct event wiring

## What I do

### Phase 1: Spec Structural Validation

Before auditing integration points, validate the spec itself is internally consistent.

**1.1 Dependency Graph Integrity**
```
For every story in the spec:
  1. Parse dependsOn array
  2. Verify every dependency target exists as a story ID in the same spec
  3. Check for circular dependencies (DFS cycle detection)
  4. Verify wave ordering: no story depends on a story in a later wave
  5. Flag orphaned stories (no dependsOn AND nothing depends on them — intentional?)
```

**1.2 Acceptance Criteria Quality**
```
For every acceptance criterion:
  1. Does it reference a specific file path? (GOOD — verifiable)
  2. Does it reference a specific function or component name? (GOOD — grep-able)
  3. Does it specify exact CSS classes or design tokens? (GOOD — diff-able)
  4. Does it describe behavior without referencing implementation? (WARN — ambiguous)
  5. Does it use vague terms like "appropriate", "nice", "clean"? (BAD — subjective)
```

**1.3 File Reference Verification**
```
For every file path mentioned in the spec:
  1. Does the file exist at that path? (glob check)
  2. Is the filename correct? (common: UsagePanel.tsx vs UsageDashboardPanel.tsx)
  3. Do the referenced line numbers match the current file? (files shift over time)
  4. Are interface/type names correct and at the stated locations?
```

### Phase 2: UI/UX Integration Audit

The most common source of spec errors. Components have specific structures, and inserting new elements in the wrong location causes visual regression.

**2.1 Component Interface Verification**
```
For every React component the spec modifies:
  1. Read the FULL component file (not just the area being modified)
  2. Document the component's props interface — every field, its type, optionality
  3. Document the component's state variables — useState declarations
  4. Document the component's context dependencies — useContext, useWorkspace, etc.
  5. Identify the component's render structure — what JSX sections exist
  6. Map the component's event handlers — onClick, onChange, onSubmit, etc.
  7. Check if the component is exported as default or named
  8. Check if other components import this component — ripple effects
```

**2.2 Action Bar & Button Layout Mapping**
```
For every action bar or button group the spec adds buttons to:
  1. Read the exact JSX structure of the action bar
  2. Document the grouping: LEFT group vs RIGHT group (often separated by ml-auto)
  3. Document each existing button: label, icon, onClick handler, disabled conditions
  4. Document the styling pattern: className for primary, secondary, destructive buttons
  5. Identify the correct insertion point: after which button, inside which div
  6. Check for conditional rendering: isPending, isApproved, isArchived gates
  7. Verify the new button's style matches the group it's joining
```

Example action bar audit:
```
Action Bar Structure:
  LEFT group (div.flex.items-center.gap-2):
    [Edit]   — Pencil icon, secondary style, onClick=handleEdit
    [Delete] — Trash2 icon, secondary style, onClick=handleDelete, disabled=deleteLoading
    >>> INSERT NEW BUTTONS HERE (after Delete, before closing </div>)

  RIGHT group (div.flex.items-center.gap-2.ml-auto):
    [Run Pipeline] — Play icon, primary style, onClick=handleRunPipeline
    [Approve]      — CheckCircle2 icon, success style, conditional: isPending
    [Reject]       — XCircle icon, destructive style, conditional: isPending
```

**2.3 Tab System Verification**
```
For every tab system the spec adds tabs to:
  1. Find the tab type union: type XTab = 'a' | 'b' | 'c'
  2. Find the TABS array constant with { id, label, icon } entries
  3. Document the exact position for the new tab (between which existing tabs)
  4. Check the tab bar rendering: styling for active vs inactive tabs
  5. Check the renderTabContent() switch statement for the case mapping
  6. Check if the tab's icon is imported (COMMON MISS: icons not in import statement)
  7. Check mobile responsiveness: are any tabs hidden on mobile? (visibleTabs filter)
  8. Check if walEvents, runId, or other props are passed to tab content components
```

**2.4 Icon Import Verification**
```
For every lucide-react icon referenced in the spec:
  1. Read the target file's import block (usually lines 1-20)
  2. List ALL currently imported icons
  3. Check if the spec's icon is already imported
  4. If NOT imported, flag as PREREQUISITE in the acceptance criteria
  5. Verify the icon name is correct (lucide uses PascalCase: Wrench, not wrench)
  6. Common misses: Wrench, Layers, RefreshCw, FileText, GitFork, Star, Download
```

**2.5 Type Interface Propagation**
```
For every type/interface the spec extends:
  1. Find ALL files that import this type (grep for import.*TypeName)
  2. Check if the type is exported (export interface vs local interface)
  3. If exported: every consumer gets the new fields automatically (GOOD)
  4. If local (defined in the same file): only that file needs updating
  5. Check for DUPLICATE interfaces: same name defined in multiple files
     Example: Story interface in StoryCard.tsx vs Story interface in SpecReviewPanel.tsx
     These are DIFFERENT types — both need updating independently
  6. Check if the new fields are optional (?) — if not, every usage site must provide them
  7. Check for generic types: GeneratedSpec<Story[]> — extending Story propagates through
```

Common type propagation pattern:
```
StoryCard.tsx:     export interface Story { ... }           ← Source of truth
SpecForgePreview:  import { Story } from './StoryCard'      ← Auto-propagates
SpecReviewPanel:   interface Story { ... }                  ← LOCAL duplicate, must update separately
SpecForgeOutput:   import { Story } from '../components/StoryCard' ← Auto-propagates
```

**2.6 Design Token Compliance**
```
Verify all CSS classes in the spec match the project's design system:
  1. Background colors: bg-bg, bg-panel, bg-accent, bg-accent/10, bg-accent/15, bg-accent/20
  2. Text colors: text-text, text-muted, text-accent, text-error, text-success, text-warning
  3. Border colors: border-border, border-border/50, border-accent, border-accent/30
  4. Status semantics:
     - Success: bg-emerald-500/10 text-emerald-500 (or bg-success/15 text-success)
     - Error: bg-red-500/10 text-red-400 (or bg-error/10 text-error)
     - Warning: bg-amber-500/10 text-amber-500 (or bg-warning/15 text-warning)
     - Info: bg-blue-500/10 text-blue-500
     - Accent: bg-accent/15 text-accent
  5. Font sizes: text-xs (12px), text-sm (14px), text-[10px], text-[11px], text-2xl
  6. Font weights: font-medium, font-semibold, font-bold, font-mono
  7. Spacing: gap-2, gap-3, gap-4, p-3, p-4, px-3, py-2, space-y-2, space-y-4
  8. Badge pattern: px-1.5 py-0.5 text-[10px] font-mono font-semibold rounded
  9. Card pattern: border rounded-lg bg-panel
  10. Transition: transition-colors (standard), transition-all (when size changes)
```

**2.7 Loading / Error / Empty State Pattern Verification**
```
For every new component or data-fetching view:
  1. LOADING state:
     - Skeleton pattern: import { SkeletonLine } from '../components/Skeleton'
     - Spinner pattern: <Loader2 size={16} className="animate-spin" />
     - Text: descriptive, e.g., "Loading skill data..." in text-muted text-sm
     - Centered: flex-1 flex items-center justify-center

  2. ERROR state:
     - Message: text-red-400 text-sm
     - Retry button: text-accent hover:underline or RefreshCw icon button
     - Error clears on retry

  3. EMPTY state:
     - Icon: relevant icon at size=32, opacity-30
     - Heading: text-sm font-medium text-muted
     - Subtext: text-xs text-muted, actionable guidance
     - CTA button: optional, links to relevant setup panel
     - NO retry button (empty is permanent, not transient)

  4. Fetch pattern:
     - useCallback for fetch function (stable reference)
     - useEffect with dependency on [fetchFn] or [runId]
     - apiFetch<T>(url): Promise<T> — generic typing
     - try/catch: set error state on catch, clear loading in finally
     - State: useState<T | null>(null), useState(true) for loading, useState<string | null>(null) for error
```

### Phase 3: Database & Migration Audit

**3.1 Column Addition Pattern (SQLite)**
```
SQLite does not support ADD COLUMN IF NOT EXISTS.
The correct pattern (verify in db/index.ts or equivalent):

  const cols = db.pragma('table_info(table_name)') as Array<{ name: string }>;
  if (!cols.some(c => c.name === 'new_column')) {
    db.exec('ALTER TABLE table_name ADD COLUMN new_column TEXT');
  }

DO NOT use a migration file for column additions — the pragma check is idempotent.
Migration files are for new tables, indexes, and complex schema changes.
```

**3.2 Table Verification**
```
For every database table the spec references:
  1. Read the CREATE TABLE statement (in migrations/ or db/index.ts)
  2. List ALL existing columns with types
  3. Check if referenced columns actually exist
  4. Check column types: TEXT, INTEGER, REAL, BLOB
  5. Check constraints: NOT NULL, DEFAULT, UNIQUE, FOREIGN KEY
  6. Check indexes: which columns are indexed
  7. If adding columns: verify the default value won't break existing rows
```

**3.3 JSON Column Handling**
```
For columns storing JSON (e.g., active_skills TEXT containing '["react","testing"]'):
  1. Verify the column type is TEXT (SQLite has no native JSON type)
  2. Check if json_each() is available (SQLite 3.40+ — better-sqlite3 bundles this)
  3. Document the JSON schema stored in the column
  4. Check if existing code parses with JSON.parse() or uses json_each() in SQL
  5. If querying JSON contents, prefer json_each() for performance over JS-side parsing
```

### Phase 4: API Route Wiring Audit

**4.1 Route Pattern Verification**
```
For every new API endpoint in the spec:
  1. Identify the target route file (e.g., backend/src/routes/skills.ts)
  2. Verify the Router() pattern: const router = Router(); export default router;
  3. Check how the router is mounted in server.ts: app.use('/api/skills', skillsRouter)
  4. Verify the path prefix: if mounted at /api/skills, routes define sub-paths only
  5. Check for existing middleware: auth, rate limiting, validation
  6. Verify the response pattern: res.json({ ... }) with consistent shape
  7. Check for @swagger JSDoc annotations on existing routes (are they required?)
  8. Verify error handling: AppError hierarchy (ValidationError, NotFoundError, etc.)
```

**4.2 Request/Response Shape Consistency**
```
For every new endpoint:
  1. Document the request body/query params with types
  2. Document the response shape with types
  3. Check for consistency with existing endpoints:
     - Pagination: { items, total, page, pageSize } via paginate() helper
     - Success: { ok: true } or the data directly
     - Error: { error: string, code?: string, details?: unknown }
     - Created: status 201, not 200
     - Not found: status 404, not 400
  4. Check if the endpoint returns data that matches a frontend TypeScript interface
  5. Verify the frontend apiFetch<T>() call uses the correct generic type
```

**4.3 WAL Event Emission Pattern**
```
For every spec that emits WAL events:
  1. Verify the import: import { broadcastAll, type WalEvent } from '../lib/sse-hub'
  2. Verify the emit pattern (3-step):
     a. INSERT: db.prepare('INSERT INTO wal_events (event_type, workspace_id, payload) VALUES (?, ?, ?)').run(type, wsId, JSON.stringify(payload))
     b. FETCH: db.prepare('SELECT * FROM wal_events WHERE rowid = ?').get(result.lastInsertRowid)
     c. BROADCAST: broadcastAll(walEvent)
  3. Verify the event_type follows naming convention: snake_case, domain-prefixed
  4. Verify the payload includes workspace_id (for SSE filtering)
  5. Check that wal_events.ts column is 'ts' NOT 'created_at'
  6. Check if the SSE stream query filters by this event_type correctly
  7. Verify the frontend SSE hook handles the new event_type
```

### Phase 5: Frontend State & Context Wiring

**5.1 Context Threading Verification**
```
For every component that needs data from a parent:
  1. Check if the component uses context hooks (useWorkspace, useAuth, useTheme, etc.)
  2. If the component needs NEW data: does it come via props or context?
  3. If via props: trace the prop from the usage site up through every parent
  4. If via context: verify the context provider wraps this component in the tree
  5. Check for prop drilling depth: if > 3 levels, suggest context or composition
  6. Verify optional props have sensible defaults (not just undefined)
```

**5.2 localStorage Pattern Compliance**
```
For every new persistent UI preference:
  1. Key naming: 'appname:section:settingName' (e.g., 'rorca:forge:autoMatchSkills')
  2. Read pattern: try { return localStorage.getItem(key) ?? default; } catch { return default; }
  3. Write pattern: try { localStorage.setItem(key, value); } catch { /* quota error */ }
  4. Initialization: useState(() => { try { ... } catch { return default; } })
  5. Never store sensitive data in localStorage
  6. For booleans: store 'true'/'false' strings, parse with === 'true'
  7. For numbers: store string, parse with parseInt/parseFloat with validation
```

**5.3 Real-Time Update Wiring (SSE/WebSocket)**
```
For every component that shows real-time data:
  1. Check if the component receives walEvents/events prop from parent
  2. Check if the parent subscribes via usePipelineSSE() or similar hook
  3. Check the event filtering: which event_types does this component care about?
  4. Check the merge strategy: how do real-time events merge with initial fetch data?
     - Dedup by ID (storyId, skillName, etc.)
     - Overlay: new data overrides old, preserving fields not in the update
     - Append: new events added to list, old events unchanged
  5. Check the reactivity: useMemo over merged data, or useEffect for state updates?
  6. Check degradation: if walEvents is undefined/empty, component works with static data
  7. Check for memory leaks: does the component clean up subscriptions on unmount?
```

### Phase 6: Cross-Cutting Concerns

**6.1 Modal Pattern Verification**
```
For every modal/dialog in the spec:
  1. Check for existing modal components: AnimatedModal, SpecConfirmDialog, etc.
  2. Verify the modal pattern:
     - Backdrop: fixed inset-0 z-40 bg-black/50
     - Content: fixed inset-0 z-50 flex items-center justify-center
     - Close: onClick backdrop, ESC key, X button in top-right
     - Animation: framer-motion with scaleIn variant (if AnimatedModal used)
  3. If using AnimatedModal: import { AnimatedModal } from '../components/AnimatedModal'
     Props: { isOpen, onClose, children, className?, closeOnBackdropClick? }
  4. Verify z-index stacking: modal z-50 must be above any sticky headers (z-30)
  5. Check body scroll lock: does the modal prevent background scrolling?
```

**6.2 Toast Notification Pattern**
```
For every user-facing action:
  1. Success: show({ type: 'success', message: 'Action completed' })
  2. Error: show({ type: 'error', message: 'Action failed: {error.message}' })
  3. Warning: show({ type: 'warning', message: 'Partial success' })
  4. Import: const { show } = useGlobalToast()  — or — const showToast = useGlobalToast()
  5. Toast is the ONLY feedback for fire-and-forget actions
  6. For actions that need user input (accept/deny), use a modal, not a toast
  7. Toast message should describe what happened, not what to do next
```

**6.3 Mobile Responsiveness Check**
```
For every new UI element:
  1. Grid layouts: grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 (mobile-first)
  2. Flex wrap: flex-wrap on badge/tag containers
  3. Hidden elements: certain tabs/charts hidden on mobile (hidden sm:flex)
  4. Stack direction: flex-col on mobile, flex-row on desktop (flex-col sm:flex-row)
  5. Touch targets: minimum 44px height for interactive elements (py-2.5 minimum)
  6. Text truncation: truncate on titles, line-clamp-2 on descriptions
  7. Overflow: overflow-x-auto on tables and wide content
```

**6.4 Accessibility Baseline**
```
For every new interactive element:
  1. Buttons: always have text content or aria-label
  2. Inputs: always have associated label (htmlFor) or aria-label
  3. Toggle switches: role="switch" + aria-checked attribute
  4. Expandable sections: aria-expanded on the trigger button
  5. Modals: focus trap (AnimatedModal handles this via framer-motion)
  6. Icons-only buttons: title attribute for tooltip
  7. Color: never use color alone to convey meaning (add text/icon alongside)
```

### Phase 7: Confidence Scoring

After completing all phases, produce a confidence score per story and overall.

**7.1 Per-Story Scoring**
```
For each story, score 0-100 across these dimensions:
  - File paths verified: +20 (all referenced files exist and have correct names)
  - Interfaces verified: +20 (all types/interfaces inspected, fields confirmed)
  - Insertion points verified: +20 (exact line numbers, surrounding code confirmed)
  - Patterns matched: +20 (loading/error/empty states, styling, fetch patterns)
  - Edge cases covered: +10 (mobile, empty data, error handling, disabled states)
  - Dependencies verified: +10 (all dependsOn stories exist, provide required data)
```

**7.2 Overall Confidence Thresholds**
```
97-100%: Ship with high confidence. All integration points verified with line numbers.
90-96%:  Ship with caution. Most verified, but some assumptions unconfirmed.
80-89%:  Needs more verification. Key integration points unverified.
< 80%:   Do not ship. Re-audit required. Significant unknowns remain.
```

**7.3 Confidence Report Template**
```markdown
## Confidence Report — {Spec Name}

| Story | File Paths | Interfaces | Insertion | Patterns | Edge Cases | Deps | Total |
|-------|-----------|-----------|-----------|----------|-----------|------|-------|
| SL-001 | 20/20 | 20/20 | 18/20 | 20/20 | 8/10 | 10/10 | 96% |
| SL-002 | 20/20 | 20/20 | 20/20 | 20/20 | 10/10 | 10/10 | 100% |
| ... | | | | | | | |

### Verified Artifacts
- [ ] All file paths exist (N/N confirmed)
- [ ] All type interfaces read and fields confirmed
- [ ] All action bars / tab arrays mapped with line numbers
- [ ] All icon imports verified (present or flagged as prerequisite)
- [ ] All database tables and columns confirmed
- [ ] All API route patterns match existing codebase conventions
- [ ] All loading/error/empty states follow established patterns
- [ ] All design tokens match CSS variable definitions
- [ ] Dependency graph validated (zero broken deps)
- [ ] JSON validity confirmed (parseable, well-formed)

### Corrections Applied
1. {Description of correction} — {file} line {N}
2. ...

### Remaining Risks
1. {Description of risk} — {mitigation strategy}
2. ...
```

## Output Format

When invoked, produce:

1. **Phase-by-phase audit results** with specific findings per file
2. **Corrections list** — every spec error found and fixed
3. **Confidence score table** — per-story breakdown
4. **Verified artifacts checklist** — what was confirmed
5. **Remaining risks** — what couldn't be verified and why

## Examples

### Example: Verifying a UI tab addition

```
TASK: Spec says "Add 'Skills' tab to RunViewPanel between Graph and FinOps"

VERIFICATION STEPS:
1. Read RunViewPanel.tsx → find RunViewTab type at line 72
   FOUND: type RunViewTab = 'terminal' | 'stories' | 'graph' | 'finops' | ...
   ✓ Need to add 'skills' between 'graph' and 'finops'

2. Read TABS array at lines 74-82
   FOUND: 7 entries, graph at index 2, finops at index 3
   ✓ Skills goes at index 3, shifting finops to 4

3. Check icon imports at line 1
   FOUND: Terminal, List, GitBranch, DollarSign, GitCompare, FolderTree, GitCommit
   ✗ Wrench NOT imported — PREREQUISITE needed

4. Check renderTabContent() switch statement
   FOUND: cases for all 7 existing tabs
   ✓ Need to add case 'skills': return <SkillsTab runId={run.id} />

5. Check if walEvents prop is passed to tab content
   FOUND: walEvents passed to terminal, stories, compare — NOT to finops, commits
   ✓ SkillsTab may need walEvents for real-time (Story SL-011)

CONFIDENCE: 98% — all integration points verified
CORRECTION: Added "Import Wrench from lucide-react" as prerequisite
```

### Example: Verifying a database column addition

```
TASK: Spec says "Add 'category' and 'tags' columns to installed_skills table"

VERIFICATION STEPS:
1. Read db/index.ts → find installed_skills schema
   FOUND: CREATE TABLE installed_skills (id, name, description, source, content, installed_at, updated_at)
   ✓ No category or tags columns exist

2. Check column addition pattern
   FOUND: pragma table_info pattern used for other tables
   ✓ Spec correctly uses pragma check, NOT migration file

3. Check SkillRegistry interface
   FOUND: Skill { metadata: { name, description }, promptText, filePath, source }
   ✗ No category or tags in Skill interface — spec must extend it

4. Check API response shape
   FOUND: GET /api/skills returns { name, description, source, content, ... }
   ✓ Response needs category and tags added

CONFIDENCE: 97% — column pattern verified, interface gap flagged
CORRECTION: Added "Extend Skill interface metadata" to acceptance criteria
```

### Example: Verifying an action bar button addition

```
TASK: Spec says "Add 'Match Skills' button to spec review action bar"

VERIFICATION STEPS:
1. Read SpecReviewPanel.tsx → find action bar at lines 1023-1114
   FOUND: LEFT group (Edit, Delete), RIGHT group (Run Pipeline, Approve, Reject)
   ✓ Button goes in LEFT group, after Delete

2. Check styling pattern
   FOUND: Edit button: 'flex items-center gap-1.5 px-3 py-2 rounded-lg text-sm font-medium text-muted border border-border hover:text-text hover:border-accent/40 transition-colors'
   ✓ Spec matches this pattern for new button

3. Check icon import
   FOUND: Wrench NOT in import statement (lines 1-18)
   ✗ PREREQUISITE: add Wrench to lucide-react import

4. Check disabled conditions
   FOUND: Other buttons check actionLoading !== null
   ✓ Spec defines independent disabled conditions (matching in progress)

5. Check Story interface for suggestedSkills field
   FOUND: Local Story interface at line 29 — NO suggestedSkills field
   ✗ PREREQUISITE: extend Story interface with suggestedSkills

CONFIDENCE: 97% — two prerequisites identified and flagged
CORRECTIONS:
  - Added "PREREQUISITE — Add Wrench to lucide-react import"
  - Added "PREREQUISITE — Extend Story interface with suggestedSkills"
```

## Anti-Patterns to Detect

### 1. Ghost File References
```
BAD:  "Modify src/panels/SpecForgePanelPage.tsx"  ← File doesn't exist
GOOD: "Modify src/panels/SpecsPanel.tsx"           ← Verified to exist
```
Always glob for the referenced filename. Common causes: renamed files, old documentation, hallucinated paths.

### 2. Interface Assumption
```
BAD:  "The Story interface already has suggestedSkills"  ← Not verified
GOOD: "Story interface at StoryCard.tsx line 8 does NOT have suggestedSkills — must be added"
```
Always read the actual interface definition. Never assume a field exists.

### 3. Icon Availability Assumption
```
BAD:  "Use Layers icon (already imported)"      ← Not checked
GOOD: "Import Layers from lucide-react (NOT currently imported — verified line 1-18)"
```
Always read the import block. Icons are frequently missing.

### 4. Stale Line Numbers
```
BAD:  "Action bar at line 580"                  ← May have shifted
GOOD: "Action bar at lines 1023-1114 (grep for 'Action bar' comment)"
```
Line numbers shift as files are edited. Include searchable anchors (comments, function names).

### 5. Wrong Panel/Component Reference
```
BAD:  "Add to UsagePanel.tsx"                   ← File is actually UsageDashboardPanel.tsx
GOOD: "Add to src/panels/UsageDashboardPanel.tsx (verified filename via glob)"
```
Always verify filenames with glob. Panels are frequently renamed.

### 6. Missing Context Threading
```
BAD:  "MarketplaceView shows the active spec's skills"  ← Component has no spec context
GOOD: "MarketplaceView receives NO props (verified). Add activeSpecId? prop and thread from parent."
```
Always check what props a component receives. Don't assume context is available.

### 7. Duplicate Interface Oversight
```
BAD:  "Extend Story interface"                  ← Which one? There are 3 files with Story interface
GOOD: "Extend Story in StoryCard.tsx (exported, propagates to consumers) AND
       Story in SpecReviewPanel.tsx (local, must update separately)"
```
grep for the interface name across the entire codebase. Fix ALL instances.

## Verification Depth Guidelines

### Quick Verification (< 30 minutes)
- File existence check (glob)
- Interface field check (grep + read)
- Import check (read first 20 lines)
- Route pattern check (grep for router methods)

### Standard Verification (30-60 minutes)
- All quick checks plus:
- Full component read (render structure, state, handlers)
- Action bar / tab array mapping with line numbers
- Database schema verification
- Design token compliance spot-check

### Deep Verification (60-120 minutes)
- All standard checks plus:
- Every acceptance criterion verified against actual code
- Prop threading traced through component tree
- Loading/error/empty state pattern comparison
- WAL event emission and subscription wiring
- Mobile responsiveness audit
- Confidence score per story with justification

## Integration with Spec Generation

This skill is most effective when run AFTER spec generation but BEFORE execution:

```
Brief → Spec Generation → [THIS SKILL] → Corrections → Approval → Pipeline Run
                              ↑                              ↓
                         Deep-read audit              Spec JSON updated
                         per file/component           with verified details
```

The output of this skill should be:
1. An updated spec JSON with all corrections applied
2. A confidence report documenting what was verified
3. A list of prerequisites (interface extensions, icon imports, etc.)
4. A risk assessment for anything that couldn't be verified

## Checklist Summary

Before marking verification complete, confirm ALL of the following:

```
[ ] Every file path in the spec exists (globbed)
[ ] Every component interface has been read (not assumed)
[ ] Every action bar / tab system has been mapped with line numbers
[ ] Every icon import has been verified (present or flagged)
[ ] Every database table and column has been confirmed
[ ] Every API route follows existing patterns (router, middleware, response shape)
[ ] Every loading/error/empty state matches established patterns
[ ] Every design token matches the CSS variable system
[ ] Every type interface extension accounts for all consumers (grep for imports)
[ ] The dependency graph has zero broken references
[ ] The spec JSON is valid (parseable, well-formed)
[ ] A confidence score per story has been computed
[ ] All corrections have been applied to the spec
[ ] All prerequisites are documented in acceptance criteria
[ ] Zero visual regressions are expected (existing UI unchanged where not modified)
```
