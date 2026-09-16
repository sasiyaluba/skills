# Finding Model

Use one Finding Model as the internal representation of the locked Finding Context. It is a completeness contract, not an output template.

## Shared context

```yaml
finding:
  audience_prerequisites: [<concepts a report reader may know before sentence one>]
  type: Security Issue | Recommendation | Note
  type_basis: <facts and decisions that distinguish this type>
  severity: <optional auditor-provided or rubric-derived metadata>
  subject: <specific affected component, role, mechanism, dependency, or behavior>
  thesis: <single conclusion the complete finding establishes>
  claims:
    - id: <stable claim id>
      statement: <one material semantic claim>
      status: grounded_fact | auditor_decision | derived_conclusion
      evidence: [<evidence ids supporting this claim>]
  relationships:
    - from: <claim, referent, state, or event>
      relation: prerequisite | condition | trigger | cause | result | contrast | parallel | elaboration | conclusion | scope | responsibility
      to: <claim, referent, state, or event>
  evidence:
    - id: <stable evidence id>
      source: repository | auditor | authoritative_source
      location: <repo-relative path and range, auditor instruction, or source URL and section>
      supports: [<claim ids>]
  unresolved_decisions: []
  code_locations:
    state: ranges | protocol_level | no_repository_location
    ranges: [<repo-relative closed ranges when state is ranges>]
  terminology:
    - term: <canonical prose term>
      meaning: <referent denoted in this finding>
      applies_to: <claim, entity, role, mechanism, or other concept>
      source: <project, dependency, authority, auditor decision, or ordinary technical language>
      boundary: <where the term does and does not apply>
      avoid: [<rejected alternatives already present in the input or draft>]
  payload: <exactly one type payload>
```

`audience_prerequisites` contains only knowledge the intended report reader can reasonably bring. Project-specific behavior, local identifiers, special assumptions, and finding-specific causal relations must be introduced by an accepted sentence before a later sentence relies on them.

A claim's status identifies its authority without constructing a provenance graph: `grounded_fact` is directly supported by repository behavior or a reviewed authoritative source; `auditor_decision` is an explicit classification, expectation, impact, severity, remediation, or project-position decision; and `derived_conclusion` necessarily follows from named facts and decisions.

Bind evidence to the exact claim it proves. File presence, a broad contract range, passing tests, or a list of links is not evidence for every nearby claim. Preserve exact identifiers, quantities, versions, chains, configurations, timing, and deployment scope.

Record relationships explicitly. Sentence order may express only relationships present in this map; adjacency alone never creates causation, contrast, sequence, or scope.

The context is locked only when `unresolved_decisions` is empty and the thesis follows from the complete selected payload. New evidence or a new auditor decision unlocks the context and invalidates every draft sentence whose claim, terminology, relation, condition, or boundary it changes.


## Type payloads

### Security Issue

```yaml
issue:
  expected_property: <property that should hold and its authority>
  deviation_or_root_cause: <direct established departure from that property>
  conditions: [<conditions that change reachability or consequence; empty only if none>]
  trigger: <actor, input, operation, state, or event>
  path: [<shortest complete ordered causal steps>]
  direct_result: <first relevant state, asset, permission, data, or control-flow change>
  impact: <one most severe realistic supported security consequence and its boundary>
  remediation_goal: <invariant or target behavior that removes the cause or restores the property>
```

### Recommendation

```yaml
recommendation:
  current_behavior: <established current behavior>
  gap: <specific difference from the supported target quality or behavior>
  rationale: <direct project-specific value of closing the gap>
  bounded_non_security_consequence: <optional distinct, observed or directly derivable consequence>
  remediation_goal: <verifiable target behavior that closes only this gap>
```

### Note

```yaml
note:
  accepted_context: <accepted design, trust, authority, dependency, or operating context>
  assumption: <specific condition on which correct or secure operation relies>
  responsibility: <optional party and duty, only when assigned by evidence>
  guarantees: <optional supported guarantees and/or explicit non-guarantees>
  consequence: <optional result bound to failure of the assumption>
  boundary: <applicable objects, roles, states, versions, environments, timing, or deployment>
  project_position: <accepted design or current project position supporting Note classification>
```

`project_position` may be an explicit auditor decision when the repository cannot establish acceptance. Preserve whether it is a current plan, scoped decision, design intent, or deployed fact.

## Impact and severity

For a Security Issue, choose one most severe **realistic** impact supported by the complete path. Record the affected party or object, concrete adverse result, necessary conditions, scope, certainty, and material duration or recoverability. A theoretical maximum without a reachable path is not impact. Do not fold root cause, attack steps, severity rationale, or remediation into the impact conclusion.

Severity is optional metadata and never selects the finding type. When severity is supplied or requested, assess it from the confirmed impact, exploitability or failure conditions, affected scope, duration, recoverability, and the project's controlling rubric. Preserve an auditor-provided rating as an auditor decision; if it materially conflicts with evidence, expose the conflict rather than silently altering facts. Derive a rating only when the rubric and grounded facts determine it. Otherwise ask for the single missing policy judgment. The finding body does not emit severity; return it separately only when the caller requests metadata.

A Recommendation may carry an optional bounded non-security consequence only when it is observable or directly derivable, scoped, distinct from the rationale, and not a security-property violation. A Note may carry a serious consequence only when it remains explicitly conditional on failure of its accepted assumption. Neither branch acquires severity merely because a consequence is present.

## Remediation

An issue remediation goal removes the root cause or restores the expected property across the established paths. A recommendation remediation goal closes the specific gap. Both state a verifiable post-change invariant, scope, and lifecycle point where needed.

Specify an implementation only when evidence or an auditor decision establishes it as the uniquely correct solution. Otherwise preserve implementation freedom. Exclude unrelated hardening, monitoring, migration, retries, tests, refactors, and architectural changes.

## Draft render interface

The semantic draft maps to the standard fields `Title`, `Description`, optional branch-permitted `Impact`, optional branch-permitted `Suggestion`, and `Code locations`:

- `Title` identifies the subject and the finding's distinguishing issue, improvement, or disclosed relationship without adding a claim.
- `Description` independently establishes the selected payload's required logic.
- `Impact` carries the Issue impact or a Recommendation's qualifying bounded non-security consequence; Notes do not use it.
- `Suggestion` carries the remediation goal for Issues and Recommendations; Notes do not use it.
- `Code locations` project `code_locations`: format supplied minimal ranges, or the explicit `protocol_level` / `no_repository_location` state. Grounding, not rendering, decides this state.

These are semantic responsibilities. Field labels, ordering, spacing, prose style, identifier presentation, and location formatting are defined only by the selected `finding-refiner` rendering contracts.

## Semantic integrity

Content and rendering may reorganize or rewrite expression, but preserve every material claim's:

```text
subject · predicate · object · polarity · conditions · scope · certainty
causal direction · impact · remediation · identifiers · evidence
```

Do not convert correlation into causation, a symptom into a root cause, a plan into a deployed fact, code silence into a guarantee, an example fix into the only solution, or an accepted assumption into a current defect. Keep separate paths when combining them would change a trigger, condition, causal mechanism, result, impact boundary, responsibility, or remediation goal.
