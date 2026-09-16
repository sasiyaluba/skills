# Recommendation Rendering Contract

Use this contract only when the authoritative type is `Recommendation`.

## Field order

Default form:

```text
**Title:** <imperative improvement phrase or precise gap phrase>

**Description:**

<current behavior, improvement gap, and rationale>

**Suggestion:**

<one imperative remediation sentence>

**Code locations:**

- <repo-relative closed range>
```

When the authoritative content already includes a distinct, bounded non-security consequence, place this field between Description and Suggestion:

```text
**Impact:**

<one bounded non-security consequence sentence>
```

Impact is otherwise omitted. All other fields are required. If the authoritative input cannot supply a required field without new substantive work, block under the shared rendering contract.

## Sentence chain

Build Description through the following reachable jobs: establish current behavior; state the supported target and precise gap; then establish the direct project-specific rationale. Put lifecycle and scope conditions before the job they constrain. One sentence may cover adjacent jobs only when it retains one main claim and an explicit, independently checkable relation.

When authoritative content supplies a qualifying bounded non-security consequence, Impact begins a new one-sentence chain with Description as prerequisite context. Suggestion does the same for the remediation goal. Derive Title only after the body fields are accepted.

## Responsibilities

- **Title** identifies the affected subject and distinguishing improvement. Prefer an imperative phrase when it does not imply a new implementation choice; otherwise use a precise non-security gap phrase. Do not add severity, exploit language, a type label, or a security consequence.
- **Description** preserves the recommendation chain in comprehensible order: current behavior, improvement gap, and direct rationale. Keep lifecycle, scope, or multiple-location distinctions when they affect the gap or target. It explains why the improvement has concrete value without introducing an attack path or security-property violation.
- **Impact**, when present, states exactly the supplied observable, bounded, non-security consequence. It remains distinct from the direct rationale and does not acquire severity or security-risk language. Never manufacture an Impact to complete the presentation.
- **Suggestion** renders the authoritative remediation goal as one precise, reviewable imperative sentence. Preserve the supplied target, scope, lifecycle timing, constraints, and implementation freedom. Do not add adjacent hardening, refactoring, monitoring, testing, migration, or architectural work.
- **Code locations** formats supplied evidence for the current behavior, gap, and any supplied comparison necessary to establish the difference. Apply the shared evidence-location rules without repository inspection or evidentiary reassessment.

The final wording must continue to request a specific improvement without asserting an established security-property violation. If preserving the input would instead require issue or note framing, reclassification, impact assessment, or a new remediation decision, block.
