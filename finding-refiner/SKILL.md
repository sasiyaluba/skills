---
name: finding-refiner
description: Refine an existing Security Issue, Recommendation, or Note into report-ready English by normalizing formatting, wording, terminology, identifiers, and field placement without changing facts, type, impact, severity, causal logic, scope, evidence, or remediation. Use when polishing or standardizing an existing finding or a finding-author draft without substantive revision.
---

# Finding Refiner

Render authoritative finding content as a standard, report-ready finding. The input may be an existing finding in any presentation or a draft from `finding-author`. Its substantive meaning is authoritative; only its presentation may change.

## Boundary

This skill performs **Render** only. It does not inspect the repository, research terminology, classify the finding, assess impact or severity, resolve audit judgments, or complete missing content.

Requests that would alter facts, finding type, impact, severity, causal logic, scope, evidence, or remediation belong to `finding-author`, regardless of how they are phrased. Lossless shortening, deduplication, cleanup, and restructuring remain Render work.

## Render

1. Identify the one explicitly selected type: `Security Issue`, `Recommendation`, or `Note`. Do not infer or change it.
2. Read `skill://finding-refiner/references/rendering.md` in full.
3. Read exactly one type contract:
   - `Security Issue`: `skill://finding-refiner/references/security-issue.md`
   - `Recommendation`: `skill://finding-refiner/references/recommendation.md`
   - `Note`: `skill://finding-refiner/references/note.md`
4. Normalize the input into the selected contract's fields, rewrite only for semantically equivalent English expression, and apply every shared rendering rule.
5. Compare the complete result with the authoritative input across every protected semantic dimension in the shared contract.

On success, return only the final finding. Do not include an introduction, change summary, reasoning, checklist, or closing text. When rendering cannot be completed without a substantive decision, return only the precise blocking line required by the shared contract.
