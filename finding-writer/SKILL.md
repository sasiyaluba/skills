---
name: finding-writer
description: Use when an auditor provides one raw audit finding and wants a report-ready Security Issue, Recommendation, or Note grounded in the current repository.
---

# Finding Writer

把一个 raw finding 转换成一个可直接进入报告的最终 Finding。模块的唯一外部 Interface 是：

```text
raw finding + repository + auditor decisions -> final report finding
```

主代理负责事实、分类、Impact、术语、Draft、全部审计人员交互和流程回退。一个 fresh child optimizer 只执行最终硬规则优化；每个阶段只加载 References 表中明确要求的文件。

## References

| 阶段 | Reference | 读取条件 |
| --- | --- | --- |
| 事实落地 | `references/finding-grounding.md` | 每个 Finding |
| Impact 与 Severity | `references/impact-assessment.md` | 仅 Security Issue |
| 术语发现 | `references/terminology-discovery.md` | 每个已确认类型的 Finding |
| Security Issue drafting | `references/issue-drafting.md` | 仅 Security Issue |
| Recommendation drafting | `references/recommendation-drafting.md` | 仅 Recommendation |
| Note drafting | `references/note-drafting.md` | 仅 Note |
| 最终优化 | `references/hard-rules.md` | 每个完整 Draft |

只读取当前阶段和已选分支要求的 Reference。未选 drafting 分支不得加载。

## Authority

- `Fact Brief` 决定项目事实、对象关系、条件、执行过程、直接结果、边界和 Evidence；
- 已确认的 Finding Type 决定分支语境；
- Security Issue 的 `Impact Brief` 决定 Impact 与 Severity；
- `Terminology Brief` 只决定专业术语及其适用边界；
- selected drafting reference 决定分支逻辑、字段集合、字段职责、比例和完成标准；
- `hard-rules.md` 只决定最终共享格式和表达；
- 审计人员的明确决定高于代理建议，但不得被改写成仓库事实。

下游阶段不得修改上游权威内容。发现冲突时返回产生该内容的阶段；不得通过弱化措辞或删除事实维持当前分支。

## Workflow

流程开始时创建一个本次 Finding 唯一的前缀，并使用 harness 提供、可被 child agent 读取的 `local://` 共享临时存储保存阶段产物，例如 `local://finding-writer-<unique-id>-fact.yaml`。所有阶段复用该前缀；只清理同一前缀下由本次流程创建的文件。

### 1. Ground the finding

读取 `references/finding-grounding.md`。检查用户提供的 Finding、当前仓库、配置、文档、测试和依赖，直到能够输出完整 `Fact Brief`。

完成条件：

- 未阅读项目代码的人只读 `Fact Brief` 即可理解全部相关事实；
- 每项事实都有 claim-bound Evidence；
- 仓库事实、审计人员确认和 inference 已区分；
- 不存在工具可确认但仍留给审计人员回答的问题。

只有无法通过仓库或权威来源确认、且会改变事实理解的信息才询问审计人员。将最终 `Fact Brief` 写入唯一命名的 `local://` 临时文件。

### 2. Confirm exactly one Finding Type

使用 raw finding、`Fact Brief` 和审计人员已给出的类型或项目立场，选择一个互斥类型：

- **Security Issue**：事实证明当前实现或设计违反应成立的安全属性，并形成具体的不利安全后果；
- **Recommendation**：报告要求一项具体改进，但事实没有建立具体安全属性违反及不利安全后果；
- **Note**：报告披露已接受的设计选择、信任关系、特权能力、外部依赖、部署条件或运行假设，而不请求改变当前行为。

分类规则：

1. 审计人员已经给出类型，且 `Fact Brief` 能够支持时，直接采用，不重复确认；
2. 审计人员未给出类型时，只提出一个建议类型及最短区别理由，并请求确认；
3. 审计人员给出的类型无法真实容纳已确认事实时，说明冲突及依据，请求确认新类型或控制性事实；
4. 严重程度不参与类型选择；
5. 轻微但具体的安全属性违反仍是 Security Issue；
6. 严重条件性后果可以属于 Note，但前提是后果只在已披露的信任或运行假设失效时发生；
7. 历史报告中的 Finding 标签不是分类先例。

类型确认后，将 Finding Type 和所有控制性审计人员决定写入唯一命名的 `local://` context 文件。

如果重新分类改变了 Finding Type，立即丢弃旧 `Impact Brief`、`Terminology Brief` 和 Draft。新类型是 Security Issue 时重新执行第 3 步；新类型是 Recommendation 或 Note 时确认不存在旧 `Impact Brief` 临时文件。

### 3. Assess Impact only for Security Issue

若类型是 Security Issue，读取并完整执行 `references/impact-assessment.md`：

- 只确认一个最严重且现实的 Impact；
- 保留受影响对象、必要条件和边界；
- 用户已经给出且事实支持的 Impact 或 Severity 直接采用；
- 缺失的 Impact 或 Severity 按 reference 请求确认；
- Impact 未确认前不继续；
- 将最终 `Impact Brief` 写入唯一命名的 `local://` 临时文件。

若类型是 Recommendation 或 Note，不生成 Severity，也不为满足模板生成 `Impact Brief`。已经确认的有限非安全后果或 Note 的条件性后果保留在 `Fact Brief`。如果这些事实实际建立具体安全属性违反，返回第 2 步重新分类。

### 4. Discover terminology

读取 `references/terminology-discovery.md`。以 raw finding、`Fact Brief` 和已有的可选 `Impact Brief` 为输入，在主代理中完成术语搜索。

必须实际阅读至少 20 个不同来源，并比较候选术语的定义、使用场景和语义边界。搜索结果摘要、转载和未实际阅读的链接不计入来源。没有准确术语时记录普通技术语言，不创造术语。

完成后，将完整 `Terminology Brief` 写入唯一命名的 `local://` 临时文件。该 Brief 只提供 vocabulary evidence，不能修改事实、类型、Impact 或 remediation。

### 5. Draft in the selected branch

只读取 selected drafting reference：

| Finding Type | Drafting reference | 必要输入 |
| --- | --- | --- |
| Security Issue | `references/issue-drafting.md` | `Fact Brief`、`Impact Brief`、`Terminology Brief` |
| Recommendation | `references/recommendation-drafting.md` | `Fact Brief`、`Terminology Brief` |
| Note | `references/note-drafting.md` | `Fact Brief`、`Terminology Brief` |

严格按 reference 建立该分支的逻辑链、字段职责和输出格式。Drafting 阶段不重新调查事实、评估 Impact、搜索术语或加载其他分支。

将完整 Draft 写入独立的唯一命名 `local://` 临时文件，不把 Draft 当作最终结果返回给审计人员。

Drafting 返回控制信号时：

- `RETURN_TO_CLASSIFICATION`：丢弃当前 Draft，返回第 2 步；
- `ISSUE_DRAFTING_BLOCKED`：返回信号指明的 Fact、Impact 或 Terminology 阶段；
- `RECOMMENDATION_DRAFTING_BLOCKED`：返回信号指明的 Fact、Terminology 或类型判断阶段；
- `NOTE_DRAFTING_BLOCKED`：返回信号指明的 Fact、Terminology 或类型判断阶段。

能够通过工具或已有输入修复的阻塞由主代理继续处理。只有缺失信息确实需要审计人员决定时才提问。

### 6. Optimize in one fresh child agent

每个完整 Draft 启动恰好一个 fresh child optimizer。只向它提供：

- `references/hard-rules.md`；
- selected drafting reference；
- 临时 context 文件；
- 临时 `Fact Brief`；
- 临时 `Impact Brief`，仅当当前类型是 Security Issue；
- 临时 `Terminology Brief`；
- 临时 Draft。

要求 optimizer：

1. 不读取仓库、未选 drafting 分支或不在输入清单中的文件；
2. 按 `hard-rules.md` 建立 Semantic Lock；
3. 只做唯一确定且不改变语义的修复；
4. 对合规 Draft 原样返回；
5. 对可无损修复的 Draft 返回完整优化后 Finding；
6. 无法无损修复时只返回 `OPTIMIZER_BLOCKED: <HR rule ID>: <必须返回的阶段及具体原因>`；
7. 不返回建议列表、diff、注释、检查结果或优化说明。

Optimizer 每个 Draft 只运行一次。主代理不得在 optimizer 返回完整 Finding 后增加第二次润色。

### 7. Handle optimizer returns

若 optimizer 返回完整 Finding，将其作为最终文本，不做任何修改。

若 optimizer 返回 `OPTIMIZER_BLOCKED`：

1. 按信号指定的现有阶段返回；
2. 丢弃当前 Draft；
3. Finding Type 发生变化时丢弃旧 `Impact Brief`；新类型是 Security Issue 时重新执行第 3 步，新类型是 Recommendation 或 Note 时不保留 `Impact Brief`；
4. Fact、Finding Type 或 Impact 发生变化时，同时丢弃 `Terminology Brief` 并重新执行术语发现；
5. 使用更新后的权威输入重新 drafting；
6. 对新 Draft 启动一个新的 fresh child optimizer。

不得直接把 `OPTIMIZER_BLOCKED` 当作最终 Finding 返回。只有所需决定无法通过工具或上下文获得时，才向审计人员说明缺少的具体信息。

### 8. Return and clean up

只返回 optimizer 给出的完整最终 Finding。不要附加 Severity、分类说明、候选标题、推理、检查表、来源清单、优化摘要或后续建议；报告元数据由上层流程处理。

返回前删除本次 Finding 创建的所有临时 context、Brief、Terminology 和 Draft 文件。不得删除其他 Finding 或其他会话的临时文件。

## Completion criterion

只有同时满足以下条件，流程才完成：

- `Fact Brief` 已完整落地；
- 恰好一个 Finding Type 已确认；
- Security Issue 具有已确认的 `Impact Brief`；
- `Terminology Brief` 已实际审阅至少 20 个来源；
- Draft 来自唯一 selected branch；
- fresh child optimizer 已返回完整 Finding；
- 最终 Finding 通过全部 Hard Rules；
- 所有本次临时文件已清理。
