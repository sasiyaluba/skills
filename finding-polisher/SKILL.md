---
name: finding-polisher
description: Use when an auditor provides a Security Issue, Recommendation, or Note in any structure and wants it converted into the standard report format with polished English and unchanged meaning.
---

# Finding Polisher

把任意结构的 Finding 转换并润色为可直接进入报告的标准 Finding。模块的唯一外部 Interface 是：

```text
finding content in any format + confirmed finding type -> standardized semantically equivalent finding
```

本流程不要求输入使用任何字段、顺序、模板或标记格式，也不保留输入的 presentation structure。它不调查仓库、不重新分类、不评估 Impact 或 Severity；输入内容是全部实质语义的唯一权威，selected branch 决定标准输出结构。

## References

| 阶段 | Reference | 读取条件 |
| --- | --- | --- |
| 术语发现 | `skill://finding-writer/references/terminology-discovery.md` | 每个 Finding |
| Security Issue drafting | `skill://finding-writer/references/issue-drafting.md` | 仅 Security Issue |
| Recommendation drafting | `skill://finding-writer/references/recommendation-drafting.md` | 仅 Recommendation |
| Note drafting | `skill://finding-writer/references/note-drafting.md` | 仅 Note |
| 最终优化 | `skill://finding-writer/references/hard-rules.md` | 每个完整 Draft |

只读取当前阶段和已确认类型要求的 Reference。不得读取 finding grounding、impact assessment 或未选 drafting 分支。

## Authority

- 输入 Finding 决定 Finding Type 以外的全部实质内容，但不决定输出字段、顺序或格式；
- 审计人员确认的 Finding Type 决定 selected drafting branch；
- `Content Lock` 是输入 Finding 的格式无关语义清单，决定事实、关系、条件、确定性、Impact、修复目标和证据，不记录或保护原 presentation structure；
- `Terminology Brief` 只决定更准确的专业术语及其适用边界；
- selected drafting reference 决定如何把已锁定内容分配至标准字段，并决定字段职责、比例和输出格式；
- `hard-rules.md` 决定最终共享格式和表达。

低优先级规则不得改变高优先级内容。原 Finding 与已确认类型不兼容、缺少完成 selected branch 所需的实质内容，或存在无法无损解释的矛盾时，停止并返回 `POLISH_BLOCKED`；不得补充事实、重新分类或弱化原结论。

## Workflow

流程开始时创建一个本次 Finding 唯一的前缀，并使用 harness 提供、可被 child agent 读取的 `local://` 共享临时存储保存阶段产物，例如 `local://finding-polisher-<unique-id>-content.yaml`。所有阶段复用该前缀；只清理同一前缀下由本次流程创建的文件。

### 1. Validate the input

输入必须包含：

- 足以形成对应标准 Finding 的实质内容；内容可以是散文、列表、表格、旧模板、混合字段或其他结构；
- 审计人员已经确认的唯一 Finding Type：`Security Issue`、`Recommendation` 或 `Note`。

不得因为输入缺少标准字段标签、字段顺序不同、同一语义散落在多处或包含额外 presentation wrapper 而阻塞。先按语义角色归一化内容，再由 selected branch 生成标准结构。

Finding Type 没有明确提供时，只询问类型，不自行分类。输入缺少 branch contract 必需的实质语义，且只能通过仓库调查、Impact 评估或新的审计判断补齐时，只返回：

```text
POLISH_BLOCKED: <缺失或矛盾的具体语义>
```

不得访问仓库验证输入，也不得把标准化请求升级为完整 finding-writing 流程。

### 2. Build the Content Lock

逐项读取整个输入，建立格式无关且无损的 `Content Lock`。标题、字段标签、段落、列表、表格、前后说明和原有顺序只用于定位来源，不成为输出约束。至少记录：

```yaml
content_lock:
  finding_type: <confirmed type>
  source_content: |-
    <verbatim input finding>
  semantic_units:
    - id: C1
      subject: <subject>
      predicate: <predicate>
      object: <object>
      polarity: <positive | negative>
      condition: <condition or none>
      modality: <certainty or capability>
      scope: <affected boundary>
      causal_role: <context | expected property | deviation | trigger | cause | result | impact | remediation | disclosure | evidence>
      source_span: <verbatim fragment or unambiguous location in source_content>
  immutable_relations:
    - from: <semantic unit id>
      relation: <ordering | causality | contrast | dependency | responsibility | boundary>
      to: <semantic unit id>
  identifiers:
    - value: <exact project identifier>
      semantic_type: <type if stated>
  evidence_locations:
    - value: <verbatim path and range if present>
      supports: [<semantic unit ids>]
  auditor_decisions:
    - <explicit decision present in the request>
```

`Content Lock` 只能拆解输入语义，不能修正、补全或解释输入。必须保留：

- 每项实质主张及其否定关系；
- actor、对象、责任方和受影响方；
- 条件、触发、顺序、因果方向和路径边界；
- Impact 的对象、范围、确定性、持续时间和可恢复性；
- remediation 的目标及输入保留的实现自由；
- 项目标识符、数值、版本、链、配置和部署条件；
- 已提供 Evidence 的位置、范围及其支持的主张。

不得把原字段归属、字段名称、段落顺序、重复 presentation 或 wrapper 文本当作实质语义。完全重复的主张在 `Content Lock` 中只记录一次并保留所有来源位置。若一段内容存在多种会改变实质含义的解释，只返回 `POLISH_BLOCKED`。将完整 `Content Lock` 写入唯一命名的临时文件。

### 3. Discover terminology

读取并完整执行 `skill://finding-writer/references/terminology-discovery.md`。以原 Finding 和 `Content Lock` 代替 raw finding、`Fact Brief` 和可选 `Impact Brief`：

- 仍须实际阅读至少 20 个不同来源；
- 只研究 `Content Lock` 已有概念的准确术语；
- 不得通过术语研究增加事实、机制、后果、条件或修复方案；
- 没有准确术语时保留清楚的普通技术语言。

将完整 `Terminology Brief` 写入唯一命名的临时文件。

### 4. Redraft in the confirmed branch

只读取已确认 Finding Type 对应的 drafting reference：

| Finding Type | Drafting reference |
| --- | --- |
| Security Issue | `skill://finding-writer/references/issue-drafting.md` |
| Recommendation | `skill://finding-writer/references/recommendation-drafting.md` |
| Note | `skill://finding-writer/references/note-drafting.md` |

以 `Content Lock` 代替该 reference 要求的 `Fact Brief` 和可选 `Impact Brief`，并与 `Terminology Brief` 一起作为输入。先建立 selected branch 的内部 Map，再把每个语义单位分配到该分支规定的标准字段。输入的字段名称、顺序和格式不得沿用为输出契约；最终输出必须采用 selected branch 的标准字段集合、职责、顺序和布局。

drafting 可以重组、拆分或合并句子，移动内容到职责正确的字段，删除 presentation wrapper 和完全重复的表达，并采用已验证术语；这些操作不得增加、删除、合并或拆分实质主张。输出中的每个实质主张都必须与 `Content Lock` 中的语义单位等义且可追溯。

不得：

- 改变 Finding Type、Impact、Severity 或 remediation；
- 改变条件、情态强度、范围、因果关系或责任归属；
- 新增、猜测或重新调查 Evidence 和 Code locations；
- 为满足 branch contract 而补写输入没有的逻辑节点。

若 selected branch 无法在不改变 `Content Lock` 的前提下产生完整 Draft，只返回：

```text
POLISH_DRAFTING_BLOCKED: <冲突的语义单位或缺失内容>
```

将完整 Draft 写入独立的唯一命名临时文件。

### 5. Optimize in one fresh child agent

每个完整 Draft 启动恰好一个 fresh child optimizer。只向它提供：

- `skill://finding-writer/references/hard-rules.md`；
- selected drafting reference；
- `Content Lock` 临时文件；
- `Terminology Brief` 临时文件；
- Draft 临时文件。

明确指定 `Content Lock` 是 optimizer 的 Authoritative Content Set。optimizer 只执行 hard rules，并逐项验证最终 Finding 与 `Content Lock` 语义等价。

optimizer 返回阻塞信号时，将其规范化为：

```text
POLISH_BLOCKED: <HR rule ID>: <冲突的语义单位或缺失内容>
```

不得返回部分润色结果、候选版本、修改说明或新的审计问题。

### 6. Return and clean up

optimizer 成功时，只返回完整 polished Finding，不附加解释、修改摘要或检查结果。

返回前确认：

- Finding Type 未改变；
- 每个输出实质主张都可逐项映射回 `Content Lock`；
- 输入格式已经转换为 selected branch 的标准字段、顺序和布局；
- 术语变化没有改变技术含义；
- Impact、remediation 和 Evidence 未发生语义漂移；
- 输出符合 selected branch 和全部 Hard Rules；
- 所有本次临时文件已经清理。
