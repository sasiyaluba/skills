# Grounding

Ground the finding until a reader who has never seen the repository can understand every material behavior, condition, relationship, result, and boundary represented in the Finding Model.

## Establish the facts

Start from the user's raw or existing finding and any requested substantive changes. Trace the relevant implementation rather than searching for phrases that merely resemble the report text.

Inspect the smallest sufficient set of:

- definitions and entry points that establish the subject and current behavior;
- callers, state transitions, permission checks, data flows, ordering, and error paths that establish reachability and causality;
- configuration, interfaces, tests, and project documentation that establish intended behavior or scope;
- dependency source, formal specifications, and authoritative documentation when their semantics control the path.

Continue until each material claim is either established, disproved, or identified as an auditor decision. Do not use tests as proof of a guarantee beyond the behavior they exercise. Do not infer an expected property from generic best practice when the project, protocol, or controlling specification does not require it.

For remediation planning, default an audited in-scope instance to undeployed unless the auditor states otherwise; treat this as a workflow assumption, not a repository fact. Keep dependency contracts, historical versions, and prior deployments separate. If actual deployment status would materially change impact, scope, or remediation, establish it from evidence or request the single missing auditor decision.

## Build claim-bound evidence

For every repository fact, record the minimal complete range that proves it and state exactly what it supports. Add a caller or comparison range only when it closes a necessary causal or expected-versus-actual step. Do not use a downstream impact site to prove the root cause or list an entire call chain when intermediate nodes add no material fact.

Evidence from the auditor or an external source remains identified as such and must not be presented as a repository location. Review the actual authoritative source; search snippets, summaries, and unread links are leads rather than evidence.

## Establish causality and boundaries

Walk the path in execution order:

1. identify the relevant state and permissions before the trigger;
2. identify the actor, input, operation, state, or event that triggers the behavior;
3. explain each necessary transition caused by the implementation;
4. identify the first relevant direct result;
5. connect that result to any further consequence without skipping a causal node;
6. record every condition that changes reachability, affected parties, scope, duration, or recoverability.

Distinguish concurrent, sequential, conditional, and causal relations. Temporal adjacency does not prove causality. State deterministic results directly and attach uncertainty only to the step that depends on an external or unresolved condition. Keep separate paths if they differ materially in trigger, precondition, mechanism, result, impact boundary, or remediation.

For roles, identify the project's exact role and actual capability. Use `attacker` only when malicious intent is material; a path available to any user remains a user path. For external dependencies, claim only behavior the dependency or controlling specification establishes.

## Establish expectations, acceptance, and project position

An expected property needs a concrete authority: enforced invariant, specification, project documentation, protocol semantics, consistent interface contract, or explicit auditor decision. Separate the expected property from the observed deviation and from its consequences.

A Note needs evidence that the context is accepted rather than defective. Acceptance may come from an explicit design or product statement, a bounded trust model, a confirmed deployment or operating decision, or an auditor decision. Finding classification alone does not prove intentional design. Preserve whether a project statement describes current behavior, a future plan, a scoped acceptance, or a technical guarantee.

Code silence proves neither that another component performs an omitted check nor that the system promises not to provide a property. Establish responsibilities and guarantees from positive evidence.

## Assess conclusions

Derive type, impact, severity, and remediation only after the relevant facts are complete.

- Choose the most severe realistic impact supported by a reachable path, not a theoretical maximum.
- Preserve affected objects, prerequisites, permissions, timing, deployment, scale, duration, and recoverability.
- Apply a controlling severity rubric to that impact and those boundaries; never infer type from severity.
- Define remediation against the root cause or gap, not one example input or visible symptom.
- Treat auditor-provided type, impact, severity, project position, and remediation as decisions, not repository facts.

When an existing finding conflicts with current evidence, correct its factual content and recompute dependent conclusions. When an auditor decision conflicts with evidence, retain both authorities explicitly and ask only if resolving the conflict requires auditor judgment that materially changes the output.


## Completion check

Grounding is complete only when:

- each material project claim has direct, claim-bound evidence;
- repository facts, auditor decisions, and derived conclusions are distinguishable;
- the expected or accepted behavior has an identified authority;
- every causal step, condition, boundary, and certainty level needed by the selected payload is established;
- impact, severity, and remediation do not exceed their supporting facts;
- no question answerable through the repository or authoritative sources remains open.

If a missing auditor judgment remains, ask for the one decision and explain which payload claim would change. Do not ask the auditor to confirm facts that tools can establish.
