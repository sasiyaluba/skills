---
name: finding-polisher
description: Use when an auditor provides one complete Security Issue, Recommendation, or Note and wants its English polished without changing its confirmed content.
---

# Finding Polisher

把一个内容完整、类型已确认的 Finding 润色为可直接进入报告的最终 Finding。模块的唯一外部 Interface 是：

```text
complete finding + confirmed finding type -> semantically equivalent polished finding
```

本流程不调查仓库、不重新分类、不评估 Impact 或 Severity。原 Finding 是全部内容的唯一权威；术语发现、selected branch drafting 和最终优化只改善表达，不得改变已经确认的事实、逻辑或结论。

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

- 原 Finding 决定 Finding Type 以外的全部实质内容；
- 审计人员确认的 Finding Type 决定 selected drafting branch；
- `Content Lock` 是原 Finding 的无损语义快照，决定事实、关系、条件、确定性、Impact、修复目标、证据和字段边界；
- `Terminology Brief` 只决定更准确的专业术语及其适用边界；
- selected drafting reference 决定分支逻辑、字段职责、比例和输出格式；
- `hard-rules.md` 决定最终共享格式和表达。

低优先级规则不得改变高优先级内容。原 Finding 与已确认类型不兼容、缺少完成 selected branch 所需的实质内容，或存在无法无损解释的矛盾时，停止并返回 `POLISH_BLOCKED`；不得补充事实、重新分类或弱化原结论。

## Workflow

流程开始时创建一个本次 Finding 唯一的前缀，并使用 harness 提供、可被 child agent 读取的 `local://` 共享临时存储保存阶段产物，例如 `local://finding-polisher-<unique-id>-content.yaml`。所有阶段复用该前缀；只清理同一前缀下由本次流程创建的文件。

### 1. Validate the input

输入必须包含：

- 一份完整 Finding；
- 审计人员已经确认的唯一 Finding Type：`Security Issue`、`Recommendation` 或 `Note`。

Finding Type 没有明确提供时，只询问类型，不自行分类。输入不是完整 Finding，或缺失内容只能通过仓库调查、Impact 评估或新的审计判断补齐时，只返回：

```text
POLISH_BLOCKED: <缺失或矛盾的具体内容>
```

不得访问仓库验证原文，也不得把润色请求升级为完整 finding-writing 流程。

### 2. Build the Content Lock

逐项读取原 Finding，建立无损 `Content Lock`。至少记录：

```yaml
content_lock:
  finding_type: <confirmed type>
  original_finding: |-
    <verbatim input finding>
  fields:
    title: <present content>
    description: <present content>
    impact: <present content, if any>
    suggestion: <present content, if any>
    code_locations: <present content>
  semantic_units:
    - subject: <subject>
      predicate: <predicate>
      object: <object>
      polarity: <positive | negative>
      condition: <condition or none>
      modality: <certainty or capability>
      scope: <affected boundary>
      causal_role: <context | expected property | deviation | trigger | cause | result | impact | remediation | disclosure>
      source_field: <field>
  identifiers:
    - <exact project identifier and semantic type>
  immutable_relations:
    - <ordering, causality, contrast, dependency, responsibility, or boundary>
  code_locations:
    - <verbatim location>
  auditor_decisions:
    - <explicit decision present in the request>
```

`Content Lock` 只能拆解原文，不能修正、补全或解释原文。必须保留：

- 每项事实及其否定关系；
- actor、对象、责任方和受影响方；
- 条件、触发、顺序、因果方向和路径边界；
- Impact 的对象、范围、确定性、持续时间和可恢复性；
- remediation 的目标及原文保留的实现自由；
- 项目标识符、数值、版本、链、配置和部署条件；
- Code locations 的路径与范围。

若一个句子存在多种会改变实质含义的解释，只返回 `POLISH_BLOCKED`。将完整 `Content Lock` 写入唯一命名的临时文件。

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

以 `Content Lock` 代替该 reference 要求的 `Fact Brief` 和可选 `Impact Brief`，并与 `Terminology Brief` 一起作为输入。drafting 可以重新组织字段内的句子、改善逻辑呈现并采用已验证术语，但输出中的每个实质主张都必须与 `Content Lock` 等义。

不得：

- 新增、删除、合并或拆分实质主张；
- 改变 Finding Type、Impact、Severity 或 remediation；
- 改变条件、情态强度、范围、因果关系或责任归属；
- 新增或重新调查 Code locations；
- 为满足 branch contract 而补写原文没有的逻辑节点。

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
- 每个实质主张都可逐项映射回 `Content Lock`；
- 术语变化没有改变技术含义；
- Impact、Suggestion 和 Code locations 未发生语义漂移；
- 输出符合 selected branch 和全部 Hard Rules；
- 所有本次临时文件已经清理。
