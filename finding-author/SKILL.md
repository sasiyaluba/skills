---
name: finding-author
description: Use when an auditor wants to turn a raw finding into a repository-grounded Security Issue, Recommendation, or Note; rewrite a finding against repository evidence; make a requested substantive change; or change the content of an existing finding rather than only its presentation.
---

# Finding Author

Author semantically complete, repository-grounded findings. This skill may establish or change substantive content from the auditor's instructions, repository evidence, and directly relevant authoritative sources.

Its interface is:

```text
raw or existing finding + requested content changes + repository evidence + auditor decisions
    -> report-ready finding
```

Use exactly one type: `Security Issue`, `Recommendation`, or `Note`.

## References

| Stage | Read |
| --- | --- |
| Every finding | `skill://finding-author/references/finding-model.md` |
| Grounding | `skill://finding-author/references/grounding.md` |
| Terminology | `skill://finding-author/references/terminology.md` |
| Security Issue content | `skill://finding-author/references/security-issue.md` |
| Recommendation content | `skill://finding-author/references/recommendation.md` |
| Note content | `skill://finding-author/references/note.md` |
| Render | `skill://finding-refiner/references/rendering.md` plus the matching type contract listed in Render |

Read the shared model and grounding reference for every finding. Read only the selected type contract. Rendering rules belong exclusively to `finding-refiner`.

## Authority

Apply inputs in this order:

1. the auditor's latest explicit decision controls the requested type, impact, severity, project position, and remediation choice it directly addresses;
2. repository and authoritative evidence control claims about code, specifications, dependencies, and actual behavior;
3. derived conclusions must follow from identified facts and decisions;
4. terminology changes expression only and cannot create substance.

An auditor decision is not repository evidence. If an explicit decision conflicts with verified project behavior, identify the conflict rather than presenting the decision as a repository fact. Preserve accurate, untargeted content in an existing finding; re-ground it instead of treating the existing prose as authoritative.

## Workflow

### 1. Grounding

Read `finding-model.md` and `grounding.md`. Investigate the finding through the relevant code, configuration, documentation, tests, dependencies, and authoritative sources. Resolve requested substantive edits against that evidence.

Select one type from the grounded semantics:

- **Security Issue:** an established deviation from an expected security property produces a concrete adverse security consequence.
- **Recommendation:** a specific improvement closes an established gap, but no concrete security-property violation and adverse security consequence are established.
- **Note:** an accepted design, trust, authority, dependency, deployment, or operating condition is disclosed without requesting a change.

Severity does not determine type. A minor concrete security violation remains a Security Issue. A serious consequence can remain a Note when it occurs only if an accepted assumption fails and the audited implementation is not responsible for enforcing that assumption.

If the auditor supplied a type, preserve it when the evidence supports it. When an explicit type conflicts with grounded content, state the conflict and request the single controlling decision; do not silently reclassify it. If no type was supplied, select the uniquely supported type as a derived conclusion. Ask only when missing auditor judgment cannot be resolved from the request, repository, or authoritative sources and the answer would materially change the finding.

Grounding is complete when every material project claim has claim-bound evidence; facts, auditor decisions, and derived conclusions remain distinguishable; all conditions and boundaries that affect the result are known; and a reader unfamiliar with the repository could understand the relevant behavior without inspecting the code.

### 2. Content

Read the selected type contract and populate exactly one payload from the grounded facts, decisions, and conclusions. Then read `terminology.md`, resolve only terminology needed by that completed payload, and build the shortest complete semantic draft required by the type contract.

For an existing finding or requested rewrite:

- apply each explicit content change to its direct target;
- preserve accurate untargeted claims, conditions, boundaries, identifiers, evidence, impact, and remediation;
- correct unsupported or stale claims from current evidence;
- recompute derived conclusions affected by a changed fact or auditor decision;
- never turn a request for stronger wording into stronger facts, impact, severity, or certainty.

If grounded content is incompatible with a derived type, reclassify when the evidence uniquely determines the correct type. If the auditor explicitly selected the incompatible type, request the single controlling decision instead. Ask only when the choice depends on unresolved auditor intent or project policy and materially changes the finding.

Content is complete when the shared metadata and selected payload satisfy their contracts; every conclusion is supported; impact and severity stay within realistic evidence; remediation closes the established cause or gap; and no field relies on the reader to infer a missing causal or boundary claim.

### 3. Render

Read `skill://finding-refiner/references/rendering.md` and exactly one selected rendering contract:

- `skill://finding-refiner/references/security-issue.md`
- `skill://finding-refiner/references/recommendation.md`
- `skill://finding-refiner/references/note.md`

Render the completed Finding Model through those contracts. Rendering may reorganize information and rewrite expression, but it must preserve subject, predicate, object, polarity, conditions, scope, certainty, causal direction, impact, remediation, identifiers, and evidence. Do not add substantive content during rendering; return to Grounding or Content if the selected rendering contract exposes a semantic gap.

Return only the rendered finding unless the user requested supporting analysis or a missing auditor judgment blocks completion.

## Completion criterion

The result is complete only when it has one compatible type, a complete selected payload, claim-bound evidence, resolved terminology where needed, a realistic impact for a Security Issue, severity metadata when supplied or explicitly requested, a root-cause or gap-closing remediation goal where the type requires one, and a render that satisfies the refiner-owned contracts without semantic drift.
