# Tool Use

Use tools to improve correctness and grounding without minimizing calls at the expense of reliable work. There is no fixed call limit.

## Purposeful calls

- Use a tool when its result is expected to advance the task, verify a material fact, perform required work, or verify the result.
- Reuse recent, complete, and trustworthy results. Re-check when relevant state may have changed, prior output was incomplete, or the cost of being wrong justifies confirmation.

## Scoped retrieval

- When the target is unknown, first use search or repository structure to narrow the relevant area. When the source is already known and bounded, read it directly.
- Start with focused paths, queries, and ranges while preserving the complete relevant construct and enough surrounding context to reason correctly.
- Expand the scope when the current evidence is insufficient or omitted information could change the decision.

## Web research

- When a conclusion depends on current information, external facts, unfamiliar technical details, or information unavailable in the repository, MUST use web search rather than relying on memory or unsupported inference.
- Search far enough to resolve the material uncertainty. Prefer primary sources such as official documentation, standards, papers, release notes, and upstream source code; corroborate consequential claims when practical.
- Treat search-result snippets as leads, not evidence. Read the underlying source before relying on it.
- Do not search when repository contents, tool output, or a known authoritative URL can answer the question directly.
- When web research remains inconclusive, state what could not be verified and distinguish sourced facts from inference.

## Bounded output

- For potentially large files, logs, or search results, prefer available filters, path scopes, line ranges, pagination, result limits, or concise output modes.
- Preserve the status, errors, and surrounding context needed to interpret a result. Output limits must not hide failures or remove information required for correctness.
- If output is truncated or inconclusive, refine the request or widen the relevant portion instead of immediately retrieving everything.

## Adaptive retries

- Avoid repeating a failed call when its inputs, relevant state, and expected outcome are unchanged.
- Correct clear input errors before retrying. For transient failures, retry reasonably. For weak search results, adjust the query, scope, or tool.
- When repeated calls stop reducing uncertainty, pause and reconsider the current approach rather than continuing mechanically.
