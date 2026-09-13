---
name: finding-polisher
description: Use when an auditor wants to standardize or polish an existing Security Issue, Recommendation, or Note, including revising it from explicit auditor feedback without repository grounding.
---

# Finding Polisher

Convert a Finding in any structure into a polished, report-ready standard Finding. The skill can also revise an existing Finding according to explicit auditor feedback. The module's only external Interface is:

```text
finding content in any format + confirmed finding type + optional auditor revision instructions -> standardized finding reflecting the latest explicit auditor decisions
```

The input does not need to use any fields, ordering, template, or markup, and the output does not preserve its presentation structure. This workflow does not investigate the repository, reclassify the Finding, or assess Impact or Severity. The original Finding supplies the baseline semantics, explicit revision instructions override only the content they directly target, the resolved effective semantics determine the output, and the selected branch determines the standard output structure.

## References

| Stage | Reference | Read when |
| --- | --- | --- |
| Terminology discovery | `skill://finding-writer/references/terminology-discovery.md` | Every Finding |
| Security Issue drafting | `skill://finding-writer/references/issue-drafting.md` | Security Issue only |
| Recommendation drafting | `skill://finding-writer/references/recommendation-drafting.md` | Recommendation only |
| Note drafting | `skill://finding-writer/references/note-drafting.md` | Note only |
| Final optimization | `skill://finding-writer/references/hard-rules.md` | Every complete Draft |

Read only the reference required by the current stage and confirmed Finding Type. Do not read finding grounding, impact assessment, or an unselected drafting branch.

## Authority

- The original Finding determines all substantive content not overridden by revision instructions, but it does not determine output fields, ordering, or formatting.
- The auditor's latest explicit revision instruction takes precedence over the original Finding content it directly targets. Untargeted content remains locked.
- The single Finding Type confirmed by the auditor determines the selected drafting branch. A latest explicit instruction that changes the type also constitutes confirmation of the new type.
- The `Content Lock` records the original semantics, revision instructions, supersession relationships, and final effective semantics. Its `semantic_units` are the only Authoritative Content Set for downstream stages.
- The `Terminology Brief` determines only more accurate professional terminology and its applicability boundaries.
- The selected drafting reference determines how locked content is assigned to standard fields, including field responsibilities, proportions, ordering, and formatting.
- `hard-rules.md` determines the final shared formatting and expression rules.

A lower-priority rule must not change higher-priority content. A revision instruction supplies only the change it explicitly expresses; it does not authorize the agent to derive new facts, Impact, Severity, remediation, or Evidence. Stop and return `POLISH_BLOCKED` when the resolved effective semantics are incompatible with the confirmed type, lack substantive content required by the selected branch, or contain an ambiguity or contradiction that cannot be resolved without semantic loss. Do not investigate, reclassify, weaken the original conclusion, or guess the user's intent.

## Workflow

At the start of the workflow, create a prefix unique to this Finding and use harness-provided `local://` shared temporary storage that child agents can read, such as `local://finding-polisher-<unique-id>-content.yaml`. Reuse the same prefix for every stage. Clean up only files created by this workflow under that prefix.

### 1. Validate the input

The input must contain:

- an original Finding with enough substantive content to form the corresponding standard Finding; it may be prose, a list, a table, an old template, mixed fields, or another structure;
- one Finding Type confirmed by the auditor: `Security Issue`, `Recommendation`, or `Note`; confirmation may appear in the original request or the latest explicit revision instruction;
- optional revision instructions, which may be itemized feedback, natural-language directions, replacement passages, or located additions, replacements, and removals.

Do not block merely because the input lacks standard field labels, uses a different field order, scatters one meaning across multiple locations, expresses revision instructions without a schema, or includes an extra presentation wrapper. Normalize the original Finding and revision instructions by semantic role before the selected branch produces the standard structure.

If neither the request nor the revision instructions unambiguously confirm a Finding Type, ask only for the type; do not classify it. If the input lacks substantive semantics required by the branch contract and completing them would require repository investigation, Impact assessment, or a new audit judgment, return only:

```text
POLISH_BLOCKED: <specific missing or contradictory semantics>
```

Do not access the repository to verify the original Finding or revision instructions, and do not escalate a standardization or revision request into the full finding-writing workflow.

### 2. Resolve revision instructions

When no revision instructions exist, pass all substantive semantics from the original Finding to the next stage. When revision instructions exist, parse them in occurrence order into `add`, `replace`, or `remove` operations against the Finding's semantics, then compute the final effective semantics.

Treat feedback as a revision instruction only when the user has confirmed that it should modify the Finding. Imperative change requests and suggestions under an explicit direction such as "revise the Finding according to the following feedback" are confirmed. Discussion, alternatives, and questions are not modification decisions. Every operation must have one unambiguous target and one unambiguous result:

- `add` must supply the complete substantive semantics to add and where they relate to the retained content.
- `replace` must uniquely identify both the content being replaced and the replacement semantics.
- `remove` must uniquely identify the substantive claim to remove without implicitly deleting conditions, causal nodes, or boundaries required by retained claims.
- Apply multiple confirmed instructions concerning the same content in occurrence order. A later explicit instruction overrides an earlier one.
- An instruction overrides only its direct target. Preserve every untargeted original semantic unit.
- Explicitly supplied new facts, Impact, remediation, Evidence, or other substantive content may enter the effective semantics. Do not expand them into conclusions the user did not express or recast an auditor revision as project confirmation.
- When the user explicitly and unambiguously changes the Finding Type, use the new type. Merely questioning, comparing, or suggesting consideration of another type leaves the type unconfirmed.

Requests such as "make it more severe," "add more impact," "make the suggestion specific," or "revise it according to best practices" do not supply unique new semantics and do not authorize the agent to complete them. If a target is unclear, a revision has multiple substantive interpretations, a removal leaves retained content without a unique meaning, or the complete instruction set remains contradictory, return only:

```text
POLISH_BLOCKED: revision instruction <R-id or verbatim fragment> is ambiguous or conflicts with <specific semantic unit>
```

Completion criteria: every confirmed revision instruction has been applied exactly once and is traceable; every untargeted semantic unit retains its original meaning; and the result has exactly one Finding Type and one internally consistent set of effective semantics.

### 3. Build the Content Lock

Read the entire original Finding and every resolved revision instruction, then build a format-independent, lossless `Content Lock`. Titles, field labels, paragraphs, lists, tables, surrounding explanations, and original ordering locate source content but do not constrain the output. Record at least:

```yaml
content_lock:
  finding_type: <latest confirmed type>
  source_content: |-
    <verbatim input finding>
  revision_content: |-
    <verbatim revision instructions or none>
  source_semantic_units:
    - id: S1
      subject: <subject>
      predicate: <predicate>
      object: <object>
      polarity: <positive | negative>
      condition: <condition or none>
      modality: <certainty or capability>
      scope: <affected boundary>
      causal_role: <context | expected property | deviation | trigger | cause | result | impact | remediation | disclosure | evidence>
      source_span: <verbatim fragment or unambiguous location in source_content>
  revision_instructions:
    - id: R1
      operation: <add | replace | remove>
      targets: [<source or prior revision semantic unit ids>]
      supplied_semantics: <explicit replacement or addition, or none for remove>
      source_span: <verbatim fragment or unambiguous location in revision_content>
  superseded_units:
    - unit: <semantic unit id>
      superseded_by: <revision instruction id>
  semantic_units:
    - id: E1
      provenance: [<source semantic unit or revision instruction ids>]
      subject: <subject>
      predicate: <predicate>
      object: <object>
      polarity: <positive | negative>
      condition: <condition or none>
      modality: <certainty or capability>
      scope: <affected boundary>
      causal_role: <context | expected property | deviation | trigger | cause | result | impact | remediation | disclosure | evidence>
  immutable_relations:
    - from: <effective semantic unit id>
      relation: <ordering | causality | contrast | dependency | responsibility | boundary>
      to: <effective semantic unit id>
  identifiers:
    - value: <effective exact project identifier>
      semantic_type: <type if stated>
      provenance: [<source semantic unit or revision instruction ids>]
  evidence_locations:
    - value: <effective verbatim path and range if present>
      supports: [<effective semantic unit ids>]
      provenance: [<source semantic unit or revision instruction ids>]
  auditor_decisions:
    - <explicit decision present in the request>
```

`source_semantic_units` only decomposes the original Finding. `revision_instructions` only decomposes explicit modifications. `semantic_units` is the sole effective semantic set after applying every modification in order. Terminology, drafting, and optimization may derive Finding prose only from `semantic_units`, their `immutable_relations`, effective identifiers, and effective Evidence. Use provenance to verify that every change originates in either the original Finding or an explicit revision instruction.

The `Content Lock` must preserve the following dimensions of the effective semantics:

- every substantive claim and its negation;
- actors, objects, responsible parties, and affected parties;
- conditions, triggers, ordering, causal direction, and path boundaries;
- the object, scope, certainty, duration, and recoverability of Impact;
- the remediation objective and any implementation freedom retained by the input;
- project identifiers, values, versions, chains, configurations, and deployment conditions;
- every supplied Evidence location and range, and the claims it supports.

Do not treat original field placement, field names, paragraph order, repeated presentation, or wrapper text as substantive semantics. Record a fully duplicated effective claim only once while retaining all provenance. If the effective content still permits multiple interpretations that would change substantive meaning, return `POLISH_BLOCKED`. Write the complete `Content Lock` to the uniquely named temporary file.

### 4. Discover terminology

Read and execute `skill://finding-writer/references/terminology-discovery.md` in full. Use the original Finding, revision instructions, and `Content Lock` in place of the raw finding, `Fact Brief`, and optional `Impact Brief`:

- Read at least 20 distinct sources as required by that reference.
- Research only accurate terminology for concepts already present in the effective `Content Lock`.
- Do not use terminology research to add facts, mechanisms, consequences, conditions, or remediation.
- Retain clear ordinary technical language when no exact term exists.

Write the complete `Terminology Brief` to the uniquely named temporary file.

### 5. Redraft in the confirmed branch

Read only the drafting reference corresponding to the confirmed Finding Type:

| Finding Type | Drafting reference |
| --- | --- |
| Security Issue | `skill://finding-writer/references/issue-drafting.md` |
| Recommendation | `skill://finding-writer/references/recommendation-drafting.md` |
| Note | `skill://finding-writer/references/note-drafting.md` |

Use the `Content Lock` in place of the `Fact Brief` and optional `Impact Brief` required by the drafting reference, together with the `Terminology Brief`. First build the selected branch's internal Map, then assign every effective semantic unit to the standard field responsible for it. The input's field names, ordering, and formatting do not define the output contract. The final output must use the standard fields, responsibilities, ordering, and layout of the selected branch.

Drafting may reorganize, split, or combine sentences; move content to the field with the correct responsibility; remove presentation wrappers and exact duplication; and adopt verified terminology. These operations must not add, remove, merge, split, or reinterpret effective substantive claims. Every substantive output claim must be semantically equivalent to and traceable to a `Content Lock.semantic_units` entry.

Do not:

- change the latest confirmed Finding Type or any effective Impact, Severity, or remediation;
- change a condition, modal strength, scope, causal relationship, or responsibility assignment;
- add, guess, or reinvestigate Evidence or Code locations;
- invent a logical node absent from the effective semantics to satisfy the branch contract.

If the selected branch cannot produce a complete Draft without changing the `Content Lock`, return only:

```text
POLISH_DRAFTING_BLOCKED: <conflicting semantic unit or missing content>
```

Write the complete Draft to a separate, uniquely named temporary file.

### 6. Optimize in one fresh child agent

Start exactly one fresh child optimizer for each complete Draft. Give it only:

- `skill://finding-writer/references/hard-rules.md`;
- the selected drafting reference;
- the `Content Lock` temporary file;
- the `Terminology Brief` temporary file;
- the Draft temporary file.

Explicitly designate `Content Lock.semantic_units`, their `immutable_relations`, effective identifiers, and effective Evidence as the optimizer's Authoritative Content Set. The optimizer must only execute the hard rules and verify each final Finding claim against the effective semantics and provenance.

Normalize an optimizer blocking signal to:

```text
POLISH_BLOCKED: <HR rule ID>: <conflicting semantic unit or missing content>
```

Do not return a partially polished result, candidate versions, a change summary, or new audit questions.

### 7. Return and clean up

When the optimizer succeeds, return only the complete polished Finding, without an explanation, change summary, or check results.

Before returning, confirm that:

- the Finding Type equals the latest confirmed type;
- every substantive output claim maps to an effective `Content Lock.semantic_units` entry and its provenance;
- every confirmed revision instruction was applied exactly once and no superseded semantic unit remains in the output;
- every untargeted original semantic unit retains its meaning;
- the input structure has been converted to the selected branch's standard fields, ordering, and layout;
- terminology changes did not change technical meaning;
- Impact, remediation, and Evidence did not drift from the effective semantics;
- the output satisfies the selected branch and every Hard Rule;
- all temporary files created by this workflow have been removed.
