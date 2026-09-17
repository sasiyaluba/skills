---
name: finding-writer
description: Write audit-report findings as Issues, Recommendations, or Notes. Use when drafting or rewriting a finding for an audit report reader.
---

# Finding 写作

面向审计报告读者，将已经确认的事实组织成简洁、连续、可判断的 Finding。只保留读者理解问题、判断影响和采取行动所需的信息。

## 写作准备

默认将当前工作目录视为项目目录。

### 术语搜集

根据用户提供的信息，从当前项目和网络中轻量搜集当前 Finding 所需的术语。优先采用项目代码和文档中的名称；需要确认通用概念、协议术语、上游行为或正式英文表达时，使用网络搜索辅助，并优先参考官方文档、规范和上游资料。

只搜集当前 Finding 实际使用的术语。每个重复出现的概念必须确定一个标准名称，并在全文保持一致。

### 信息搜集

根据用户提供的信息，在当前项目目录中进行轻量的信息搜索和事实确认。用户没有提供具体位置时，根据相关名称、行为或代码对象定位实现。只有当前信息不足以支持完整因果链时，才继续查看相关调用、配置、测试或项目文档。

当问题、必要条件、直接结果，以及适用时的 Impact 和 Suggestion 已有足够依据时停止搜集。不得扩展调查当前 Finding 之外的相邻问题。

## Finding 类型

- **Issue**：已确认的实现不一致，并且能够推出具体不良后果。包含 `Title`、`Description`、`Impact` 和 `Suggestion`。
- **Recommendation**：已确认存在值得修复或改进的问题，但不作为明确不一致问题报告。包含 `Title`、`Description` 和 `Suggestion`。
- **Note**：需要向报告读者披露的信息、条件、限制或风险，不要求项目采取修复措施。包含 `Title` 和 `Description`。

Issue 也包含 Suggestion，因此 Issue 与 Recommendation 的区别不是是否建议修复，而是 Finding 是否建立了明确的不一致及其后果。

## Description

Description 通过一条连续的因果链，让读者依次理解：

1. **上下文**：建立理解问题所需的对象、行为或比较基准。
2. **问题**：明确实际行为与正确行为之间的差异，或者当前实现存在的缺口。
3. **因果过程**：说明该问题在相关条件下如何影响后续行为。
4. **直接结果**：收束到系统最终表现出的错误行为、限制或风险。

Description 典型为 4 句话，最多为 6 句话；因果链较短时可以少于 4 句话。当一个职责包含多个必须分别建立的语义关系时，将其拆成独立句子；增加的句子只能补全必要的因果环节，不能添加一般背景、重复结论或提前展开 Impact。不得为了满足典型结构拆分本可清楚表达的内容，也不得为了缩短篇幅省略读者无法自行确定的中间关系。

每句话只承担一个主要语义职责：建立一个后文需要使用的事实，说明两个已建立事实之间的关系，或者从前文条件推导一个直接结果。一句话可以包含多个语法成分，但它们必须共同表达同一个关系；下一句话必须直接建立在当前句已经完成的语义之上。

## Impact

Impact 仅用于 Issue，固定为 1 句话，说明 Description 中的直接结果最终会对安全性、正确性、可用性或用户行为造成什么具体后果。

- 只使用 Description 已经建立的事实和因果关系。
- 不重复实现细节，不引入新的触发条件或推导步骤。
- 明确受影响的对象和具体后果。
- 使用与证据一致的确定性，不将可能结果写成必然结果。
- 避免无法帮助读者判断严重性的空泛表述。

## Suggestion

Suggestion 用于 Issue 和 Recommendation，固定为 1 句话，说明应当采取什么修改，以消除 Description 中的问题并恢复所需行为。

- 直接对应 Description 中的问题根因。
- 明确修复后必须成立的行为或性质。
- 保留不影响修复目标的实现自由。
- 多个动作只有在共同服务于同一个修复目标时才能并列。
- 不加入与当前 Finding 无关的额外改进。

## Title

Title 在正文完成后拟写，不得引入新的事实、影响或修复要求。

- 通常约为 10 个英文单词，最多 15 个英文单词；完整表达核心信息时可以更短。
- 使用 sentence case，不添加句号，只保留一个主要问题、修复动作或披露主题。
- 仅在能够实质缩小范围时加入函数、组件或流程名称。
- 删除严重性、状态和空泛措辞；`Potential` 只用于正文确实保留不确定性的情况。
- **Issue** 使用陈述性名词短语，概括核心问题及必要范围，例如 “Incorrect `Operator` list in the rotation pre-signing process”。
- **Recommendation** 使用祈使句，表达修复动作及目标，例如 `Validate recipient addresses before updating tax allocations`。
- **Note** 使用中性名词短语；命中固定主题时必须使用登记的标准标题。

当前固定 Note 标题：

- `Potential centralization risk`
- `Reliance on trusted off-chain logic`

## 写作要求

- 每句话只能包含一个主句和最多一个从句。
- 不使用分号连接多个判断；多个判断必须拆成独立句子。
- 所有代码标识符必须使用 Markdown 行内代码格式包裹。
- 所有项目特定角色必须使用行内代码格式包裹，例如 `Operator`、`Broadcaster Administrator` 和 `EmergencyRole`。
- 所有合约相关对象必须使用行内代码格式包裹，包括合约、函数、变量、参数、事件、错误、修饰器、结构体、枚举及枚举值。
- 每次提及函数时，必须使用 `the function` 或 `function` 加函数标识符，例如 the function `transfer()`。
- 每次提及合约时，必须使用 `the contract` 或 `contract` 加合约标识符，例如 the contract `Portal`。
- 通用角色不使用行内代码格式，例如 user、attacker 和 administrator。
- 通用技术术语和标准名称不使用行内代码格式，例如 blockchain、transaction、ERC-20 和 JSON-RPC。
- Issue 可以使用 `incorrect`、`inconsistent`、`fails to`、`missing` 和其他明确的问题措辞。
- Recommendation 不得使用 `incorrect`、`flawed`、`vulnerable`、`exploit`、`attack` 或其他表示 Issue 强度的措辞。
- Note 不得使用 `incorrect`、`fails to`、`must fix`、`should change` 或其他表示实现错误或要求修复的措辞。
- 全文必须使用正式书面英语，不得使用口语、填充词、模糊限定词或主观强调词。
- 不使用 `so`、`so that`、`very`、`some`、`a lot of`、`things`、`stuff`、`kind of`、`basically`、`actually`、`just`、`pretty`、`really`、`maybe`、`somehow`、`obviously` 或 `clearly`。
- 同一个对象、行为、状态或角色必须始终使用同一个名称，不得使用同义词替换项目术语。
- 每句话必须有明确主语，不得单独使用指代不清的 `it`、`this`、`they` 或 `these`。
- 已确认的事实使用确定语气；只有依赖条件或存在真实不确定性时才使用 `may`、`might`、`could` 或 `potential`。
- 已知行为主体时使用主动语态；只有行为主体未知或与结论无关时才使用被动语态。
- 不使用缩写形式，例如使用 `does not` 而不是 `doesn't`。
- 缩写首次出现时必须给出完整名称；报告 Introduction 已定义的缩写除外。
- 不使用第一人称、第二人称、反问句或面向读者的口语表达。
- 不使用 `etc.`、`and so on` 或其他开放式列举。
- 不在括号中承载关键事实、条件或结论。

## 写作流程

1. 确认用户指定的 Finding 类型；用户未指定 Issue、Recommendation 或 Note 时，必须向用户确认，不得自行选择。
2. 从用户提供的信息、当前项目和必要的网络资料中轻量搜集术语，并确定全文使用的标准名称。
3. 根据用户提供的信息，在当前项目中轻量搜索并确认支撑 Finding 所需的事实。
4. 锁定上下文、问题、必要条件、直接结果，以及适用时的最终影响和修复目标。
5. 按因果顺序构造 Description，并逐句确认语义职责和前后关系。
6. Issue 写 Impact；Issue 和 Recommendation 写 Suggestion。
7. 从完成的正文提取 Title，并应用对应类型的标题规则。
8. 删除重复和无关背景，确认压缩没有破坏因果链。

## 完成标准

- 用户已明确确认 Finding 类型，且字段集合与该类型一致。
- Description、Impact、Suggestion 和 Title 均通过各自的内容与长度契约。
- Description 因果连续，每句话只有一个主要语义职责。
- Title 与正文指向同一个核心。
- 全文满足写作要求。
- 报告读者无需自行补充关键前提或中间推导。
