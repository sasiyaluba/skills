---
name: finding-author
description: Use when an auditor wants to turn a raw finding into a repository-grounded Security Issue, Recommendation, or Note; rewrite a finding against repository evidence; make a requested substantive change; or change the content of an existing finding rather than only its presentation.
---

# Finding Author

Author one semantically complete, repository-grounded `Security Issue`, `Recommendation`, or `Note` through a locked context and a sentence chain.

```text
raw or existing finding + requested changes + evidence + auditor decisions
    -> locked Finding Context -> sentence chain -> report-ready finding
```

## References

| Stage | Read |
| --- | --- |
| Every finding | `skill://finding-author/references/finding-model.md` |
| Grounding | `skill://finding-author/references/grounding.md` |
| Context lock | `skill://finding-author/references/finding-context.md` |
| Security Issue content | `skill://finding-author/references/security-issue.md` |
| Recommendation content | `skill://finding-author/references/recommendation.md` |
| Note content | `skill://finding-author/references/note.md` |
| Sentence construction | `skill://finding-author/references/sentence-drafting.md` |
| Render | `skill://finding-refiner/references/rendering.md` and the matching type contract |

Read the shared model, grounding contract, and context contract for every finding. Read only the selected type contract. Read the sentence-construction and rendering contracts before drafting any output sentence.

## Authority

Apply inputs in this order:

1. the auditor's latest explicit decision controls the type, impact, severity, project position, and remediation choice it directly addresses;
2. repository and authoritative evidence control claims about code, specifications, dependencies, and actual behavior;
3. derived conclusions must follow from identified facts and decisions; and
4. terminology controls expression only and cannot create substance.

An auditor decision is not repository evidence. When a decision conflicts with verified project behavior, preserve both authorities explicitly and obtain the single controlling decision only when the conflict materially changes the finding. Preserve accurate untargeted content in an existing finding, but re-ground it rather than treating its prose as authoritative.

## Workflow

### 1. Ground the matter

Read `finding-model.md` and `grounding.md`. Investigate the smallest sufficient set of code, configuration, tests, project documentation, dependency source, specifications, and authoritative documentation. Read applicable project context and decision records when they exist; use their domain terms and preserve the scope and status of their decisions.

Separate grounded facts, auditor decisions, and derived conclusions. Bind every material project claim to evidence and establish all conditions, causal steps, boundaries, and certainty levels that affect the result.

Grounding is complete only when every repository-answerable question is resolved and each remaining open question is an auditor judgment that would materially change a payload claim.

### 2. Lock the Finding Context

Read `finding-context.md`. Build one Finding Context from the grounded material before selecting wording, and select exactly one compatible type as part of locking that context. The locked context is the single source of truth for the rest of the run; it is internal working state and must not modify the audited project's `CONTEXT.md` or decision records unless the user explicitly requests that separate work.

Use a docs-backed grill when terminology, expected behavior, project position, impact, severity, or remediation depends on unresolved auditor judgment. Map those decisions by dependency, ask only the current frontier, and include the evidence-backed recommended answer. Find facts in the repository and authoritative sources instead of asking the auditor to supply them. Skip the interview when the evidence and existing instructions uniquely determine the context.

Use these type definitions during the lock:

- **Security Issue:** an established deviation from an expected security property produces a concrete adverse security consequence.
- **Recommendation:** a specific improvement closes an established gap, but the evidence does not establish both a security-property violation and an adverse security consequence.
- **Note:** an accepted design, trust, authority, dependency, deployment, or operating condition is disclosed without requesting a change.

Severity does not determine type.

Lock the context only when:

- the subject, actors, objects, states, conditions, boundaries, and exact relationships have stable meanings;
- every recurring referent has one canonical term and every competing input term is mapped or rejected;
- the selected type and its complete semantic chain are supported;
- the intended conclusion follows from named facts and decisions; and
- no unresolved decision can change a material sentence.

### 3. Complete the selected payload

Preserve an auditor-selected type when the evidence supports it. If an explicit type conflicts with the otherwise lockable context, identify the conflict and obtain the single controlling decision rather than silently reclassifying the finding.

Read the selected type contract and complete its payload. For an existing finding, apply each requested content change to its direct target, preserve accurate untargeted semantics, correct stale claims, and recompute every dependent conclusion. Stronger wording never licenses stronger facts, impact, severity, or certainty.

### 4. Construct the finding one sentence at a time

Read `sentence-drafting.md`, the shared rendering contract, and the selected rendering contract. Create the exact type-specific output envelope before writing prose. Then construct one sentence, validate it, and add it to the accepted chain before considering the next sentence. Do not draft ahead.

Each accepted sentence must:

- perform one field responsibility and one main semantic job;
- use only concepts already available to the reader, while clearly establishing any new concept before a later sentence relies on it;
- state a true and explicit logical relation to the preceding sentence, except for the first sentence in a field;
- use the Finding Context's canonical terms, relations, conditions, scope, and certainty; and
- already satisfy the applicable formal-English, identifier, modality, and field rules.

When a sentence cannot pass, repair the context, semantic order, or sentence before continuing. A connective may express an established relation, but it cannot manufacture one. Formal prose is a construction constraint, not a final polishing pass.

### 5. Render into the fixed envelope

Derive the Title from the accepted Description rather than using it to introduce content. Populate Description from its accepted sentence chain. Populate Impact and Suggestion only when the selected contract permits them and only from their locked payload values. Populate Code locations only from claim-bound evidence.

Apply `finding-refiner` as a lossless rendering gate. Rendering may normalize expression and presentation, but it must preserve every subject, predicate, object, polarity, condition, scope, certainty, causal direction, impact, remediation constraint, identifier, and evidence binding. If rendering exposes a semantic gap, return to Grounding or the Finding Context instead of improvising content.

### 6. Validate in both directions

Run the sentence-chain, semantic-equivalence, terminology, English, and structure checks from `sentence-drafting.md` and `finding-refiner`. Validate forward from the first Description sentence to the conclusion, then backward from Impact or the disclosed endpoint to ensure that every prerequisite and causal bridge appears earlier. Compare the final field labels and order byte-for-byte with the selected rendering envelope.

Return only the rendered finding unless the user requested supporting analysis or one irreducible auditor decision blocks completion.

## Completion criterion

The result is complete only when one locked Finding Context supports one compatible payload; every material claim has claim-bound evidence; every sentence passed individually before the next was drafted; the complete chain is logically continuous in both directions; canonical terminology and formal written English are consistent across fields; impact, severity, and remediation remain within their authority; and the final output exactly matches the selected field contract.

