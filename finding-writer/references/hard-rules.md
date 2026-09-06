# Finding Hard Rules

本文件定义最终优化器对所有 Finding Type 统一执行的硬性规则。它整合了旧共享样式规则，并以以下三个当前 drafting reference 为分支依据：

- `finding-writer/references/issue-drafting.md`；
- `finding-writer/references/recommendation-drafting.md`；
- `finding-writer/references/note-drafting.md`。

本文件使用中文说明规则，但最终 Finding 的报告文本必须使用英文。

## 1. 适用范围

最终优化器只处理已经完成分类、分析、术语研究和 drafting 的 Finding。它接收：

- 已选定的 Finding Type；
- Authoritative Brief Set；
- `Terminology Brief`；
- selected branch 的输出契约；
- 完整 Draft。

`Authoritative Brief Set` 由已确认的 Finding Type、`Fact Brief`、已有的可选 `Impact Brief`，以及审计人员明确确认的控制性决定组成。下文单独写 `Brief` 时，均指这一集合。

最终优化器的职责只有两项：

1. 修复违反本文件的格式、术语、语法和表达问题；
2. 验证修复后的文本与上游语义完全一致。

最终优化器不承担以下职责：

- 重新分类 Finding；
- 重新调查代码、规范或外部资料；
- 补全缺失的事实、因果节点、Impact、责任方或修复目标；
- 重新评估 Impact 或 Severity；
- 选择产品语义、协议设计或修复方案；
- 把一个分支改写成另一个分支；
- 为了改善文风而重构已经正确的 Finding。

## 2. 规则优先级

发生冲突时，按以下顺序处理：

1. **Semantic Lock**：Authoritative Brief Set 已确定的事实、逻辑、分类、Impact 和修复目标；
2. **Branch Contract**：selected branch drafting reference 的输入要求、Title 形式与内容规则、content logic、output fields、字段顺序与职责、proportionality rules 和完成检查；
3. **Terminology Contract**：`Terminology Brief` 已确定的专业术语、含义和适用边界；
4. **Evidence Contract**：Authoritative Brief Set 中与主张绑定的 Evidence；
5. **Hard Rules**：本文件规定的共享格式和表达规则；
6. **Brevity**：在前五项全部满足后的精简。

低优先级规则不得改变高优先级内容。不能同时满足两项同级硬规则时，优化器必须停止并返回上游，不得自行选择一种解释。

## 3. Semantic Lock

### HR-SEM-01：建立语义快照

修改 Draft 前，优化器必须从 Authoritative Brief Set 提取语义快照。至少记录所有已出现或应保持不变的：

- Finding Type；
- Subject；
- Expected Property、Current Behavior 或 Design / Trust Context；
- Deviation、Improvement Gap 或 Operational Assumption；
- actor、role、affected party、asset 和 responsible party；
- Preconditions、Trigger 和必要执行顺序；
- 因果关系、并行关系、对照关系和路径边界；
- Immediate Result、Conditional Consequence 和 Confirmed Impact；
- 范围、数量、状态、权限、时机、版本、链、配置和部署条件；
- 结果的确定性、持续时间和可恢复性；
- Remediation Invariant 或 Remediation Goal；
- 已确认的实现选择及仍被保留的实现自由；
- Relevant Project Position；
- 每项仓库主张对应的 Evidence。

语义快照不是新的分析结果。它只把上游已经确定的内容拆成可逐项比较的语义单位。

### HR-SEM-02：只允许等义改写

修改后的每项主张必须与 Semantic Lock 一致。若原 Draft 已与 Semantic Lock 一致，修改前后的主张必须在以下维度完全相同：

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

若原 Draft 在某一维度违反 Brief，只有当 Brief 唯一确定正确表达时，优化器才可把该维度恢复为 Semantic Lock。优化器可以修正语法、搭配、标点、字段格式、标识符格式和明确的一对一术语错误，但不得增加、删除、合并、拆分或重新解释实质主张。

### HR-SEM-03：保留事实状态

仓库证据和审计人员明确确认的事实仍写成事实；上游保留的 inference 仍写成 inference。优化器不得：

- 把推测改成事实；
- 把事实弱化成猜测；
- 把项目计划改成已经发生的状态；
- 把风险接受改成技术保证；
- 把代码没有建立的行为改成系统保证或非保证；
- 用一般行业知识补充项目事实。

### HR-SEM-04：保留条件和边界

任何会改变问题是否成立、谁能触发、谁受影响、结果范围、持续时间或可恢复性的条件都必须保留。条件必须继续约束原来的行为或结果。

优化器不得：

- 把局部结果写成全局结果；
- 把有条件结果写成无条件结果；
- 把可恢复结果写成永久结果；
- 把一个实例写成全部实例；
- 把当前版本或部署范围写成永久协议性质；
- 把多个具有不同条件、机制或结果的路径合并；
- 把相邻句子的时间顺序当作因果关系。

### HR-SEM-05：保留因果方向

原因、触发、直接结果、Impact 和修复目标之间的方向不得改变。优化器不得把：

- 下游症状改写成 Root Cause；
- Direct Rationale 改写成 Impact；
- Conditional Consequence 改写成当前缺陷；
- 项目接受的信任假设改写成 Recommendation；
- 修复示例改写成唯一 Remediation Goal；
- 相关关系改写成因果关系。

### HR-SEM-06：保留分支语境

优化后的 Finding 必须继续符合 selected branch：

- Security Issue 仍明确陈述已经证实的预期偏差及安全后果；
- Recommendation 仍表达具体改进，不构造安全属性违反；
- Note 仍披露已接受的设计、信任或运行条件，不提出修改要求。

发现 Draft 与 Authoritative Brief Set 或 selected branch 不兼容时，返回 drafting 或 classification 阶段。优化器不得通过增删 `should`、`may`、攻击路径或 Impact 来维持错误分类。

### HR-SEM-07：最小修改

只修改违反硬规则的最小文本范围。已经正确、自然且符合契约的句子保持原样。删除内容只限于：

- 完全重复且不承担独立字段职责的信息；
- branch contract 明确禁止的字段或报告级材料；
- 内部推理、检查表、占位符和 drafting 说明；
- 不包含任何项目事实的空泛开场或风险形容词。

删除前必须确认该内容不承担条件、边界、因果、责任、Impact 或修复职责。

## 4. 可修复与必须返回上游的边界

### HR-GATE-01：优化器可直接修复

只有修复结果唯一且不改变 Semantic Lock 时，优化器可以直接修改，例如：

- 字段标签、空行、大小写和句末标点；
- 明确的拼写、语法、冠词、介词和搭配错误；
- 反引号、函数括号和语义类型的位置；
- `Terminology Brief` 已确定术语的一对一替换；
- 与证据确定性完全对应的情态动词错误；
- 不改变逻辑的主动语态转换或句子拆分；
- Code locations 的路径格式、排序和完全重复项；
- 由 Semantic Lock 唯一确定的固定规范化，例如把泛指原生资产的 `ETH` 写为 `Ether`，或把 `DDoS` 写为 `distributed DoS`；
- 删除 branch contract 不允许的空字段、占位符和报告级材料。

### HR-GATE-02：以下情况必须返回 drafting

出现以下任一情况，优化器不得自行补写或重构：

- Description 缺少建立结论所需的事实或因果节点；
- Impact 无法从 Description 和 Brief 推出；
- Suggestion 没有处理已确认的 Root Cause 或 Gap；
- Note 缺少接受依据、Operational Assumption 或必要边界；
- 多条路径被错误合并，恢复它们需要重新组织实质内容；
- Draft 与 Brief 对 actor、结果、范围、时机、确定性或修复目标存在冲突；
- Draft 使用 `Terminology Brief` 未建立的专业标签，且无法在不选择新技术含义的前提下改成唯一、准确的普通技术表达；
- Code locations 缺少必要 Evidence，或现有范围不能证明正文主张；
- 为满足六句上限必须删除必要事实或合并不同主张；
- 修正不自然英语需要选择不同的技术含义；
- Suggestion 中存在多个会改变安全性、外部语义或兼容性的备选方案；
- Draft 的字段集合或内容表明 Finding Type 可能错误。

### HR-GATE-03：以下情况必须返回 classification、fact grounding 或 impact assessment

当问题来自上游结论而不是 Draft 表达时，必须返回对应的现有上游阶段：

- Finding Type 与已确认事实不兼容；
- Brief 内部事实相互矛盾；
- Impact 超出事实支持的现实路径；
- 产品预期、责任分配、部署状态或正确实现仍未确定；
- 需要新的代码调查、外部研究或审计人员确认才能修复。

### HR-GATE-04：阻塞输出

无法无损修复时，只返回：

```text
OPTIMIZER_BLOCKED: <HR rule ID>: <必须返回的阶段及具体原因>
```

原因必须指出冲突的语义单位或缺失信息。不得返回部分优化的 Finding、备选版本、猜测性修复或额外建议。

## 5. 输出封装

### HR-OUT-01：只输出 branch contract 允许的字段

输出必须完整遵循 selected branch 的字段集合和字段顺序。优化器不得：

- 新增字段；
- 删除 branch contract 要求的字段；
- 调换字段顺序；
- 输出空字段；
- 使用 `N/A`、`None`、`TBD` 或其他占位符；
- 把 Severity 写入 Finding 文本字段；
- 输出分析、推理、候选标题、规则编号、检查结果或修改说明。

可选字段只有在 Authoritative Brief Set 和 branch contract 同时允许时保留。没有内容时，字段标签和相关空行全部省略。

### HR-OUT-02：禁止报告级材料

Finding 不包含：

- report title；
- client metadata；
- audit scope 或 version table；
- Finding ID；
- Status 或 Introduced by；
- pagination 或 table of contents；
- listings、captions 或 report build 内容；
- document-review questions；
- 独立的项目反馈字段，除非 branch contract 明确要求；
- LaTeX 命令；
- 代码片段。

### HR-OUT-03：字段标签

每个字段标签使用英文、加粗并带冒号：

```text
**Title:**
**Description:**
**Impact:**
**Suggestion:**
**Code locations:**
```

只输出 selected branch 允许的标签。标签拼写和大小写必须与 branch contract 完全一致。

### HR-OUT-04：字段布局

- Title 值与 `**Title:**` 位于同一行；
- Description、Impact、Suggestion 和 Code locations 的内容位于标签下一行，并与标签之间保留一个空行；
- 相邻字段块之间保留一个空行；
- 不在 Finding 前后添加标题、围栏代码块、说明或结语；
- 不保留行尾空格；
- 使用一致的 Unix 换行。

## 6. 字段间一致性

### HR-FIELD-01：Title 是索引，不是额外主张

Title 中的 Subject、缺陷、改进动作、设计属性或后果必须已经出现在 Authoritative Brief Set，并与 Description 的核心完全一致。Title 不得引入正文和 Brief 没有的新结论。

### HR-FIELD-02：Description 必须独立成立

Description 必须在不依赖 Title、代码片段或 Code locations 的情况下，完整建立 selected branch 要求的逻辑。Code locations 只能定位证据，不能替代解释。

### HR-FIELD-03：Impact 必须由 Description 建立

存在 Impact 时，Impact 中的每个结论、条件和边界都必须能从 Description 和 Brief 推出。Impact 可以总结后果，但不得引入新的 actor、能力、资产、范围或因果步骤。

### HR-FIELD-04：Suggestion 必须对应已描述的问题

存在 Suggestion 时，其目标必须准确处理 Description 已建立的 Root Cause、Deviation 或 Improvement Gap。Suggestion 不得处理正文没有建立的新问题，也不得附加无关 hardening、监控、测试、迁移、重试、重构或架构调整。

### HR-FIELD-05：字段不得相互替代

- Description 负责建立事实和逻辑；
- Impact 负责单句陈述后果；
- Suggestion 负责给出目标行为；
- Code locations 负责定位证据。

优化器应删除逐字重复，但不得因为“去重”而删除某个字段履行自身职责所需的信息。

## 7. Title 硬规则

### HR-TITLE-01：格式

Title 必须：

- 使用 sentence case；
- 不以句号或其他终止标点结尾；
- 不包含 Severity；
- 不包含 `Security Issue`、`Recommendation`、`Note`、`vulnerability` 等 Finding Type 标签；
- 将具体代码标识符放入反引号；
- 在提及函数时保留 `()`，并使 `Function` 或 `function` 与函数标识符相邻。

### HR-TITLE-02：信息量

Title 必须包含足以区分当前 Finding 的 Subject 和区别性事实。不得使用以下无法识别当前 Finding 的泛化标题：

```text
Incorrect logic
Improper implementation
Potential issue
Security risk
Potential risk
Improve code quality
Proper validation
```

优化器只能用 Brief 已有信息修正泛化标题。Brief 信息不足以形成区别性 Title 时，返回 drafting。

### HR-TITLE-03：自然表达

Title 使用自然、可读、信息明确的英语。不得使用压缩名词堆叠、口语、营销措辞、夸张形容词或不自然的词性转换。

在不删除必要标识符或区别性事实时，Title 应控制在 12 个英文单词以内。超过 12 个单词不是自动删词或阻塞理由；如果无法在保持自然表达和全部必要区别性信息的情况下缩短，允许 Title 超过 12 个英文单词。

### HR-TITLE-04：遵守分支形式

Title 的语法形式由 selected branch 决定。优化器不得把：

- Security Issue 的缺陷或后果标题改成改进命令；
- Recommendation 的改进标题改成漏洞结论；
- Note 的中性设计或条件标题改成缺陷、命令或无条件后果。

## 8. Description 硬规则

### HR-DESC-01：句数

Description 最多六个英文句子。句子按实际终止标点计算，不按段落计算。

优化器可以删除完全重复内容或拆分、合并等义表达来满足上限，但不得删除必要事实、条件、路径、边界、责任或结果。无法无损满足六句上限时，返回 drafting。

### HR-DESC-02：一个句子一个主要主张

每个句子只承载一个主要主张和最多一个紧密相关的从属从句。不同 actor、不同条件、不同因果路径或不同结果不得压入一个难以验证的句子。

### HR-DESC-03：逻辑顺序

事实按 selected branch 的逻辑顺序表达。前置条件必须出现在其约束的行为或结果之前；原因必须先于由其推出的结论；对照、并行和补充关系不得伪装成因果关系。

### HR-DESC-04：具体主体和动词

当 actor 或执行组件影响理解时，句子必须明确写出主体。使用具体动词描述行为，例如：

```text
stores
computes
validates
skips
accepts
reverts
overwrites
authorizes
returns
emits
relies on
```

避免用 `There is`、`There are`、`performs management`、`has capabilities` 等结构隐藏实际主体或行为。只有在不存在具体主体且存在性本身就是主张时，才保留存在句。

### HR-DESC-05：主动语态

actor 重要时使用主动语态和自然的 subject–verb–object 结构。被动语态只有在 actor 未知、与结论无关，或结果确实是句子焦点时才保留。语态转换不得改变责任归属或确定性。

### HR-DESC-06：自包含

Description 必须说明行为和关系，而不是逐行翻译代码。删除调查历史、无关调用链、一般安全常识、只为展示代码细节而存在的内容，以及与 Finding 的事实链、设计意图、适用范围或部署边界无关的版本历史或版本演变。

不得为了简短省略理解 Finding 所需的对象关系、条件、直接结果、保证边界或修复目标。

## 9. Impact 硬规则

本节只在 selected branch 允许并实际输出 Impact 时适用。

### HR-IMPACT-01：恰好一个句子

Impact 必须是一个完整、可独立理解的英文句子，不得使用列表、句子片段或多个后果句。

### HR-IMPACT-02：只陈述已确认后果

Impact 只包含：

- 受影响的 actor、asset、state、operation 或 security property；
- 一个已确认的具体后果；
- 防止夸大的必要条件或边界。

Impact 不包含完整 Root Cause、攻击路径、代码解释、Suggestion、Severity 或 Severity rationale。

### HR-IMPACT-03：保持强度

Impact 与上游已确认结论保持相同的对象、条件、范围、确定性、持续时间和可恢复性。优化器不得选择更严重的理论后果，也不得为了语气温和而弱化确定后果。

### HR-IMPACT-04：不把价值或类别当作后果

以下内容不能单独构成 Impact：

```text
incorrect behavior
unexpected result
security risk
potential loss
better clarity
improved maintainability
best practice
```

它们没有给出受影响对象和具体结果。缺少具体后果时，优化器不得编造；应按 branch contract 省略可选 Impact，或返回 drafting 处理必需 Impact。

## 10. Suggestion 硬规则

本节只在 selected branch 允许并实际输出 Suggestion 时适用。

### HR-SUG-01：恰好一个祈使句

Suggestion 必须是一个完整的英文祈使句，以准确的原形动词开头。句子必须写明：

- 修改对象；
- 目标行为、约束或不变量；
- 必要的范围、条件、顺序或生命周期时机。

### HR-SUG-02：可实施且可复核

开发者必须能够仅凭 Suggestion 判断需要达到什么状态，复核人员必须能够判断目标是否完成。禁止使用：

```text
Revise the logic accordingly.
Handle the issue properly.
Improve the code.
Add proper validation.
Fix the issue.
```

`logic`、`properly`、`accordingly` 等词不能替代具体对象和完成条件。

### HR-SUG-03：处理根本目标

Suggestion 必须处理 Brief 已确认的 Root Cause、Expected Property、Improvement Gap 或 Remediation Goal。不得只隐藏症状、阻断一个示例输入或修复一条已知路径而保留同一根因。

### HR-SUG-04：保留实现自由

- Brief 只确定目标行为时，Suggestion 只描述目标和约束；
- Brief 已证明只有一个正确实现时，Suggestion 可以写明该实现；
- 对 Security Issue，Suggestion 表达 Remediation Invariant，并保留未被 Brief 排除的实现自由；不得把不变量改写成实现选项列表；
- 对 Recommendation，只有多个方案已被证明完整、等价且不改变安全性、外部语义或兼容性时，才可列出备选方案；
- `either X or Y` 不得用于掩盖未解决的产品决策。

优化器不得自行增加一种实现，也不得把示例实现改成唯一要求。

### HR-SUG-05：部署状态

除非 Brief 明确说明 audited in-scope instance 已经部署，否则 Suggestion 针对审计源代码首次部署前的修改。只有存在明确部署事实时，才保留 migration、backfill 或 live-upgrade 步骤。

依赖合约可能已经部署；只有当修复需要改变依赖或保持与其兼容时，才保留依赖合约的部署约束。

## 11. Code locations 硬规则

### HR-CODE-01：证据来源

Code locations 只能来自 Authoritative Brief Set 中与主张绑定的 Evidence。优化器不得通过重新搜索仓库增加位置，也不得把外部规范、项目反馈或审计人员确认伪装成代码位置。

### HR-CODE-02：格式

每个位置使用一个 Markdown 列表项和一个 repo-relative 最小闭区间：

```text
- path/to/File.ext:start-end
```

路径不得使用反引号，不得使用 URL、绝对路径、开放区间、单独行号以外的说明或行内代码片段。

### HR-CODE-03：相关性

每个位置必须直接证明正文中的关键仓库主张，或证明建立差异所必需的对照。排除：

- 只提供背景的位置；
- 只证明下游结果或 Impact 的位置；
- 与主张无关的调用链中间节点；
- 重复证明同一事实的更大范围；
- 只展示代码风格的位置。

### HR-CODE-04：最小、准确、去重、排序

范围必须覆盖完整证据节点，同时不包含无关相邻代码。完全重复或被更小充分范围包含的位置删除。保留多个位置时，按 Description 首次使用对应事实的顺序排列。

如果两个范围是否都必要无法从 Brief 判断，返回 drafting；优化器不得自行重新评估证据。

### HR-CODE-05：无仓库位置的 Finding

只有 Authoritative Brief Set 明确确认不存在具体仓库位置时，才使用 not-applicable 形式：

- 协议级 Finding 写为 `Not applicable — protocol-level finding`；
- 由审计人员确认、权威外部来源或纯运行条件支持，且不属于协议级 Finding 时，写为 `Not applicable — no repository location`。

输出上述文本时不使用列表项、反引号、句号、解释或其他占位符。

## 12. 确定性与情态动词

### HR-MODAL-01：确定行为直接陈述

已证实的当前行为、缺陷、Gap、权限或依赖使用直接陈述，例如 `does`、`is`、`uses`、`omits`、`allows` 或准确的具体动词。

不得使用 `appears to`、`seems to` 或 `might be` 隐藏尚未解决的事实问题。事实确实不确定时返回上游。

### HR-MODAL-02：情态动词映射

- `will`：所列条件成立后，结果必然发生；
- `can`：actor 或组件具有已经证明的能力，或已证明路径可达；
- `may`：结果取决于未固定的外部条件；
- `could`：后果合理但非确定，并且必要条件已经说明。

优化器不得在这些词之间仅为“语气更自然”而替换。

### HR-MODAL-03：禁止双重弱化

禁止：

```text
can potentially
may possibly
could potentially
might possibly
```

保留一个与证据匹配的情态表达。

### HR-MODAL-04：强限定词需要直接支持

以下词以及同等强度的表达必须有 Brief 直接支持：

```text
arbitrary
permanent
all
complete
significant
severe
critical
entire
unlimited
```

缺少支持时，优化器不得自行猜测较弱但具体的新范围。若删除该词即可恢复 Brief 原义，则删除；否则返回 drafting。

## 13. 术语

### HR-TERM-01：术语来源

每个 material technical concept 必须使用 `Terminology Brief` 已建立的专业术语。`Terminology Brief` 只提供词汇证据，不改变 Authoritative Brief Set 的事实、逻辑、分类、Impact 或 remediation。

### HR-TERM-02：含义和语法角色

术语必须保持其来源定义、适用场景和语义边界。不得因为来源使用某个词，就把它移植到不同的语法角色或技术语境。

若专业术语在当前句子中会形成不自然或错误搭配，使用准确的普通技术短语；不得扭曲句子迁就术语。

### HR-TERM-03：没有术语时使用普通语言

`Terminology Brief` 没有建立准确术语时，使用清楚、普通、可验证的技术语言。不得创造新的漏洞类别、机制名称、风险标签或专业化修饰语。

### HR-TERM-04：一概念一术语

同一概念在 Title、Description、Impact 和 Suggestion 中使用同一项目术语。不得为了避免重复而更换同义词，也不得用同一个词表示多个不同概念。

### HR-TERM-05：缩写

只使用行业通用缩写或 `Terminology Brief` 已明确建立的缩写。非通用缩写首次出现时必须已有上游定义；优化器不得自行扩写或创造缩写。

## 14. 标识符与高亮

### HR-ID-01：项目标识符使用反引号

以下具体项目定义的标识符、精确代码表达式和字面配置值使用反引号：

- contract；
- function；
- file；
- variable；
- parameter；
- mapping；
- role；
- modifier；
- event；
- error；
- struct；
- module；
- interface；
- class；
- library；
- 精确配置键和值。

普通技术概念、语义类型词、标点和泛化标准名称不使用反引号。

### HR-ID-02：函数

每个具体函数名必须：

- 保留 `()`；
- 使用精确大小写和拼写；
- 使用反引号；
- 与 `Function` 或 `function` 相邻。

正确形式包括：

```text
Function `foo()` validates ...
the function `foo()`
the `foo()` function
Functions `a()`, `b()`, and `c()`
```

不得写成 `foo`、`foo ()`、``function `foo` `` 或让 function 与标识符之间插入其他修饰关系。

### HR-ID-03：语义类型

具体标识符首次出现时，应明确其语义类型。默认把类型放在标识符前；自然句法需要时可放在后面。不得把普通类型词放入反引号。

### HR-ID-04：原样保留

项目标识符保持仓库中的准确拼写、大小写、下划线和符号。不得转义下划线，不得增加自行选择的连字符，不得为了英文可读性重命名标识符。

### HR-ID-05：文件路径的两种语境

正文中的具体文件标识符使用反引号，例如 `src/Vault.sol`。Code locations 字段中的路径严格使用 `- path:start-end`，不使用反引号。

## 15. 项目、协议和代币名称

### HR-NAME-01：项目与协议

- 客户组织统一写作 `The project`；
- 协议本身统一写作 `the protocol`；
- 不把项目组织、协议、合约和运营方作为可互换主体。

Relevant Project Position 使用简洁、正式的第三人称间接引语，并保持原始时态、范围和确定性。

### HR-NAME-02：代币

代币名称和符号使用反引号。同一代币全文使用同一名称。

- 泛指以太坊原生资产时使用 `Ether`；`ETH` 是 Brief 确认的精确代币符号、标识符或字面值时保持原样；
- 泛指比特币原生资产时使用 `Bitcoin`；`BTC` 是 Brief 确认的精确代币符号、标识符或字面值时保持原样；
- 代币符号本身已经标识代币，不在其后附加 `token` 或 `tokens`。

### HR-NAME-03：风险接受与项目反馈

项目确认的风险接受只证明项目立场，不证明技术安全属性。项目计划只证明计划，不证明当前部署或永久行为。优化器不得强化这些陈述。

## 16. 英文表达

### HR-LANG-01：语言、时态和人称

报告正文使用标准、正式、精确的英文和第三人称。当前代码、设计和机制使用现在时。只有 Brief 中的时间关系对事实有实质影响时，才保留必要的过去时、完成时或将来时。

不得使用 `we`、面向读者的 `you` 或对话式表达。

### HR-LANG-02：自然句法

句子使用自然的 subject–verb–object、冠词、介词和英语搭配。不得使用：

- 为缩短篇幅形成的电报式英语；
- 连续堆叠的长 noun stack；
- 非常规名词动词化；
- 临时创造的复合修饰语；
- 压缩隐喻。

当流利技术编辑会为正常表达而改写一个句子时，该句子视为违反规则，即使读者能够猜出含义。

### HR-LANG-03：具体而非评价

使用具体行为、条件、范围和数值替代主观形容词、副词及空泛风险标签。不得用以下表达替代事实链：

```text
potential risks
security implications
significant concerns
best practice
for clarity
for safety
properly
correctly
```

这些词只有在后文立即给出其具体、已证实含义，且词本身仍有必要时才可保留。

### HR-LANG-04：禁止非正式表达

不得使用口语、宣传语、夸张、比喻、反问、文化特定习语或面向读者的劝说。Finding 是技术结论，不是营销文本或教程。

### HR-LANG-05：标点和空格

- 标点后一个空格，标点前不留空格；
- 普通括号前留一个空格；
- 函数调用括号紧跟函数名；
- 使用 `i.e.,` 表示同一关系；
- 使用 `e.g.,` 引出示例；
- 使用 `DoS`；分布式特征是 Semantic Lock 中的实质事实时写 `distributed DoS`，不使用 `DDoS`；
- 不转义普通 Markdown 文本中的下划线；
- 不输出 LaTeX 命令。

### HR-LANG-06：连接词

连接词必须准确表达实际关系：

- `However,`：对照；
- `Meanwhile,`：并行行为；
- `Furthermore,`：升级；
- `In addition,`：补充；
- `Thus,` / `Therefore,`：由前文推出的结论；
- `Consequently,` / `As a result,`：直接后果；
- `because`：原因；
- `if` / `unless` / `when`：条件或触发。

不得用连接词制造 Brief 没有的对照、升级、因果或时间关系。句子不得以 `Also` 开头。

### HR-LANG-07：代词

代词必须只有一个明确先行词。`it`、`this`、`they` 或 `which` 可能指向多个对象时，改用准确的组件、角色、状态或行为名称。替换代词不得改变主体。

## 17. Audit scope 与部署状态

### HR-SCOPE-01：in-scope 默认未部署

除非审计人员明确确认某个 audited in-scope instance 已经部署，否则把当前审计范围内的合约视为尚未部署。历史部署、旧版本、其他项目实例或升级例外不能改变这一默认值。

Draft 在没有明确事实时假定已部署，并因此引入迁移、存量状态或升级语义，属于语义错误；优化器必须返回 fact grounding 或 drafting，不得只删除相关词句。

### HR-SCOPE-02：依赖合约单独判断

in-scope contract 与 dependency contract 必须区分。依赖合约可以已经部署，但只有 Brief 已确认时才写其部署约束。不得把依赖合约的部署事实转移到当前审计合约。

### HR-SCOPE-03：时间和版本边界

`currently`、特定版本、审计范围、生产目标和测试环境等限定词只在 Brief 支持时使用，并保持其原始范围。不得把当前计划改成永久承诺，也不得删除会改变结论适用范围的时间限定。

## 18. 最终验证

优化器修改完成后，必须重新验证完整 Finding，而不是只检查被改动的句子。

### HR-CHECK-01：语义等价

逐项比较优化后的 Finding 与 Semantic Lock，确认输出中的：

- Finding Type 相同；
- 每个事实和否定关系相同；
- actor、object 和 responsibility 相同；
- 条件、触发、顺序和路径相同；
- 因果方向相同；
- Impact 和边界相同；
- 确定性、持续时间和可恢复性相同；
- remediation 目标和实现自由相同；
- 项目立场和部署状态相同。

任一项无法确认时，优化结果无效并返回上游。

### HR-CHECK-02：结构

确认：

- 只有 branch contract 允许的字段；
- 字段完整且顺序正确；
- 没有空字段或占位符；
- Title、Description、Impact、Suggestion 和 Code locations 各自履行职责；
- Description 不超过六句；
- Impact 如存在则恰好一句；
- Suggestion 如存在则恰好一个祈使句；
- Code locations 格式、范围、去重和排序正确；
- 无报告级材料、代码片段、LaTeX、推理或检查说明。

### HR-CHECK-03：术语和语言

确认：

- material technical concepts 使用 `Terminology Brief` 的准确术语或普通技术语言；
- 同一概念没有同义词漂移；
- 情态动词与证据一致；
- 标识符、函数括号、语义类型和反引号正确；
- 主语、动词、宾语、冠词、介词和修饰关系自然；
- 条件和连接词位置正确；
- 无口语、宣传、空泛风险标签、双重弱化或无依据强限定词。

### HR-CHECK-04：返回结果

- Draft 已满足全部规则：原样返回完整 Draft；
- 规则违反可无损修复：返回完整的优化后 Finding；
- 不能无损修复：只返回 `OPTIMIZER_BLOCKED`。

最终输出不附加 `PASS`、`OPTIMIZED`、修改摘要、规则命中列表或解释。
