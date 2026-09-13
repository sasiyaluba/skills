# Note Content Contract

Use this branch to disclose an accepted security-relevant design, trust relationship, authority, dependency, deployment boundary, or operating condition without requesting a change to current behavior.

A Note is defined by causal ownership, not consequence severity. If all accepted assumptions hold and an unexpected implementation deviation still causes a security consequence, use Security Issue. If current behavior is acceptable but the report asks to improve it, use Recommendation. Never invent design intent or remove a requested change to preserve Note classification.

## Required semantic structure

Establish:

```text
Accepted Context
  -> Operational Assumption within Boundary
  -> [Responsibility]
  -> [Guarantees / Non-guarantees]
  -> [Consequence if the assumption fails]
  + Project Position
```

- **Accepted Context:** the current design, trust relationship, authority, dependency, deployment, or operating arrangement being disclosed.
- **Operational Assumption:** the specific, testable condition on which correct or secure operation relies.
- **Responsibility:** an optional party and concrete duty, included only when evidence assigns it.
- **Guarantees / Non-guarantees:** optional supported statements of what the system does or does not ensure within the boundary. Each needs independent positive evidence.
- **Consequence:** an optional concrete result that occurs only if the assumption fails, with affected object, certainty, and boundary.
- **Boundary:** applicable actors, objects, states, permissions, configurations, versions, chains, environments, timing, or deployment scope.
- **Project Position:** evidence that the context is accepted, including its original status as current design, scoped acceptance, planned deployment, or auditor decision.

A Note may omit responsibility, guarantees, or consequence when evidence does not establish them. It may not omit the accepted context, specific assumption, boundary, or project position needed to distinguish disclosure from defect.

## Content derivation

State actual capabilities and dependencies rather than risk labels. For a privileged role, identify the exact role, material capability, affected scope, and trust condition. For an external or off-chain dependency, identify which component depends on which entity, the specific behavior supplied externally, what the audited system verifies, and what remains outside it. For deployment or compatibility, identify the supported environment and the mechanism whose behavior depends on that boundary.

Do not infer a responsibility from the mere existence of a dependency. Do not treat role names as interchangeable. Expand vague assumptions such as "the service behaves correctly" into the specific property that must be maintained.

Code silence is not an explicit non-guarantee, and a test or current configuration is not an unconditional guarantee. A guarantee requires an enforced path, controlling specification or documentation, compatible project confirmation, or established operating mechanism. If an omitted property should be enforced by the audited implementation, reconsider Security Issue or Recommendation rather than recasting it as a Note.

Preserve project statements at their original certainty and time boundary. A plan is not a deployed fact, scoped acceptance is not a permanent protocol property, and risk acceptance is not a technical guarantee.

## Conditional consequence

A consequence explains why the assumption matters; it is not an independent impact assessment. Include it only when evidence establishes:

```text
failed assumption -> affected object -> concrete result -> necessary boundary
```

The consequence may be serious, but it must remain explicitly conditional on failure of the accepted assumption and must not be caused by an unexpected deviation that persists while assumptions hold. Match certainty to the path and omit generic risks or unsupported theoretical outcomes. Notes do not use severity.

## Scope integrity

Combine capabilities, dependencies, or conditions only when they share one accepted context, core assumption, responsibility allocation, guarantee boundary, consequence, and distinguishing subject. Split items with different responsible parties, operating conditions, guarantees, or consequences.

Repository locations must directly prove the disclosed design, capability, dependency, assumption, or guarantee boundary. Use minimal ranges and exclude function inventories, redundant locations, and background-only call-chain nodes. Auditor decisions and external evidence remain non-repository evidence.

## Draft content responsibilities

Populate the semantic render interface as follows:

- `Title`: subject plus the disclosed relationship, authority, assumption, or boundary.
- `Description`: accepted context, operational assumption, applicable boundary, and every supported optional responsibility, guarantee, consequence, or project position needed for a self-contained disclosure.
- `Code locations`: minimal direct repository evidence for the disclosed claims.

A Note has no semantic `Impact` or `Suggestion`: any consequence remains bound to its failed assumption in the description, and operational duties remain conditions rather than change requests. This allocation defines content only; the refiner-owned rendering contract determines expression and presentation.

## Completion check

Before rendering, confirm that:

- evidence establishes an accepted context rather than an unexpected deviation or requested improvement;
- the assumption is specific and testable;
- responsibility appears only when assigned and states a concrete duty;
- each guarantee and non-guarantee has independent support;
- each consequence names its failed assumption, affected object, result, certainty, and boundary;
- project position retains its original scope, time, and certainty;
- grouped claims share one trust or operating logic and each repository location proves a material claim;
- no severity, independent impact, remediation, generic risk label, or inferred design intent has entered the payload.
