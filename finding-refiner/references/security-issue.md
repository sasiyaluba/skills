# Security Issue Rendering Contract

Use this contract only when the authoritative type is `Security Issue`.

## Field order

```text
**Title:** <defect or consequence noun phrase>

**Description:**

<complete causal explanation>

**Impact:**

<one consequence sentence>

**Suggestion:**

<one imperative remediation sentence>

**Code locations:**

- <repo-relative closed range>
```

Every field is required. If the authoritative input cannot supply one without new substantive work, block under the shared rendering contract.

## Responsibilities

- **Title** identifies the affected subject and its distinguishing deviation, root cause, or already-supported consequence. Use a noun phrase, not a remediation command. Do not add severity, an attacker, a type label, or a consequence absent from the input.
- **Description** preserves the issue chain in comprehensible order: expected property; deviation or root cause; conditions and trigger; path and direct result; and the connection to the authoritative impact. Keep distinct paths distinct whenever their conditions, mechanisms, results, or boundaries differ. The confirmed deviation is stated directly; conditionality attaches to the path or consequence it constrains.
- **Impact** states the authoritative affected actor, asset, state, operation, or security property and one concrete consequence, with every necessary condition and boundary. It does not repeat the root cause, path, severity rationale, or remediation.
- **Suggestion** renders the authoritative remediation goal as one precise imperative sentence. It must address the deviation or restore the expected property while preserving every implementation choice left open by the input. It does not add hardening, monitoring, testing, migration, retries, or architectural changes.
- **Code locations** formats the supplied evidence for the deviation or root cause and any supplied contrast necessary to establish it. Apply the shared evidence-location rules without repository inspection or evidentiary reassessment.

The final wording must continue to state a confirmed expected-property deviation with a security consequence. If doing so would require inventing a missing chain node, changing impact, or altering the type, block.
