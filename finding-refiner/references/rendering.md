# Shared Rendering Contract

This contract governs the Render side of the Content/Render seam. The authoritative input is the sole source of the finding's substantive content: the explicitly selected type, facts, logic, impact, severity, evidence, remediation, terminology decisions, and metadata. Render may validate semantic equivalence and normalize presentation, but it may not establish, investigate, infer, reassess, or change any of that content.

Exactly one of these types must already be selected: `Security Issue`, `Recommendation`, or `Note`. Read and apply exactly that type's contract. The selected type contract owns its field set, field order, field responsibilities, title form, content logic, proportionality, and completion requirements.

## Rule priority

When requirements conflict, apply them in this order:

1. **Semantic Lock:** the authoritative facts, relations, type, impact, remediation goal, implementation freedom, project position, evidence, and boundaries;
2. **Type Contract:** the selected type contract;
3. **Terminology Contract:** supplied terminology, definitions, and applicability boundaries;
4. **Evidence Contract:** supplied, claim-bound evidence;
5. **Shared Hard Rules:** every `HR-*` rule in this file;
6. **Brevity:** only after the first five priorities are satisfied.

A lower-priority rule never changes higher-priority content. If two requirements at the same priority cannot both be satisfied without a substantive choice, apply HR-GATE-04.

## Semantic Lock

### HR-SEM-01: Build a semantic snapshot

Before rewriting, decompose the complete authoritative input into independently comparable semantic units. Record every supplied or protected:

- finding type;
- subject;
- expected property, current behavior, or design and trust context;
- deviation, improvement gap, or operational assumption;
- actor, role, affected party, asset, and responsible party;
- precondition, trigger, necessary order, and path boundary;
- causal, parallel, contrastive, and temporal relation;
- direct result, conditional consequence, and confirmed impact;
- scope, quantity, state, permission, timing, version, chain, configuration, and deployment condition;
- certainty, duration, and recoverability;
- remediation invariant or goal;
- confirmed implementation choice and remaining implementation freedom;
- relevant project position; and
- claim-bound evidence location.

The snapshot is not analysis. It only exposes meaning already present in the authoritative input for lossless comparison.

### HR-SEM-02: Permit only semantic equivalence

Every rendered claim must match the Semantic Lock in:

```text
subject
predicate
object
polarity
condition
modality
scope
causal role
```

Render may correct spelling, grammar, punctuation, field layout, identifier markup, and a supplied one-to-one terminology mismatch. It may reorder, split, or combine sentences only when every claim and relation remains independently recoverable. It may not add, delete, merge, split, reinterpret, strengthen, or weaken substantive claims. If the input presentation conflicts with otherwise unambiguous authoritative content, Render may restore the uniquely determined meaning; otherwise apply HR-GATE-04.

### HR-SEM-03: Preserve epistemic status

Keep confirmed repository facts and auditor-confirmed facts as facts, and keep supplied inferences as inferences. Preserve the distinctions among a current state, a plan, an accepted risk, and a technical guarantee. Never turn:

- speculation into fact;
- fact into speculation;
- a project plan into a completed state;
- risk acceptance into a technical guarantee;
- behavior not established by the code into a system guarantee or non-guarantee; or
- general industry knowledge into a project fact.

### HR-SEM-04: Preserve conditions and boundaries

Preserve every condition that affects whether the matter exists, who can trigger it, who or what is affected, the result's scope, its duration, or its recoverability. Each condition must continue to govern the same behavior or result. Never turn:

- a local result into a global result;
- a conditional result into an unconditional result;
- a recoverable result into a permanent result;
- one instance into all instances;
- a version-specific or deployment-specific fact into a permanent protocol property; or
- distinct paths with different conditions, mechanisms, or results into one path.

Temporal sequence and sentence adjacency do not establish causation.

### HR-SEM-05: Preserve causal direction

Keep the direction among cause, trigger, direct result, impact, rationale, and remediation goal unchanged. Never turn:

- a downstream symptom into the root cause;
- direct rationale into impact;
- a conditional consequence into a current defect;
- an accepted trust assumption into a recommendation;
- an example remedy into the only permitted remediation; or
- correlation into causation.

### HR-SEM-06: Preserve the selected type

The rendered finding must remain within the explicitly selected type contract. A Security Issue remains a confirmed expected-property deviation with a security consequence; a Recommendation remains a specific improvement without a fabricated security-property violation; a Note remains disclosure of accepted design, trust, guarantee-boundary, or operational context without a change request. Do not add or remove modal language, attack paths, impact, or remediation to force incompatible content into the selected type. Apply HR-GATE-04 when the authoritative content and selected type conflict.

### HR-SEM-07: Make the minimum change

Change only the smallest text necessary to satisfy the contracts. Keep wording that is already accurate, natural, and compliant. Deletion is limited to:

- exact duplication that performs no independent field responsibility;
- fields or report-level material forbidden by the selected type contract;
- internal reasoning, checklists, placeholders, drafting instructions, and presentation wrappers; and
- empty openings or risk adjectives that contain no substantive content.

Before deleting anything, establish that it carries no condition, boundary, causal role, responsibility, impact, project position, remediation constraint, or distinct field responsibility.

## Render boundary and blocking

### HR-GATE-01: Directly repair only uniquely determined presentation defects

Render may directly repair a defect only when the repair is unique and leaves the Semantic Lock unchanged. Eligible repairs include:

- field labels, spacing, capitalization, and terminal punctuation;
- unambiguous spelling, grammar, article, preposition, punctuation, and technical-collocation errors;
- backticks, function parentheses, and semantic-type placement;
- a one-to-one replacement established by supplied terminology;
- a modal correction uniquely determined by the authoritative certainty;
- active-voice conversion or sentence restructuring that preserves every relation;
- evidence-location formatting, ordering, and exact deduplication without evidentiary reassessment;
- a normalization uniquely fixed by authoritative meaning, such as generic `ETH` to `Ether` or `DDoS` to `distributed DoS`; and
- removal of forbidden empty fields, placeholders, and report-level material.

### HR-GATE-02: Block substantive completion or reconstruction

Apply HR-GATE-04 when any of the following is true:

- a Description lacks a fact or causal node required to establish its conclusion;
- an Impact is absent, unsupported, or cannot be derived from the Description and authoritative content as required by the selected type contract;
- a Suggestion does not address the authoritative root cause, gap, expected property, or remediation goal;
- a Note lacks required accepted context, operational assumption, responsibility, or boundary;
- distinct paths have been merged and restoring them requires substantive reconstruction;
- claims conflict about an actor, result, scope, timing, certainty, impact, or remediation goal;
- accurate terminology requires choosing a technical meaning not already supplied;
- a code location is missing, lacks clear claim binding, or cannot support its claim without evidence investigation;
- satisfying the six-sentence Description limit would require deleting necessary content or merging distinct claims;
- producing natural English requires choosing among technical meanings;
- a Suggestion contains alternatives that could change security, external semantics, or compatibility and their equivalence is not authoritative;
- the field set or content conflicts with the selected type; or
- fitting the selected type contract would require dropping, weakening, strengthening, or inventing substantive content.

### HR-GATE-03: Block upstream-content defects

Apply HR-GATE-04 rather than repairing any defect that belongs to Content rather than Render, including:

- a selected type incompatible with confirmed facts;
- internally contradictory authoritative facts;
- impact beyond a supported realistic path;
- undetermined product intent, responsibility, deployment status, or correct behavior;
- a missing fact, causal step, consequence, rationale, accepted context, assumption, evidence location, or remediation goal;
- a request to alter facts, type, impact, severity, causal logic, scope, evidence, or remediation; or
- any need for repository inspection, external research, audit judgment, reclassification, impact assessment, or a new remediation decision.

### HR-GATE-04: Emit one blocking line

When lossless rendering is impossible, return exactly:

```text
REFINEMENT_BLOCKED: <specific missing, conflicting, ambiguous, or substantively requested content>; use finding-author
```

Name the smallest semantic unit that blocks lossless rendering. Return no partial finding, question, alternative version, speculative repair, explanation, or additional suggestion.

## Output envelope

### HR-OUT-01: Emit only fields allowed by the selected type contract

Use the selected type contract's exact field set and order. Do not add fields, omit required fields, reorder fields, emit empty fields, or use placeholders such as `N/A`, `None`, or `TBD`. Omit an optional field only as permitted by that contract and only when it has no authoritative content. Severity remains authoritative metadata but is not emitted as a finding field. Do not emit analysis, reasoning, candidate titles, rule IDs, check results, or change notes.

### HR-OUT-02: Exclude report-level and process material

Do not emit a report title, client metadata, audit scope or version table, finding ID, status, `Introduced by`, pagination, table of contents, listings, captions, report-build material, document-review questions, standalone project-feedback fields not required by the type contract, LaTeX commands, source excerpts, or code snippets.

### HR-OUT-03: Format field labels exactly

Use only labels permitted by the selected type contract. Each label is English, bold, and followed by a colon, with this exact spelling and capitalization when applicable:

```text
**Title:**
**Description:**
**Impact:**
**Suggestion:**
**Code locations:**
```

### HR-OUT-04: Apply the shared field layout

Place the Title value on the same line as `**Title:**`. Place Description, Impact, Suggestion, and Code locations content on the line after its label, separated from the label by one blank line. Place one blank line between field blocks. Add no heading, code fence, introduction, or conclusion around the finding. Use Unix line endings and no trailing whitespace.

## Field consistency

### HR-FIELD-01: Use Title only as an index

Every Title subject, deviation, improvement, design property, and consequence must already exist in the authoritative content and agree with the Description's core. A Title introduces no additional claim.

### HR-FIELD-02: Make Description self-contained

Description must establish the selected type contract's complete logic without relying on Title, code snippets, or Code locations. Evidence locations identify evidence; they do not replace explanation.

### HR-FIELD-03: Establish Impact from Description

When the selected type contract permits Impact and authoritative content supplies it, every Impact conclusion, condition, and boundary must follow from the Description and authoritative content. Impact may summarize a consequence but may not introduce a new actor, capability, asset, scope, or causal step.

### HR-FIELD-04: Align Suggestion with the described matter

When the selected type contract permits Suggestion, its target must address the root cause, deviation, expected property, improvement gap, or remediation goal established in Description. It may not address an unestablished problem or add unrelated hardening, monitoring, testing, migration, retries, refactoring, or architectural work.

### HR-FIELD-05: Keep field responsibilities distinct

Each field performs only the responsibility assigned by the selected type contract: Description establishes facts and logic, Impact states the supplied consequence when applicable, Suggestion states the supplied target behavior when applicable, and Code locations index supplied evidence. Remove verbatim redundancy only when every field still fulfills its own responsibility.

## Title hard rules

### HR-TITLE-01: Format Title

Title uses sentence case, has no terminal punctuation, and contains neither Severity nor a finding-type or vulnerability label. Put specific code identifiers in backticks. A function identifier retains `()` and appears adjacent to `function` or `Function`.

### HR-TITLE-02: Make Title distinguishing

Title must identify the subject and a distinguishing authoritative fact. Generic titles such as the following are invalid:

```text
Incorrect logic
Improper implementation
Potential issue
Security risk
Potential risk
Improve code quality
Proper validation
```

Repair a generic Title only with information already present in the authoritative content. If that content cannot support a distinguishing Title, apply HR-GATE-04.

### HR-TITLE-03: Use natural, concise English

Title must be natural, readable, and precise, without compressed noun stacks, conversational language, promotion, exaggeration, or unnatural conversion between parts of speech. Keep it within 12 English words when doing so preserves every necessary identifier and distinguishing fact. A longer Title is valid when semantic completeness and natural expression require it.

### HR-TITLE-04: Preserve the type-specific title form

Use the grammatical form required by the selected type contract. Do not turn an issue title into an improvement command, a recommendation title into a vulnerability conclusion, or a note title into a defect, command, or unconditional consequence.

## Description hard rules

### HR-DESC-01: Enforce a six-sentence maximum

Description must contain no more than six English sentences, counted by actual terminal punctuation rather than paragraphs. Render may remove exact duplication or losslessly restructure sentences, but it may not omit necessary facts, conditions, paths, boundaries, responsibilities, or results. If the complete authoritative Description cannot fit within six sentences without semantic loss or impermissible claim merging, apply HR-GATE-04.

### HR-DESC-02: Keep one main claim per sentence

Each sentence carries one main claim and at most one closely related subordinate clause. Do not compress different actors, conditions, causal paths, or results into a sentence that cannot be checked claim by claim.

### HR-DESC-03: Preserve logical order

Use the logical order required by the selected type contract. Put a precondition before the behavior or result it constrains and a cause before the conclusion it establishes. Express contrast, parallel behavior, addition, cause, and time as their actual relations.

### HR-DESC-04: Name concrete subjects and actions

When an actor or executing component affects meaning, name it and use a concrete verb such as `stores`, `computes`, `validates`, `skips`, `accepts`, `reverts`, `overwrites`, `authorizes`, `returns`, `emits`, or `relies on`. Use an existential construction only when no concrete subject exists and existence itself is the claim. Do not hide responsibility behind constructions such as `There is`, `performs management`, or `has capabilities`.

### HR-DESC-05: Prefer active voice when responsibility matters

Use active voice and a natural subject–verb–object structure when the actor matters. Passive voice is appropriate only when the actor is unknown, irrelevant to the conclusion, or less important than the result. A voice change must preserve responsibility and certainty.

### HR-DESC-06: Keep Description self-contained and relevant

Describe behavior and relations rather than narrating code line by line. Remove investigation history, irrelevant call chains, general security knowledge, code details with no role in the finding, and version history unrelated to its fact chain, intent, scope, or deployment boundary. Brevity never permits omission of an object relation, condition, direct result, guarantee boundary, or remediation target necessary to understand the finding.

## Impact hard rules

These rules apply only when the selected type contract permits and the authoritative content supplies an Impact.

### HR-IMPACT-01: Emit exactly one complete sentence

Impact is exactly one self-contained English sentence, not a list, fragment, or sequence of consequence sentences.

### HR-IMPACT-02: State only the authoritative consequence

Impact contains only the affected actor, asset, state, operation, or security property; one confirmed concrete consequence; and any condition or boundary needed to avoid overstatement. It does not include the full root cause, attack path, code explanation, remediation, Severity, or Severity rationale.

### HR-IMPACT-03: Preserve impact strength

Keep the authoritative object, condition, scope, certainty, duration, and recoverability unchanged. Do not substitute a more severe theoretical consequence or weaken a confirmed consequence.

### HR-IMPACT-04: Require a concrete result

A value judgment or category such as `incorrect behavior`, `unexpected result`, `security risk`, `potential loss`, `better clarity`, `improved maintainability`, or `best practice` does not constitute Impact by itself. A valid Impact identifies the affected object and concrete result. If they are absent, omit Impact only when the selected type contract permits; otherwise apply HR-GATE-04.

## Suggestion hard rules

These rules apply only when the selected type contract permits and the authoritative content supplies a Suggestion.

### HR-SUG-01: Emit exactly one imperative sentence

Suggestion is exactly one complete English imperative sentence beginning with a precise base-form verb. It identifies the modification target, target behavior or invariant, and every authoritative scope, condition, order, or lifecycle boundary.

### HR-SUG-02: Make the target implementable and reviewable

Suggestion must let a developer determine the required end state and a reviewer determine whether it is satisfied. Phrases such as `Revise the logic accordingly`, `Handle the issue properly`, `Improve the code`, `Add proper validation`, and `Fix the issue` are invalid because they do not identify a concrete target and completion condition.

### HR-SUG-03: Address the root goal

Suggestion addresses the authoritative root cause, expected property, improvement gap, or remediation goal. It may not merely hide a symptom, reject one example input, or repair one known path while leaving the same root cause intact.

### HR-SUG-04: Preserve implementation freedom

State only the target and constraints when authoritative content fixes behavior but leaves implementation open. Name an implementation only when authoritative content establishes it as required. Preserve all implementation freedom left open by the input, and do not convert an invariant into an option list. Present alternatives only when their completeness, equivalence, and unchanged security, external semantics, and compatibility are authoritative. Never use `either X or Y` to conceal an unresolved product decision, add a new implementation, or turn an example into the sole requirement.

### HR-SUG-05: Preserve deployment assumptions

Unless authoritative content explicitly states that the audited in-scope instance is deployed, frame Suggestion for modification before its first deployment. Include migration, backfill, or live-upgrade work only when an explicit deployment fact requires it. A dependency may already be deployed; preserve its deployment constraint only when the remediation must modify that dependency or remain compatible with it.

## Code-location hard rules

### HR-CODE-01: Use only supplied, claim-bound evidence

Code locations come only from authoritative evidence already bound to a claim. Do not inspect the repository, add a location, or present an external specification, project statement, or auditor decision as a repository location.

### HR-CODE-02: Use the exact location format

Format each repository location as one Markdown list item with one repo-relative minimal closed range:

```text
- path/to/File.ext:start-end
```

Do not use backticks, URLs, absolute paths, open ranges, annotations, or inline code excerpts.

### HR-CODE-03: Require direct relevance

Each location must directly evidence a key repository claim in the body or an authoritative comparison necessary to establish it. Exclude a location that supplies only background, only a downstream result or Impact, an irrelevant intermediate call-chain node, a larger duplicate of the same fact, or code style alone. Render may make that exclusion only when the authoritative evidence binding uniquely establishes it; otherwise apply HR-GATE-04 rather than reassessing evidence.

### HR-CODE-04: Keep locations minimal, accurate, deduplicated, and ordered

Each range must cover the complete authoritative evidence node without unrelated adjacent code. Remove exact duplicates. Remove a larger containing range only when the authoritative evidence binding establishes that the smaller range is sufficient and no distinct evidence is lost. Order remaining locations by the first corresponding claim in Description. Preserve every distinct supplied range unless authoritative content uniquely establishes that it is redundant; if necessity or sufficiency is unclear, apply HR-GATE-04 without repository inspection, range revision, or evidentiary reassessment.

### HR-CODE-05: Use a not-applicable form only when authoritative

Only when the authoritative input explicitly establishes that no repository location applies, emit exactly one of:

```text
Not applicable — protocol-level finding
Not applicable — no repository location
```

Use the first for a protocol-level finding. Use the second for a non-protocol finding supported only by an auditor-confirmed fact, authoritative external source, or pure operational condition. Do not add a list marker, backticks, period, explanation, or other placeholder.

## Certainty and modality

### HR-MODAL-01: State confirmed behavior directly

State confirmed current behavior, deviation, gap, permission, and dependency directly with `does`, `is`, `uses`, `omits`, `allows`, or a more precise verb. Do not use `appears to`, `seems to`, or `might be` to conceal unresolved facts. Apply HR-GATE-04 when the fact itself is uncertain.

### HR-MODAL-02: Preserve modal force

Use modals only with these meanings:

- `will`: the result necessarily follows when the stated conditions hold;
- `can`: an actor or component has a demonstrated capability, or a path is demonstrated as reachable;
- `may`: the result depends on an unresolved external condition;
- `could`: the consequence is supported but non-certain, and its necessary conditions are stated.

Do not exchange these words merely for style.

### HR-MODAL-03: Remove only redundant double hedges

Do not emit `can potentially`, `may possibly`, `could potentially`, or `might possibly`. Retain the single modal expression that exactly matches authoritative certainty.

### HR-MODAL-04: Require support for strong qualifiers

Terms such as `arbitrary`, `permanent`, `all`, `complete`, `significant`, `severe`, `critical`, `entire`, and `unlimited`, and expressions of equivalent strength, require direct authoritative support. Remove a qualifier only when removal uniquely restores the authoritative meaning. Otherwise apply HR-GATE-04 rather than inventing a weaker but more specific scope.

## Terminology

### HR-TERM-01: Respect supplied terminology

Use supplied terminology for each material technical concept within its supplied definition and applicability boundary. Terminology supplies vocabulary only; it does not change facts, logic, type, impact, severity, evidence, or remediation.

### HR-TERM-02: Preserve meaning and grammatical role

Keep each term within its source meaning, technical context, and grammatical role. If a supplied specialized term would create an inaccurate or unnatural collocation in a particular sentence, use the uniquely accurate ordinary technical phrase instead. Do not distort a sentence to force a term into it.

### HR-TERM-03: Default to ordinary technical language

When no accurate specialized term is supplied, use clear, ordinary, verifiable technical language. Do not invent a vulnerability class, mechanism name, risk label, acronym, or specialized modifier.

### HR-TERM-04: Use one term per concept

Use one project term for one concept across Title, Description, Impact, and Suggestion. Stylistic variety does not justify synonym drift, and one term must not represent multiple distinct concepts.

### HR-TERM-05: Preserve established abbreviations

Use only industry-standard abbreviations or abbreviations explicitly established by authoritative content. A nonstandard abbreviation must already have an authoritative expansion before its first use. Do not invent an abbreviation or expansion.

## Identifiers and highlighting

### HR-ID-01: Put project identifiers in backticks

Wrap specific project-defined identifiers, exact code expressions, and literal configuration keys or values in backticks. This includes contracts, functions, files, variables, parameters, mappings, roles, modifiers, events, errors, structs, modules, interfaces, classes, and libraries. Do not wrap ordinary technical concepts, semantic type words, punctuation, or generic standard names.

### HR-ID-02: Format function identifiers completely

Every specific function name keeps `()`, exact spelling and case, and backticks, and appears adjacent to `function` or `Function`. Valid forms include:

```text
Function `foo()` validates ...
the function `foo()`
the `foo()` function
Functions `a()`, `b()`, and `c()`
```

Forms such as `foo`, `foo ()`, or ``function `foo` `` are invalid.

### HR-ID-03: Supply the authoritative semantic type on first use

On first use, state a supplied semantic type such as `contract`, `function`, or `variable` in ordinary text. Place it before the identifier by default or after it when natural syntax requires. Never wrap the semantic type word in backticks. If the semantic type is not authoritative and cannot be determined without investigation, apply HR-GATE-04 rather than inventing it.

### HR-ID-04: Preserve identifiers verbatim

Keep repository spelling, capitalization, underscores, and symbols exactly. Do not escape underscores, add editorial hyphens, or rename identifiers for readability.

### HR-ID-05: Distinguish prose paths from evidence paths

Wrap a specific file path in prose in backticks, such as `src/Vault.sol`. In Code locations, use the unquoted `- path:start-end` form required by HR-CODE-02.

## Project, protocol, and token names

### HR-NAME-01: Keep project and protocol referents distinct

Use `The project` for the client organization and `the protocol` for the protocol when those supplied referents are unambiguous. Never use the project organization, protocol, contract, operator, administrator, or another role interchangeably. Render a relevant project position as concise, formal third-person indirect speech while preserving its original tense, scope, and certainty.

### HR-NAME-02: Format token names and symbols accurately

Put exact token names and symbols in backticks and use one name consistently for the same token. Use `Ether` for the Ethereum native asset in generic prose and `Bitcoin` for the Bitcoin native asset in generic prose. Preserve `ETH` or `BTC` when authoritative content uses it as an exact symbol, identifier, or literal value. A token symbol already identifies the token; do not append `token` or `tokens`.

### HR-NAME-03: Do not strengthen project feedback

Risk acceptance establishes only the project's position, not a technical security property. A project plan establishes only a plan, not current deployment or permanent behavior. Preserve those limits.

## English expression

### HR-LANG-01: Use formal third-person English

Write all finding text in standard, formal, precise English and third person. Use present tense for current code, design, and mechanisms. Preserve past, perfect, or future tense only when an authoritative time relation makes it substantive. Do not use `we`, reader-directed `you`, or conversational phrasing.

### HR-LANG-02: Use natural syntax

Use natural subject–verb–object structure, articles, prepositions, and technical collocations. Avoid telegraphic compression, long noun stacks, unconventional noun-to-verb conversions, invented compound modifiers, and compressed metaphors. Rewrite wording that a fluent technical editor would regard as unnatural even when its intended meaning is guessable, but apply HR-GATE-04 if a natural rewrite requires a substantive choice.

### HR-LANG-03: Prefer concrete statements to evaluations

State concrete behavior, conditions, scope, and values rather than subjective adjectives, adverbs, or empty risk labels. Expressions such as `potential risks`, `security implications`, `significant concerns`, `best practice`, `for clarity`, `for safety`, `properly`, and `correctly` cannot replace a fact chain. Retain one only when authoritative content supplies its concrete meaning immediately and the expression remains necessary.

### HR-LANG-04: Exclude informal or promotional language

Do not use slang, promotion, exaggeration, metaphor, rhetorical questions, culturally specific idioms, or reader persuasion. A finding is a technical conclusion, not marketing or a tutorial.

### HR-LANG-05: Normalize punctuation and spacing

Use one space after punctuation and none before it. Put one space before an ordinary parenthesis and no space between a function name and its call parentheses. Use `i.e.,` for equivalence and `e.g.,` for examples. Use `DoS`; use `distributed DoS` when distribution is an authoritative substantive fact, never `DDoS`. Do not escape underscores in ordinary Markdown and do not emit LaTeX commands.

### HR-LANG-06: Use connectives according to their relation

Use `However,` for contrast, `Meanwhile,` for parallel behavior, `Furthermore,` for escalation, `In addition,` for an independent addition, `Thus,` or `Therefore,` for an established conclusion, `Consequently,` or `As a result,` for an established direct result, `because` for cause, and `if`, `unless`, or `when` for their supplied condition or trigger. A connective may not create an absent contrast, escalation, causal relation, conclusion, or temporal relation. Do not begin a sentence with `Also`.

### HR-LANG-07: Give every pronoun one antecedent

Each pronoun must have exactly one clear antecedent. When `it`, `this`, `they`, or `which` could refer to multiple things, repeat the precise component, role, state, or behavior name without changing the subject.

## Audit scope and deployment state

### HR-SCOPE-01: Treat in-scope instances as undeployed by default

Unless authoritative content explicitly confirms that an audited in-scope instance is deployed, treat the current in-scope contract as not yet deployed. Historical deployments, older versions, other project instances, and upgrade exceptions do not change this default. If the input assumes deployment without authoritative support and therefore introduces migration, existing-state, or upgrade semantics, apply HR-GATE-04 rather than merely deleting those words.

### HR-SCOPE-02: Evaluate dependency deployment separately

Keep an in-scope contract distinct from a dependency contract. A dependency may be deployed, but state its deployment constraint only when authoritative content confirms it. Never transfer a dependency's deployment state to the current audited contract.

### HR-SCOPE-03: Preserve time and version boundaries

Use qualifiers such as `currently`, a specific version, audit scope, production target, or test environment only when authoritative content supports them, and retain their exact scope. Do not convert a current plan into a permanent commitment or delete a time qualifier that changes where the conclusion applies.

## Exhaustive final validation

Validate the complete rendered finding against the complete authoritative input, not only edited phrases.

### HR-CHECK-01: Verify semantic equivalence exhaustively

Compare every semantic unit from HR-SEM-01 and confirm:

- the selected type is unchanged;
- every fact, predicate, object, and negation is unchanged;
- each actor, affected party, asset, and responsibility is unchanged;
- every condition, trigger, order, path, and boundary is unchanged;
- each causal, contrastive, parallel, and temporal relation is unchanged;
- impact, certainty, scope, duration, and recoverability are unchanged;
- remediation goals, confirmed implementation choices, and implementation freedom are unchanged;
- project position, version, configuration, time, and deployment state are unchanged; and
- every evidence location remains bound to the same claim.

If any item cannot be confirmed, the rendering is invalid and HR-GATE-04 applies.

### HR-CHECK-02: Verify structure exhaustively

Confirm all of the following:

- exactly one of the three type contracts was used and the type is unchanged;
- only that contract's fields appear, in its required order, with every required field present;
- no field is empty and no placeholder appears;
- every field performs only its assigned responsibility;
- Description is self-contained and contains at most six sentences;
- Impact, when emitted, is exactly one complete sentence;
- Suggestion, when emitted, is exactly one complete imperative sentence;
- Code locations have valid format, authoritative ranges, correct claim order, and permitted deduplication;
- no forbidden report-level material, code snippet, LaTeX, reasoning, checklist, or process note appears; and
- labels, layout, line endings, and whitespace comply with HR-OUT-03 and HR-OUT-04.

### HR-CHECK-03: Verify terminology and English exhaustively

Confirm all of the following:

- every material technical concept uses its supplied term within the supplied boundary or uniquely accurate ordinary technical language;
- one concept uses one term without synonym drift;
- every modal and strong qualifier matches authoritative certainty and scope;
- every identifier preserves spelling, parentheses, semantic type, and backticks;
- project, protocol, role, and token referents remain distinct and correctly named;
- subjects, verbs, objects, articles, prepositions, modifiers, pronouns, punctuation, and spacing are natural and unambiguous;
- conditions and connectives express only authoritative relations; and
- no informal language, promotion, empty risk label, double hedge, or unsupported strong qualifier remains.

### HR-CHECK-04: Return only the valid final result

If the original input already satisfies every rule, return the complete finding unchanged. If every violation has one lossless repair, return the complete rendered finding. If any rule cannot be satisfied losslessly or any final check cannot be established, return only the HR-GATE-04 blocking line. Never append `PASS`, `OPTIMIZED`, a summary, a rule list, or an explanation.
