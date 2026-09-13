# Recommendation Content Contract

Use this branch when the report requests a specific improvement and the evidence establishes a concrete gap, but does not establish both a violated security property and an adverse security consequence. A Recommendation is not a low-severity Security Issue.

Return to type selection when the established facts show a concrete security violation, or when the content merely discloses an accepted design, trust, dependency, or operating condition without requesting change. Do not preserve this type by deleting a security path or weakening certainty.

## Required semantic chain

Complete the following chain:

```text
Current Behavior
  -> Gap
  -> Direct Rationale
  -> [Bounded Non-Security Consequence]
  -> Remediation Goal
```

- **Current Behavior:** what the relevant implementation, interface, configuration, documentation, or design actually does.
- **Gap:** a verifiable difference from a supported target behavior or quality, such as an applicable standard, consistency requirement, validation boundary, robustness property, observable interface need, or avoidable operation.
- **Direct Rationale:** the project-specific engineering value produced by closing the gap.
- **Bounded Non-Security Consequence:** an optional, distinct, observed or directly derivable result whose object and scope are limited and which is not a security-property violation.
- **Remediation Goal:** a specific, verifiable target behavior that closes this gap and no unrelated gap.

Current behavior and gap are separate claims. The rationale must follow from both and cannot consist only of a category such as clarity, maintainability, robustness, or best practice.

## Content derivation

Record only implementation context needed to understand the difference and its value. When the gap rests on a standard, specification, or design pattern, establish that the source applies to the current component and version, state the exact requirement, and distinguish mandatory requirements from optional conventions.

A gap must identify the object, current-versus-target difference, and relevant scope or lifecycle stage. A direct rationale must identify a concrete result in this project, such as aligning an interface with supported behavior, removing a duplicate operation, returning an error at the correct boundary, exposing required state, preserving consistent semantics, or supplying attribution data. These categories are not conclusions without project-specific evidence.

Include actors, inputs, ordering, or local results only when they change the value of the improvement or the safe implementation boundary. Do not manufacture a Security Issue trigger path, attacker, or hypothetical incident to make the recommendation appear important.

## Optional consequence

Populate `bounded_non_security_consequence` only if all conditions hold:

1. it is observed or follows directly from grounded facts;
2. its affected object and extent are bounded;
3. it is not an asset, authorization, integrity, availability, protocol-operation, or user-security violation;
4. it is distinct from the direct rationale;
5. it does not depend on a theoretical incident or unconfirmed deployment condition.

If the consequence establishes a concrete security-property violation, use the Security Issue branch. If it merely restates that the code is harder to understand, maintain, or integrate, retain it as rationale rather than a separate consequence. Recommendations do not acquire severity.

## Remediation

The remediation goal must identify the affected object, target behavior or relationship, required scope, and lifecycle point where relevant. It must cover every location grouped into the recommendation and allow a reviewer to determine whether the gap is closed.

Specify one implementation only when the evidence or auditor decision establishes it as uniquely correct. If multiple implementations preserve the same security, external semantics, and compatibility, state their common verifiable goal. If the choice changes product semantics, security, or compatibility, obtain the missing project or auditor decision rather than presenting alternatives as interchangeable.

Exclude unrelated hardening, refactoring, monitoring, testing, migration, and architectural work.

## Scope integrity

Combine locations only when they share the same current behavior, gap, rationale, remediation goal, lifecycle requirements, and implementation boundary. Similar labels such as validation, documentation, or duplicate code do not justify combining independent improvements. Split items that can be implemented independently or deliver different value.

Repository locations must directly prove current behavior, the gap, or a comparison required to establish it. Include each minimal range needed to establish grouped scope. Exclude background-only ranges, redundant larger ranges, and unrelated call-chain nodes.

## Draft content responsibilities

Populate the semantic render interface as follows:

- `Title`: subject plus the distinguishing improvement or precise gap.
- `Description`: current behavior, gap, direct rationale, and material scope or lifecycle boundary.
- `Impact`: only the qualifying bounded non-security consequence.
- `Suggestion`: the remediation goal.
- `Code locations`: minimal direct repository evidence for current behavior or the gap.

Omit the semantic `Impact` value when the optional consequence fails any requirement. This allocation defines content only; the refiner-owned rendering contract determines expression and presentation.

## Completion check

Before rendering, confirm that:

- the finding requests a concrete improvement without hiding an established Security Issue;
- current behavior and gap are distinct, grounded claims;
- any controlling requirement is authoritative and applicable;
- the rationale identifies direct project-specific value;
- the optional consequence is supported, bounded, non-security, and distinct from rationale;
- the remediation goal exactly closes the gap and remains verifiable;
- grouped locations share one improvement logic and each repository location proves a material claim;
- no severity, attack narrative, theoretical incident, or unrelated improvement has entered the payload.
