# Finding Context

Build one stable context before drafting. The context keeps evidence, decisions, relationships, reader knowledge, and vocabulary aligned so that later sentences cannot silently change the finding's meaning.

## Docs-backed alignment

Read applicable project context and decision records when they exist. Treat them as evidence for the vocabulary, decisions, scope, and time boundaries they actually state, not as proof of unrelated implementation behavior.

When auditor judgment remains material, use a docs-backed grill: map unresolved decisions by dependency, ask the whole currently answerable frontier, and provide an evidence-backed recommendation for each decision. Repository facts and authoritative-source facts are investigation work, not interview questions. Lock each answer into the Finding Model immediately; do not rely on conversational memory.

Do not interview when the current instructions and evidence uniquely determine the answer. Do not modify the audited project's context or decision documents as a side effect of authoring a finding.

## Reader context

Record what the intended report reader knows before the first sentence. Keep this prerequisite set narrow. A project-specific component, role, state, guarantee, assumption, or causal relationship is unavailable until a sentence introduces it.

During drafting, maintain a grounded set. Each accepted sentence lists the concepts it requires and the concepts it establishes. A sentence is reachable only when all of its required concepts are in the audience prerequisites or the grounded set.

## Finding vocabulary

Treat Title, Description, Impact, and Suggestion as one vocabulary context. For every material referent that recurs or has multiple input names, record one canonical prose term, its precise referent, its applicability boundary, its source, and the rejected alternatives under `avoid`. Use the canonical term throughout; an avoided term may appear only in a quotation or exact identifier. Distinct referents require distinct terms.

Prefer project and dependency domain vocabulary, then controlling specifications, official technical documentation, authoritative security taxonomies, and ordinary technical language. Preserve exact identifiers verbatim, but use the canonical prose term for what each identifier denotes. Use a specialized term only when its reviewed definition matches the finding and improves precision.

Use the full ordinary term by default. Use an abbreviation or shortened form only when it is an exact identifier, established project vocabulary, or established technical usage that is materially clearer. Express relationships with ordinary grammar instead of inventing labels or compound modifiers.
Draft wording is not terminology authority. A word or phrase from a raw or existing finding becomes canonical only when project usage, a controlling source, established technical English, or an explicit auditor decision supports it.

Audit every hyphenated prose token before admitting it to the glossary. Retain it only when it is an exact identifier or literal, an established project or specification term, or an established English technical compound whose definition matches the finding. Otherwise express the relationship with ordinary grammar: use `retries for the same transaction hash`, not `same-hash retries`. Repetition in the input does not make a coined compound authoritative.
Do not create or retain a prose antonym by adding a negative prefix such as `non-`, `un-`, `in-`, `im-`, `il-`, `ir-`, or `dis-` to a state, identifier, project term, adjective, or participle. This prohibition applies even when the derived word exists in general English; only an exact identifier, literal, or quotation may retain it. Prefer an affirmative predicate when one exists, such as `occupied`; otherwise state the relation explicitly with `not`, `without`, `other than`, `fails to`, or `has not`. Write “entries whose state is not `Waiting`” rather than `non-Waiting entries`.

Terminology changes expression only. It cannot add a mechanism, property, failure mode, consequence, severity, responsibility, certainty, or remediation.

## Relationship lock

Record every prerequisite, condition, trigger, cause, result, contrast, parallel behavior, scope boundary, and responsibility needed by the selected payload. Name the two connected claims or referents and the direction of the relationship. A draft connective is valid only when this map contains the relation it expresses.

## Lock and invalidation

The Finding Context is locked when all material referents have stable meanings, the claim and relationship maps support one complete payload and thesis, and no unresolved decision can change a material sentence. New evidence or a new auditor decision reopens the context. Recompute affected conclusions and discard every accepted sentence downstream of the changed semantic unit before drafting resumes.

Context is complete when a cold reader can be led from the recorded prerequisites to the thesis without undefined concepts, terminology drift, an unstated relationship, or a decision preserved only in conversation.

