# Security Issue Content Contract

Use this branch only when evidence establishes both an unexpected deviation from an expected security property and a concrete adverse security consequence. The defect exists independently of whether its conditional consequence is triggered; attach uncertainty to the path or consequence, not to an established root cause.

Return to type selection if the content only requests an improvement, only discloses an accepted assumption, or cannot establish a concrete security consequence. Severity does not repair an incompatible classification.

## Required semantic chain

Complete every node:

```text
Expected Property
  -> Deviation / Root Cause
  -> Conditions + Trigger
  -> Causal Path
  -> Direct Result
  -> Impact
  -> Remediation Goal
```

- **Expected Property:** the authorization, asset, state, data integrity, availability, ordering, accounting, or other security property that should hold, together with its authority.
- **Deviation / Root Cause:** the direct implementation or design departure from that property. It is neither the observable symptom nor a downstream consequence.
- **Conditions:** permissions, state, configuration, asset behavior, timing, sequence, deployment, or external behavior that changes reachability or consequences. Record an empty set only when none applies.
- **Trigger:** the actor, input, operation, state, or deterministic event that activates the deviation.
- **Causal Path:** the shortest complete ordered path from trigger through the root cause to the direct result.
- **Direct Result:** the first relevant change to state, assets, authorization, data, ordering, or control flow.
- **Impact:** one most severe realistic adverse security consequence supported by the path, with affected party or object, conditions, scope, certainty, and material duration or recoverability.
- **Remediation Goal:** the post-change invariant or target behavior that removes the root cause or restores the expected property.

The chain is complete only when a reader can derive the impact without relying on code, a location list, or an unstated assumption.

## Content derivation

Establish the expected-versus-actual contrast from evidence. Do not treat a common defensive convention as the project's expected property. Distinguish an omitted check from an incorrectly implemented check, a root cause from the operation that exposes it, and a direct result from the ultimate impact.
State the expected property as a direct proposition about the responsible subject and required behavior. When a function must return a particular result under a condition, name the function as subject and state that requirement directly. Do not turn the requirement into an abstract `contract` noun unless the evidence identifies a formal software contract as the actual authority.

Introduce an actor only when the actor changes reachability or interpretation. Record the exact permission or role; do not strengthen an ordinary user path into an attacker-only path. Where no actor is needed, use the triggering state, event, or component.

Each path step must explain what causes the next. Preserve all material conditions before the results they constrain. Use the evidence-supported certainty:

- deterministic consequence after stated conditions;
- demonstrated capability or reachable behavior;
- consequence dependent on an external or unfixed condition;
- bounded inference whose remaining uncertainty is explicit.

Do not weaken an established deviation because its consequence is conditional. Do not strengthen a conditional or recoverable result into an unconditional or permanent one.

## Impact and severity

The impact conclusion identifies who or what suffers which concrete security consequence. It must follow from the direct result, remain within the established boundary, and represent the most severe realistic supported outcome. Exclude theoretical maxima, generic `security risk`, multiple alternative impacts, severity rationale, root-cause explanation, and remediation.

Assess optional severity only after impact is fixed. Apply the controlling rubric to impact, reachability, privileges, scope, duration, and recoverability. Preserve an auditor-provided rating as a decision even when recording an evidence-based disagreement. If the rating depends on project policy not inferable from the available inputs, request that single policy judgment.

## Remediation

The remediation goal must close the root cause across every included path or restore the expected property. State the object, required behavior or invariant, scope, and lifecycle point needed to verify success. Blocking one sample trigger or hiding a symptom is insufficient.

Name a concrete implementation only when it is uniquely established. When multiple implementations can restore the invariant, retain the shared goal and implementation freedom. Exclude unrelated defenses and opportunistic improvements.

## Scope and path integrity

Combine paths only when they share the same expected property, root cause, impact, and remediation goal. Preserve distinct triggers, conditions, causal mechanisms, direct results, and boundaries. Split findings when one remediation cannot close every included deviation or when combining paths would obscure materially different consequences.

Repository locations must directly prove the root cause or a comparison necessary to establish the deviation. Include distinct root-cause sites for distinct retained paths. Background definitions, downstream impact sites, redundant larger ranges, and intermediate call-chain nodes do not become code locations unless they prove a material claim the finding otherwise cannot establish.

## Draft content responsibilities

Populate the semantic render interface as follows:

- `Title`: concrete subject plus the actual deviation or supported consequence. Prefer the component and action that distinguish the issue over generic categories such as routing, handling, or validation.
- `Description`: independently establish the expected property, deviation, conditions, trigger, causal path, direct result, and the connection to impact and its boundary.
- `Impact`: the single impact conclusion.
- `Suggestion`: the remediation goal.
- `Code locations`: minimal direct repository evidence for the deviation.

Draft the Description as one causal argument, not one sentence per semantic field. Establish the expected behavior and why it matters in this system, then state the condition that exposes the defect, include only the implementation facts needed to prove the deviation, and end with the direct security-relevant result. Use a reference implementation only when it helps establish the expected behavior, and integrate it into that contrast rather than presenting a parallel implementation walkthrough.

This allocation defines content only. The refiner-owned rendering contract determines expression and presentation.

## Completion check

Before rendering, confirm that:

- the expected property has authority and the deviation is established;
- root cause, trigger, path, direct result, and impact are distinct and causally connected;
- every condition and boundary that changes the claim is retained;
- the impact is singular, concrete, realistic, and no stronger than its evidence;
- severity, when present, follows the controlling rubric and remains metadata;
- the remediation goal fixes the cause or restores the property without adding unrelated work;
- every repository location proves a material defect claim;
- no claim depends on severity language or omitted reasoning to make the issue appear established.
