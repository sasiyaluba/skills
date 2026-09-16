# Shared Rendering Contract

Refine authoritative content without changing substance. Construct the result through a Semantic Lock, a fixed envelope, and individually accepted sentences rather than a batch rewrite followed by cleanup.

## Priority

Apply requirements in this order:

1. **Semantic Lock:** authoritative meaning and relations;
2. **Type Contract:** selected field set and responsibilities;
3. **Terminology and evidence:** supplied vocabulary and claim bindings;
4. **Expression:** formal, natural English;
5. **Brevity:** only after the first four are satisfied.

A lower priority cannot change a higher one. A non-unique or substantive repair blocks refinement.

## 1. Build the Semantic Lock

Before rewriting, decompose the complete authoritative input into independently comparable source units. Record every supplied or protected:

- selected type and subject;
- expected property, current behavior, or accepted design and trust context;
- deviation, improvement gap, or operational assumption;
- actor, role, affected party, asset, object, state, and responsible party;
- precondition, trigger, necessary order, and path step;
- causal, conditional, contrastive, parallel, temporal, and scope relation;
- direct result, rationale, conditional consequence, and confirmed impact;
- quantity, permission, timing, version, chain, configuration, deployment, duration, and recoverability;
- certainty and modality;
- remediation invariant, confirmed implementation choice, and remaining implementation freedom;
- project position and its time boundary;
- canonical term, exact identifier, and semantic type; and
- claim-bound evidence location.

For each unit, record its source, authority, relation to other units, selected-field responsibility, and intended destination. The lock exposes existing meaning; it does not complete or reinterpret it.

When a locked Finding Context is supplied, use its claims, relationship map, terminology, payload, and evidence as the Semantic Lock. Otherwise derive the lock only from the authoritative finding. Do not inspect a repository or external source. A code location, passing test, unstated convention, or general industry practice cannot supply missing meaning.

Preserve each unit's:

```text
subject · predicate · object · polarity · condition · modality · scope
certainty · causal role · time · impact · remediation · identifier · evidence
```

Preserve facts as facts and inferences as inferences. Preserve the distinctions between current behavior, a plan, risk acceptance, a technical guarantee, a conditional consequence, and a confirmed impact. Sequence and adjacency never establish causation.

### Minimum change

Keep wording that is already accurate, natural, and compliant. Change only the smallest text necessary to satisfy this contract. Delete only exact duplication, forbidden or empty fields, process material, placeholders, or text proven to perform no semantic or field responsibility.

Before deleting or combining text, confirm that no condition, boundary, relation, responsibility, certainty, impact, project position, remediation constraint, implementation freedom, or evidence binding would disappear.

## Blocking

Return exactly the following when lossless refinement requires a substantive or non-unique decision:

```text
REFINEMENT_BLOCKED: <smallest specific missing, conflicting, ambiguous, or substantively requested unit>; use finding-author
```

Return no partial finding, question, alternative, analysis, or explanation. Blocking conditions include:

- no explicit type, or content incompatible with the selected type;
- a missing fact, causal node, rationale, accepted context, assumption, consequence, impact, remediation goal, semantic type, or evidence binding required by the selected contract;
- conflicting actors, behavior, conditions, scope, timing, certainty, impact, project position, or remediation;
- terminology whose correct meaning requires research or a substantive choice;
- distinct paths whose lossless separation requires reconstruction;
- an unsupported impact or a Suggestion that does not address the supplied cause, property, gap, or goal;
- a code location whose relevance or range cannot be established from supplied claim bindings;
- natural English that requires choosing among technical meanings;
- alternatives whose security, external semantics, or compatibility are not authoritatively equivalent;
- a Description that cannot fit within six sentences and 150 words, an Impact that cannot fit within one sentence and 30 words, or a Suggestion that cannot fit within one imperative sentence and 30 words without loss; or
- any requested change to facts, type, logic, impact, severity, scope, evidence, project position, remediation, or implementation freedom.

## 2. Fix the type envelope

Read exactly one type contract. Copy its exact field set, order, labels, optional-field decision, and layout before writing prose. Do not add, remove, reorder, rename, or leave fields empty. Do not use `N/A`, `None`, `TBD`, or another placeholder.

The envelope remains fixed. A wording problem cannot change the field set, and a field problem cannot be hidden in another field.

Use only these labels when the selected type permits them:

```text
**Title:**
**Description:**
**Impact:**
**Suggestion:**
**Code locations:**
```

Put the Title value on its label line. Put every other field's content after its label and one blank line. Separate field blocks with one blank line. Add no heading, code fence, introduction, conclusion, or trailing commentary. Use Unix line endings and no trailing whitespace.
Emit no report title, client metadata, audit-scope or version table, finding ID, status, `Introduced by`, pagination, table of contents, listing, caption, report-build material, document-review question, standalone project-feedback field, source excerpt, code snippet, LaTeX, reasoning, checklist, or process note. Severity remains authoritative metadata and is not a finding field.

## 3. Refine one sentence at a time

Build fields in semantic dependency order: Description; permitted Impact; permitted Suggestion; Title; Code locations. Before writing one target sentence, create this internal card:

```yaml
field: Description | Impact | Suggestion
job: <one field responsibility>
source_units: [<authoritative unit ids>]
requires: [<concepts already established for the reader>]
relation_to_previous: opening | condition | cause | result | contrast | parallel | elaboration | conclusion
establishes: [<concepts available to later sentences>]
```

The first Description sentence may require only ordinary audit-reader knowledge and supplied audience prerequisites. Every later sentence may require only concepts established earlier. The relation to the preceding sentence must be explicit in the prose and present in the Semantic Lock. Repeated subjects and ordinary syntax may express the relation; a connective may label an existing relation but cannot create one.

Select the earliest remaining semantic job whose prerequisites are established. Write the shortest complete sentence that performs that job. Run all four gates below. Accept the sentence and update the established set only after every gate passes. Then consider the next sentence. Do not prepare later cards or wording in advance.

If no remaining job is reachable, an implicit or missing relation blocks refinement. Do not conceal the gap with a vague subject, pronoun, connective, modal, or risk label.

### Semantic gate

- Every rendered unit maps to authoritative source units.
- Subject, predicate, object, polarity, condition, modality, scope, certainty, causal role, time, impact, remediation, identifiers, and evidence remain equivalent.
- The sentence performs one field responsibility and one main claim, with at most one closely related subordinate claim.
- Splitting, combining, or reordering leaves every unit and relation independently recoverable.
- The sentence neither invents nor suppresses a fact, relation, boundary, choice, or inference.

### Continuity gate

- Every required concept is already established.
- The bridge from the preceding sentence is explicit and authoritative.
- Every pronoun has one antecedent; otherwise repeat the canonical noun.
- The sentence advances the selected type chain and does not duplicate an established job.
- Removing the sentence would leave a named semantic gap.

### Formal-prose gate

- Use standard, formal, precise third-person English.
- Use natural subject–verb–object syntax, articles, prepositions, and technical collocations.
- Name concrete actors or components and use concrete verbs; use active voice when responsibility matters.
- State confirmed behavior directly and preserve authoritative tense and modal force.
- Use canonical terms and exact identifiers consistently.
- Exclude conversational language, rhetoric, promotion, metaphor, slang, compressed noun stacks, telegraphic prose, and empty evaluations such as `security risk`, `best practice`, `properly`, or `correctly`.
- Never use `so`, `very`, `really`, `basically`, `actually`, `obviously`, `clearly`, `simply`, `just`, `quite`, `pretty`, `a lot`, `kind of`, or `sort of` as ordinary prose; state the exact causal relation, degree, limitation, or conclusion instead.

### Local-field gate

- Apply the selected type contract and every applicable field, terminology, identifier, modality, scope, and formatting rule below.
- Count each whitespace-delimited token in field content as one word; exclude field labels.
- Keep Description within 120 words and six sentences. Exceed 120 words only when an authoritative semantic-chain unit or relationship cannot be preserved otherwise; never exceed 150 words.
- Keep Impact, when present, to exactly one complete consequence sentence of no more than 20 words. Exceed 20 words only when an authoritative impact condition or boundary cannot be preserved otherwise; never exceed 30 words.
- Keep Suggestion, when present, to exactly one complete imperative sentence of no more than 20 words. Exceed 20 words only when an authoritative remediation target or constraint cannot be preserved otherwise; never exceed 30 words.

A failed gate blocks acceptance, not the remaining workflow. Revise only the current sentence or choose a different reachable ordering. If every repair changes meaning or requires an absent unit, block the refinement.

## 4. Field contracts

### Title

Draft Title after the accepted body. It is an index, not evidence: every subject, deviation, improvement, design property, and consequence in it must already appear in accepted content. Apply the selected type's grammatical form.

Use sentence case, no terminal punctuation, no severity, and no finding-type or vulnerability label. Identify the subject and a distinguishing authoritative fact; generic labels such as `Incorrect logic`, `Potential issue`, `Security risk`, `Improve code quality`, or `Proper validation` are invalid.

Keep Title within 12 English words only when completeness permits. Preserve every authoritative Title head noun and every modifier that changes the affected operation, path, condition, mechanism, object, or scope; brevity never licenses deletion. When normalizing one modifier, change only that modifier: render `concurrent same-hash preconfirmation retries` as `concurrent preconfirmation retries for the same transaction hash`, retaining `preconfirmation`. Use a natural noun phrase or type-permitted imperative without compressed noun stacks or unnatural word-class conversion. Every occurrence of an identifier whose semantic type is supplied must place that type immediately before the identifier, using forms such as ``Function `foo()` `` or ``Contract `Vault` ``; never place the semantic type after the identifier. Do not stack a semantic type, identifier, and abstract noun as bare modifiers.

### Description

Description independently establishes the selected type's complete logic without relying on Title, Code locations, or unstated reader inference. Preserve the type-specific logical order. Put a condition before the behavior it constrains and a cause before its result. Describe behavior and relationships rather than narrating code line by line.

Use no more than six English sentences, counted by actual terminal punctuation. Each sentence has one main claim and at most one closely related subordinate claim. Brevity cannot remove a necessary object, condition, path, boundary, responsibility, result, or guarantee.

### Impact

Emit Impact only when the selected type permits it and authoritative content supplies the qualifying consequence. Use exactly one self-contained sentence stating the affected actor, asset, state, operation, or property; one concrete consequence; and every condition or boundary needed to preserve strength and scope.

Impact does not contain the root cause, full path, severity rationale, remediation, generic risk label, or a more severe theoretical consequence. It must follow from Description and cannot introduce an actor, capability, asset, condition, scope, or causal step.

### Suggestion

Emit Suggestion only when the selected type requires it. Use exactly one complete imperative sentence beginning with a precise base-form verb. State the modification target, target behavior or invariant, scope, condition, order, and lifecycle boundary needed for implementation and review.

Address the authoritative root cause, expected property, gap, or remediation goal rather than a symptom or one example input. Preserve every implementation choice left open by the input. Name an implementation only when authoritative content requires it. Do not add hardening, monitoring, testing, migration, retries, refactoring, or architecture work.

Unless authoritative content confirms deployment, frame modification before first deployment. Add migration or live-upgrade work only when supplied deployment facts require it.

### Code locations

Use only supplied, claim-bound repository evidence. Do not inspect, add, widen, narrow, or reassess a location. Include direct evidence for a material body claim or an authoritative comparison needed to establish it; exclude a location only when its supplied binding proves exact duplication or irrelevance.

Format each location as one Markdown list item containing one repo-relative minimal closed range:

```text
- path/to/File.ext:start-end
```

Do not use backticks, URLs, absolute paths, open ranges, annotations, or code excerpts. Remove exact duplicates and order locations by the first corresponding claim in Description.

Only when authoritative input explicitly establishes that no repository location applies, emit exactly one unbulleted line:

```text
Not applicable — protocol-level finding
```

or:

```text
Not applicable — no repository location
```

## 5. Terminology, identifiers, and modality

Treat Title, Description, Impact, and Suggestion as one vocabulary context. Use each supplied canonical term for its defined referent and boundary. Do not use an avoided alternative outside a quotation or exact identifier, alternate synonyms for variety, or one term for distinct referents.

Default to full ordinary technical language. Use an abbreviation or shortened form only when it is an exact identifier, authoritative project vocabulary, or established technical usage that is materially clearer. Describe relationships with ordinary grammar rather than invented labels or compound modifiers.
Input wording is presentation, not terminology authority. Treat a supplied term as canonical only when the input explicitly identifies it as project, specification, established technical, or auditor-selected vocabulary. Repetition in the source does not protect a coined expression from lossless normalization.

Audit every hyphenated prose token during the formal-prose gate and again during final validation. Retain it only when it is an exact identifier or literal, an authoritative project or specification term, or an established English technical compound whose definition matches the locked meaning. Otherwise expand it into ordinary relational grammar, such as `requests for the same transaction hash` instead of `same-hash requests`.
Do not create or retain a prose antonym by adding a negative prefix such as `non-`, `un-`, `in-`, `im-`, `il-`, `ir-`, or `dis-` to a state, identifier, project term, adjective, or participle. Apply this prohibition even when the derived word is established general English. Exact identifiers, literals, and quotations are the only exceptions. Prefer an affirmative predicate when available; otherwise state the relation explicitly with `not`, `without`, `other than`, `fails to`, or `has not`. Render `non-Waiting entries` as “entries whose state is not `Waiting`,” `unauthorized caller` as `caller without the required permission`, and `invalid signature` as `signature that fails validation`. Internal labels such as `non-security consequence` or `non-guarantee` never authorize those forms in output prose.

Express obligations directly with the responsible component or function as subject. Use `contract` for a software contract only when the Semantic Lock identifies that contract as an authoritative concept, and use it as a semantic type only for an actual contract construct. Never convert a function requirement into `the contract of the function` or `the function contract`; render the function, condition, and required behavior directly.

Wrap every project-defined identifier, exact code expression, literal configuration key or value, token name, and token symbol in backticks. Preserve spelling and case. Build an identifier inventory from the Semantic Lock and verify every occurrence in the rendered output. Every occurrence of an identifier whose semantic type is supplied must place that type immediately before the identifier. A single plural type may introduce a coordinated list of identifiers of that same type, as in ``states `Timeout`, `Canceled`, and `Failed` ``. Every function identifier must keep `()` and use forms such as ``the public function `foo()` ``; forms such as ``the `foo()` function`` and a bare `` `foo()` `` are forbidden. Apply the same order to other identifiers, including ``the contract `Vault` ``, ``the error `AlreadyAttached` ``, ``the field `inserted_at` ``, ``state `Waiting` ``, and ``notification `Pending` ``. Never place a semantic type after its identifier.

Keep the project, protocol, contract, operator, administrator, role, dependency, and affected party distinct. Preserve project feedback as project position, not a technical guarantee. Use `Ether` and `Bitcoin` for the native assets in generic prose; preserve `ETH` or `BTC` only when authoritative content uses the exact symbol or literal.

Use modals only with these meanings:

- `will`: the result necessarily follows under stated conditions;
- `can`: a demonstrated capability or reachable path;
- `may`: dependence on an unresolved external condition; and
- `could`: a supported non-certain consequence with stated conditions.

Do not use double hedges. Strong qualifiers such as `arbitrary`, `permanent`, `all`, `complete`, `severe`, `entire`, or `unlimited` require direct authority.

Use connectives only for their actual relations: `However,` for contrast; `Meanwhile,` for parallel behavior; `In addition,` for independent addition; `Therefore,` or `Thus,` for an established conclusion; `Consequently,` or `As a result,` for a direct result; `because` for cause; and `if`, `unless`, or `when` for their supplied condition. Do not begin a sentence with `Also`.

Use one space after punctuation and none before it. Use `i.e.,` for equivalence, `e.g.,` for examples, `DoS`, and `distributed DoS` only when distribution is authoritative. Do not escape underscores in Markdown or emit LaTeX.

## 6. Scope and deployment

Unless authoritative content explicitly confirms deployment, treat the audited in-scope instance as undeployed. Keep dependency deployment separate. Preserve every supplied time, version, chain, configuration, environment, and deployment boundary exactly. A plan is not a deployed fact, risk acceptance is not a guarantee, and code silence is neither a guarantee nor a non-guarantee.

## 7. Exhaustive validation

After all fields are accepted, perform four checks.

### Forward chain

For each sentence, verify that all required concepts were established earlier, its relation to the preceding sentence exists in the Semantic Lock, and its established concepts retain one meaning later.

### Backward chain

From every conclusion, Impact, rationale, conditional consequence, and Suggestion target, trace each result, cause, condition, scope, and prerequisite to an earlier sentence and then to authoritative source units.

### Bidirectional semantic comparison

Confirm that every authoritative unit remains recoverable in the output with the same authority, field responsibility, meaning, relation, condition, certainty, scope, time, and evidence binding. Confirm that every rendered unit maps back to authoritative input. Intentional field-level restatement may repeat a unit, but cannot change it.

### Mechanical envelope check

Confirm exactly one type contract; exact allowed fields and order; every required field present and non-empty; permitted optional fields only; exact labels and blank lines; Title on its label line; Description at most six sentences and 150 words, with more than 120 words used only when required for lossless semantics; Impact exactly one sentence and at most 30 words when present, with more than 20 words used only when required for lossless semantics; Suggestion exactly one imperative sentence and at most 30 words when present, with more than 20 words used only when required for lossless semantics; valid and ordered Code locations; Unix line endings; no trailing whitespace; and no wrapper, process note, placeholder, source excerpt, or extra output.
Confirm that every hyphenated prose token passed the terminology-admission test; no prose antonym uses a negative prefix; no function requirement is wrapped in an abstract `contract` noun; every occurrence of an identifier with a supplied semantic type places that type immediately before the identifier or its coordinated same-type list; no semantic type follows its identifier; and every exact identifier in the Semantic Lock has correct spelling, backticks, function parentheses, and required semantic type.

If all four checks pass, return only the complete finding. If any check fails and no unique lossless repair exists, return only the blocking line.
