---
name: finding-refiner
description: Refine an existing Security Issue, Recommendation, or Note into report-ready English by normalizing formatting, wording, terminology, identifiers, and field placement without changing facts, type, impact, severity, causal logic, scope, evidence, or remediation. Use when polishing or standardizing an existing finding or a finding-author draft without substantive revision.
---

# Finding Refiner

Refine one authoritative `Security Issue`, `Recommendation`, or `Note` through a semantic lock, an accepted sentence chain, and a fixed output envelope. Change presentation only.

```text
authoritative finding content
    -> semantic lock -> sentence-by-sentence lossless refinement -> exact report format
```

## Boundary

This skill performs **Render** only. It may normalize field placement, sentence structure, grammar, terminology, identifiers, and formatting when the result is semantically equivalent. It does not inspect the repository, research terminology, classify or reclassify the finding, assess impact or severity, resolve auditor judgment, select remediation, or complete missing content.

Facts, type, impact, severity, causal logic, conditions, scope, certainty, project position, evidence, remediation, and implementation freedom are authoritative input. A request to change any of them belongs to `finding-author`, even when phrased as editing. Lossless shortening, deduplication, splitting, combining, and reordering remain Refiner work.

## References

1. Read `skill://finding-refiner/references/rendering.md` in full.
2. Read exactly one selected type contract:
   - `Security Issue`: `skill://finding-refiner/references/security-issue.md`
   - `Recommendation`: `skill://finding-refiner/references/recommendation.md`
   - `Note`: `skill://finding-refiner/references/note.md`

## Workflow

### 1. Lock the authoritative meaning

Identify the one explicitly selected type; do not infer it. Build the read-only Semantic Lock required by `rendering.md` before changing any text. When `finding-author` supplies a Finding Context, project its claims, relations, terminology, payload, and evidence directly into the lock. Otherwise decompose the existing finding itself. Ambiguous, conflicting, or missing substantive content blocks refinement rather than authorizing reconstruction.

Lock is complete only when every material source unit has an authority, field responsibility, relation, condition, boundary, and destination in the selected type contract.

### 2. Fix the output envelope

Copy the selected type contract's exact fields, order, labels, optional-field decision, and layout before writing prose. The envelope cannot change during refinement.

### 3. Refine one sentence at a time

Follow the sentence loop in `rendering.md`. Select the next reachable semantic job, identify the authoritative units it consumes, write one sentence, and run its semantic, continuity, formal-prose, and local-field gates. Accept that sentence before considering the next one. Do not draft ahead or defer known defects to a final polish pass.

Build Description first. Build permitted Impact and Suggestion fields from their authoritative units next. Derive Title only from accepted body content. Format Code locations last from supplied claim-bound evidence.

### 4. Validate bidirectionally

Trace the accepted chain forward to prove that every sentence relies only on established concepts and true relations. Trace it backward from each conclusion, consequence, and remediation target to prove that no prerequisite or causal bridge is implicit. Then compare every authoritative source unit to the complete result and every rendered unit back to its authoritative source.

### 5. Emit one result

When all gates pass, return only the exact rendered finding. When any required repair would be substantive or non-unique, return only the blocking line required by `rendering.md`. Do not emit analysis, alternatives, checklists, or change notes.

## Completion criterion

Refinement is complete only when the selected type and Semantic Lock are unchanged; every sentence passed before the next was written; every authoritative unit remains recoverable with the same meaning and relation; no rendered unit lacks authority; the chain is logically continuous in both directions; formal English and terminology are consistent; and the final bytes satisfy the fixed type envelope.

