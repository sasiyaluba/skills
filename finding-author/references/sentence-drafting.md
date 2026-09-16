# Sentence Construction

Construct the finding through accepted sentences, not through a batch draft followed by cleanup. The unit of progress is one sentence that has passed its semantic, continuity, prose, and field gates.

## Prepare the envelope

Before prose, copy the exact field set, field order, labels, and layout from the selected `finding-refiner` type contract. Optional fields enter the envelope only when the locked payload supplies qualifying content. The envelope is fixed after type selection; wording cannot add, remove, or reorder fields.

Draft fields in this semantic order even when the output order differs:

1. Description;
2. Impact, when permitted and present;
3. Suggestion, when permitted;
4. Title, derived only from accepted body content; and
5. Code locations, projected only from claim-bound evidence.

## Maintain the sentence ledger

Before writing a sentence, create one internal ledger entry:

```yaml
field: Description | Impact | Suggestion
job: <one field responsibility this sentence performs>
claims: [<locked claim ids expressed by this sentence>]
requires: [<concepts the reader must already have>]
relation_to_previous: opening | condition | cause | result | contrast | parallel | elaboration | conclusion
establishes: [<concepts available after this sentence>]
```

`relation_to_previous` names the semantic bridge, not necessarily a connective word. The relationship must exist in the Finding Context. Repeated subject, a precise noun phrase, or ordinary syntax may make the bridge explicit; use a connective only when it states the recorded relation accurately.

The first sentence of Description may require only audience prerequisites. A later sentence is reachable only when every item in `requires` is already in the grounded set. After a sentence passes all gates, append it to the accepted chain and add `establishes` to the grounded set. Then, and only then, consider the next sentence. Never prepare ledger entries or wording for future sentences in advance.

## Choose the next sentence

At each step, identify the earliest unresolved node in the selected type's semantic chain whose prerequisites are grounded. Ask internally:

```text
Given the accepted chain, what must the reader learn next for the thesis to follow?
```

Write the shortest complete sentence that performs that job. Semantic fields are a completeness checklist, not a one-sentence-per-node outline: one sentence may express one main claim with one closely related subordinate claim when their relationship is explicit and independently checkable.

If no required node is reachable, the context has a missing prerequisite or relationship. Return to Grounding or unlock the Finding Context. Do not bridge the gap with vague language, an unsupported connective, or reader inference.

## Gate each sentence

Accept a sentence only after all four gates pass.

### 1. Semantic gate

- Every substantive unit maps to a locked claim, relationship, condition, boundary, or terminology entry.
- Subject, predicate, object, polarity, modality, scope, certainty, causal role, and time match the Finding Context.
- The sentence performs exactly its ledger job and the responsibility of its field.
- No adjacency, connective, pronoun, or compression creates a new relationship.

### 2. Continuity gate

- Every required concept is in the audience prerequisites or grounded set.
- The sentence's relation to the preceding sentence is both explicit in the prose and present in the relationship map.
- Each pronoun has one antecedent; repeat the canonical noun when an antecedent is not unique.
- The sentence advances the selected semantic chain; removing it would leave a named gap, and retaining it does not duplicate an established job.

### 3. Formal-prose gate

- Use standard, formal, precise third-person English.
- Use one main claim, natural subject–verb–object syntax, concrete subjects and verbs, and active voice when responsibility matters.
- Use canonical terms consistently and exact identifiers with the required semantic type and formatting.
- Express a required behavior directly with the responsible component or function as subject. Use forms such as ``the function `foo()` must return the error `AlreadyAttached` when the slot is occupied``. Use `contract` for a software contract only when that contract itself is an authoritative named concept, and use it as a semantic type only for an actual contract construct. Never wrap a function requirement in `the contract of the function` or `the function contract`.
- Audit every hyphenated prose token against the Finding Context. Replace any unsourced compound modifier with ordinary relational grammar before accepting the sentence.
- Reject every prose word that expresses an antonym through a negative prefix, including `non-`, `un-`, `in-`, `im-`, `il-`, `ir-`, and `dis-`; exact identifiers, literals, and quotations are the only exceptions. Replace the derived label with an affirmative predicate or an explicit `not`, `without`, `other than`, `fails to`, or `has not` relation.
- Inventory every exact function, type, variant, error, field, state, and other project identifier used by the sentence; verify its spelling, backticks, function parentheses, and semantic-type placement before acceptance. Every occurrence of an identifier whose semantic type is supplied must place that type immediately before the identifier. A single plural type may introduce a coordinated list of identifiers of that same type, as in ``states `Timeout`, `Canceled`, and `Failed` ``. Use forms such as ``the function `foo()` ``, ``the contract `Vault` ``, ``the error `AlreadyAttached` ``, and ``the field `inserted_at` ``. Never place the semantic type after the identifier or emit a bare function identifier.
- Use present tense for current behavior and preserve every authoritative time relation and modal force.
- State behavior and results directly; exclude conversational phrasing, rhetoric, promotion, metaphors, empty risk labels, telegraphic compression, and unsupported evaluative language.
- Never use `so`, `very`, `really`, `basically`, `actually`, `obviously`, `clearly`, `simply`, `just`, `quite`, `pretty`, `a lot`, `kind of`, or `sort of` as ordinary prose; state the exact causal relation, degree, limitation, or conclusion instead.

### 4. Local-rule gate

- Apply every `finding-refiner` rule governing this sentence's field, identifiers, terminology, modality, names, scope, punctuation, and spacing.
- Count each whitespace-delimited token in field content as one word; exclude field labels.
- Keep Description within 120 words and six sentences. Exceed 120 words only when a required semantic-chain node or relationship cannot be preserved otherwise; never exceed 150 words.
- Keep Impact, when present, to exactly one complete consequence sentence of no more than 20 words. Exceed 20 words only when a required impact condition or boundary cannot be preserved otherwise; never exceed 30 words.
- Keep Suggestion, when present, to exactly one precise imperative sentence of no more than 20 words. Exceed 20 words only when a required remediation target or constraint cannot be preserved otherwise; never exceed 30 words.

A failed gate blocks acceptance, not the entire task. Revise this sentence, reorder the remaining semantic jobs, or unlock the context as required. Do not continue to the next sentence while the current sentence fails.

## Complete each field

Description is complete when its accepted chain independently establishes the selected payload's complete logic and supports every later Impact or disclosed consequence without relying on Title or Code locations.

Impact is a new one-sentence chain with the Description as its prerequisite context. It states only the locked consequence, affected object, and necessary boundary. Suggestion is a new one-sentence chain with the Description as its prerequisite context. It states only the locked remediation goal and constraints.

Draft Title after the body fields. It indexes the accepted subject and distinguishing fact without adding a claim. Preserve every authoritative Title head noun and every modifier that changes the affected operation, path, condition, mechanism, object, or scope; brevity never licenses deletion. When normalizing one modifier, change only that modifier: render `concurrent same-hash preconfirmation retries` as `concurrent preconfirmation retries for the same transaction hash`, retaining `preconfirmation`. Validate the complete Title as one formal phrase against the semantic, terminology, formal-prose, identifier, and type-specific title gates before accepting it. Every occurrence of an identifier whose semantic type is supplied must place that type immediately before the identifier: use ``Function `foo()` `` and ``Contract `OracleAdapter` `` in a Title, never `` `foo()` function`` or `` `OracleAdapter` contract``. Do not stack a semantic type, identifier, and abstract noun as bare modifiers. Add Code locations last in the order of the claims they prove.

## Validate the completed chain

Run both traversals before rendering:

- **Forward:** for each sentence, verify its prerequisites are already grounded, its bridge is true, and its established concepts are used consistently later.
- **Backward:** start from Impact, the Recommendation rationale, or the Note's disclosed endpoint; trace every conclusion, result, cause, condition, and prerequisite to an earlier sentence and then to locked claims and evidence.

Then run the `finding-refiner` exhaustive semantic, structure, terminology, and English checks. Count Description sentences by terminal punctuation and count each prose field using the word-count rule before rendering. Compare the final labels, field order, blank lines, location syntax, and optional-field presence exactly with the selected envelope.

The chain is valid only when every sentence passes individually, both traversals close without an implicit bridge, and the fixed envelope passes every rendering check. If a later correction changes a sentence's meaning or established concepts, invalidate and reconstruct that sentence and every dependent sentence after it.
