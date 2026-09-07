# Concise conversational AI responses

## Decision-support findings

The desired behavior is better described as **minimum sufficient information per turn** than “minimum information density.” Lower density and shorter length conflict literally: explaining the same content less densely takes more words. The useful target is a short first layer that is easy to process, with optional depth disclosed later.

### Evidence-backed mechanisms

1. **Observable output contract.** Microsoft recommends simple, short bot writing and explicit instructions for verbosity, format, atomic tasks, and one clarifying question at a time. A measurable response shape is more reliable than “be concise.”
   - [Microsoft: Writing for bots](https://learn.microsoft.com/en-us/style-guide/chatbots-virtual-agents/writing-bots)
   - [Microsoft: Write effective instructions for declarative agents](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/declarative-agent-instructions)

2. **One conversational move per turn.** Google’s conversation-design guidance says to ask one question at a time, stop after the question, and initially present only details required to proceed. GOV.UK similarly recommends one question per page to focus attention.
   - [Google: Questions](https://developers.google.com/assistant/conversation-design/questions)
   - [Google: Language](https://developers.google.com/assistant/conversation-design/language)
   - [GOV.UK: Question pages](https://design-system.service.gov.uk/patterns/question-pages/)

3. **Progressive disclosure, not omission.** Optional examples, extra models, background, and edge cases can wait. Decision-critical risks, assumptions, and caveats cannot. GOV.UK warns against hiding information most users need; Carbon warns that hidden content can be missed.
   - [GOV.UK: Details](https://design-system.service.gov.uk/components/details/)
   - [Carbon: Accordion](https://carbondesignsystem.com/components/accordion/usage/)
   - [Carbon: Disclosures](https://carbondesignsystem.com/patterns/disclosures-pattern/)

4. **Semantic chunking.** W3C recommends putting the point first, using short blocks, one topic per paragraph, and lists for genuinely related items. Cognitive research supports limited working-memory capacity, but does not justify a universal word or bullet limit for AI answers.
   - [W3C WAI: Keep text succinct](https://www.w3.org/WAI/WCAG2/supplemental/patterns/o3p05-succinct-text/)
   - [Cowan 2001: The magical number 4 in short-term memory](https://pubmed.ncbi.nlm.nih.gov/11515286/)
   - [Sweller 1988: Cognitive load during problem solving](https://doi.org/10.1207/S15516709COG1202_4)

Google’s cited Conversational Actions product is retired; its pages are used only as interaction-design guidance. Numeric response limits are prompt-design choices to evaluate, not scientific constants.

## Candidate rule

> Lead with the most useful insight, decision, or next move. Give only the information needed for that conversational move—normally one short paragraph or at most three bullets—then stop. If missing information would materially change the answer, ask exactly one focused question and end the turn. Expand when the user asks or the next step requires it. Never defer a risk, assumption, or caveat that could change the decision.

This should be reconciled with existing `thinking-partner` rules that currently require offering 2–3 models up front and a four-part closing; merely appending the rule would leave conflicting instructions.
