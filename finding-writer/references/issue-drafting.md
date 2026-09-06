# Issue Drafting

基于完整的 `Fact Brief`、已经确认的 `Impact Brief` 和完整的 `Terminology Brief`，编写可直接进入审计报告的 Security Issue。最终 Finding 使用英文；本文件定义从三个 Brief 到最终文本的通用推导方法，不重新调查事实、评估 Impact 或搜索术语。

## 1. 输入边界

写作前必须同时读取：

- `references/finding-grounding.md` 产出的 `Fact Brief`；
- `references/impact-assessment.md` 产出的 `Impact Brief`；
- `references/terminology-discovery.md` 产出的 `Terminology Brief`。

三个 Brief 的职责互不替代：

- `Fact Brief` 是背景、预期行为、实际行为、成立条件、执行过程、直接结果、影响边界和证据的唯一事实来源；
- `Impact Brief` 是最严重且现实的一个 Impact 及其 Severity 的唯一结论来源；
- `Terminology Brief` 只决定专业词汇的含义和适用语境，不能补充事实、因果关系、Impact 或修复方案。

先验证以下条件：

1. `Fact Brief` 足以让未阅读项目代码的读者理解 Finding，并完整建立预期行为、直接偏差、成立条件、因果路径、直接结果、影响边界，以及能够从这些事实推导出的修复不变量；
2. `Impact Brief.impact.based_on` 中的每一项都能映射到 `Fact Brief` 中已经证实的事实；
3. Impact 不超过事实所支持的结果、条件和边界；
4. Severity 已由用户给出或确认；
5. 所有计划采用的专业术语都能在 `Terminology Brief` 中找到对应定义、用途和语义边界；没有准确专业术语的概念可以使用普通技术语言表达；
6. 三个 Brief 之间不存在未解决的矛盾。

信息缺失或相互冲突时，不通过模糊措辞填补空白，也不在写作阶段重新推断。只返回：

```text
ISSUE_DRAFTING_BLOCKED: <Fact Brief | Impact Brief | Terminology Brief>: <具体缺失或冲突>
```

## 2. Security Issue 的核心逻辑

Security Issue 不是“可以改进”的建议，而是已经证实的实现或设计偏离实际预期，并产生具体安全后果。写作时先在内部建立以下逻辑链：

```text
Expected Property
    -> Deviation / Root Cause
    -> Preconditions + Trigger
    -> Causal Path
    -> Immediate Result
    -> Confirmed Impact
    -> Remediation Invariant
```

也可以形式化为：

```text
在条件 C 下，触发 T 经过缺陷 D 必然或可能产生直接结果 R；
R 进一步造成已经确认的 Impact I，并受边界 B 限制；
修复目标 G 必须消除 D 或恢复被破坏的预期属性。
```

各节点含义如下：

- **Expected Property**：受影响机制应维持的权限、资产、状态、数据完整性、可用性、顺序或其他安全属性；
- **Deviation / Root Cause**：实现相对预期的直接偏差；它不是暴露问题的表面现象，也不是下游后果；
- **Preconditions**：问题成立所需的权限、状态、配置、时序、资产特征、外部行为或顺序；
- **Trigger**：激活缺陷的 actor、输入、操作或确定性事件；
- **Causal Path**：从 Trigger 经过 Root Cause 到 Result 的最短完整路径；
- **Immediate Result**：首先发生的状态、资产、权限或控制流变化；
- **Confirmed Impact**：`Impact Brief` 已确认的最严重且现实的安全后果；
- **Remediation Invariant**：修复后必须恢复的约束或目标行为，而不是未经证实的具体实现偏好。

只有整条链能够由 Brief 推导时才开始写作。条件性属于触发或后果，不属于缺陷是否存在：缺陷已经被证实；在特定条件下才发生的结果应写成条件句，而不是把整项 Issue 弱化为一种猜测。

## 3. 字段分工

每个字段只承担一个职责：

| 字段 | 职责 | 读者应得到的答案 |
| --- | --- | --- |
| Title | 识别问题 | 哪个对象存在什么区别性缺陷或后果？ |
| Description | 证明问题 | 预期是什么、实际偏差是什么、在什么条件下如何产生结果？ |
| Impact | 给出结论 | 最严重且现实的一个安全后果是什么？ |
| Suggestion | 恢复属性 | 修复后必须满足什么约束或目标行为？ |
| Code locations | 定位证据 | 哪些最小代码范围直接证明该缺陷？ |

字段之间应当构成“识别—证明—结论—修复—验证”的关系，而不是换词重复同一句话。Severity 直接沿用 `Impact Brief`，作为报告元数据处理；不要把等级或等级理由写进 Title、Description、Impact 或 Suggestion。

## 4. 起草流程

### 4.1 建立 Issue Map

从 Brief 中提取并填写内部映射：

```text
Subject:
Expected Property:
Deviation / Root Cause:
Common Preconditions:
Path A — Trigger -> Causal Steps -> Immediate Result:
Path A — Impact Boundary:
Path B — Trigger -> Causal Steps -> Immediate Result:   # 仅在确有不同路径时存在
Path B — Impact Boundary:
Confirmed Impact:
Remediation Invariant:
Direct Evidence:
Preferred Terms:
```

如果合并两条路径会改变任何前置条件、Trigger、因果机制、Result、Impact 边界或修复目标，就保留独立路径。只有真正共同的上下文和步骤可以合并。

完成标准：`Confirmed Impact` 中的每个结论都能从前面的路径推出；每个路径节点都有 `Fact Brief` 支持；没有仅用于“让风险听起来更严重”的节点。

### 4.2 分配信息

先把 Issue Map 中的信息分配到字段，再写完整句子：

- Title 使用 Subject 与最具区分度的 Deviation 或 Consequence；
- Description 使用 Expected Property、Deviation、Preconditions、Trigger、Causal Path、Immediate Result 和必要的 Impact 连接；
- Impact 只使用已经确认的 Impact 及防止夸大的必要边界；
- Suggestion 使用 Remediation Invariant；
- Code locations 只使用直接证明 Deviation 的 Evidence。

同一事实只在其主要字段中完整表达。Description 可以为 Impact 建立必要前提，但不要在 Description 和 Impact 中逐字重复后果。

### 4.3 映射术语

按照 `Terminology Brief` 的类别映射词汇：

- `domain` 用于 Context 和 Subject；
- `mechanism` 用于 Expected Property、Trigger 和 Causal Path；
- `security_property` 用于 Expected Property 与 Impact；
- `failure_mode` 用于 Deviation、Root Cause 和 Title；
- `impact` 用于 Impact。

只在来源定义与当前语义一致时使用术语，并保持来源记录的语法角色和搭配。专业术语不能作为“更严重”的装饰。没有准确术语时，使用普通但精确的技术英语，不创造新的漏洞名称或机制标签。

## 5. Title

Title 是能够独立识别 Finding 的名词短语。先在内部生成至少三个实质不同的候选，再选择最短且不丢失 Title Kernel 的自然表达。

```text
Title Kernel = Affected Subject + Distinguishing Defect / Consequence
```

### 5.1 优先形式

优先使用直接陈述已证实缺陷的形式：

```text
Missing <check or binding> on <affected subject>
Lack of <required control> in <affected subject>
Incorrect <accounting, validation, state transition, or computation> during <operation>
Improper <mechanism> in <affected subject>
<Supported consequence> due to <direct cause>
```

这些是逻辑形式，不是必须逐字套用的标题模板。选择能够准确表达当前机制的自然英语。

- 当某个既有对象的值、格式或属性未被检查时，通常使用 `check on <object>`；
- 当该对象本身完全未被检查时，可以使用 `check of <object>`；
- 当介词选择不自然或容易产生歧义时，改写为 `Missing validation for ...` 或其他清楚表达。

### 5.2 Consequence 标题

当直接后果比代码缺陷更能区分 Finding 时，可以使用后果标题。只有在后果确实取决于额外条件，而且同时写出后果与直接原因才能准确区分 Finding 时，才使用：

```text
Potential <consequence> due to <direct cause>
```

`Potential` 表示后果有明确条件，不表示作者不确定缺陷是否存在。能够确定发生的后果使用确定表达。

### 5.3 Title 完成标准

Title 必须：

- 同时保留 Subject 和区别性缺陷或后果；
- 使用 sentence case；
- 使用名词短语，而不是修复命令；
- 不包含 Severity、`Security Issue`、`vulnerability` 等类型标签；
- 不使用 `Incorrect logic`、`Improper implementation`、`Security risk`、`Potential issue` 等无法区分 Finding 的空泛表达；
- 在不丢失必要标识符或区别性事实时，尽量控制在 12 个英文单词以内；
- 使只读 Title 的读者仍能将该 Finding 与同一报告中的其他 Finding 区分开。

## 6. Description

Description 是对因果链的无损压缩。它必须让未阅读代码的技术读者理解为什么当前实现违背预期、如何被触发，以及为什么所述 Impact 能成立。

按以下逻辑顺序组织，而不是机械套用固定句式：

1. **Context and Expected Property**：说明受影响组件的读者可理解用途，以及它必须维持的安全属性；
2. **Deviation / Root Cause**：明确指出当前实现与该属性之间的直接偏差；
3. **Preconditions and Trigger**：说明所有会改变问题是否成立的条件，以及谁或什么激活缺陷；
4. **Causal Path and Immediate Result**：按执行顺序解释最短完整路径，直到具体状态、资产、权限或控制流结果；
5. **Impact Connection and Boundary**：将直接结果连接到已确认 Impact，并在必要时写明防止夸大的边界。

### 6.1 内容取舍

保留会改变以下任一内容的细节：

- 问题是否成立；
- actor 能否触发问题；
- 因果链能否闭合；
- 直接结果是什么；
- Impact 的范围、规模、持续时间或可恢复性；
- 安全修复所需恢复的约束。

省略仅用于展示调查过程、逐行复述代码、遍历无关调用链、重复同一行为或解释 Severity 的信息。实现细节只有在承担因果节点时才进入 Description。

长度由因果链复杂度决定，但 Description 不得超过六个英文句子。常见单路径 Finding 可以用三至六句完成；不得为满足上限删除条件、路径、Result 或边界。多路径 Finding 先合并真正共同的 Context，再在六句内分别保留各自的 Trigger、路径和 Result；如果多个路径无法在不丢失实质区别的情况下形成一个六句以内的 Finding，返回 `ISSUE_DRAFTING_BLOCKED: Fact Brief: <需要拆分的路径及原因>`，由上游决定 Finding 范围。

### 6.2 Expected 与 Actual 的对照

优先使用清楚的对照结构：

```text
<Subject> is expected to <required behavior>. However, <implementation> <deviation>.
```

Expected Property 必须来自项目设计、代码不变量、协议语义或用户确认，不能仅因为某种实现“通常更安全”而假定。`However,` 只用于真实对照；没有对照关系时直接陈述 Root Cause。

### 6.3 Actor 与故障类型

- 存在主动利用路径时，准确说明 actor 的权限与操作；只有恶意意图影响解释时才称 `attacker`；
- 普通用户同样能够触发时，使用 `user`，不要为了增强语气改称 `attacker`；
- 无需 actor 的确定性故障使用事件、状态或系统组件作主语；
- 权限角色触发问题时，明确角色，而不是笼统写 `privileged user`；
- 外部依赖参与因果链时，只陈述已确认的行为和边界。

### 6.4 因果连接

连接词必须与逻辑关系一致：

- `because`：给出原因；
- `when` / `if`：给出触发条件；
- `However,`：对照 Expected 与 Actual；
- `Consequently,` / `As a result,`：引出直接后果；
- `Therefore,`：从前述事实得出结论；
- `Meanwhile,`：只表示并行行为，不表示因果；
- `Furthermore,`：只表示风险升级，不表示普通补充。

相邻句子的时间顺序不能代替因果关系。必须让读者看出“哪一事实导致哪一结果”。

### 6.5 Description 完成标准

Description 完成时：

- Root Cause 与表面症状、Immediate Result、Impact 清楚分离；
- 每个必要条件都出现在触发相应结果之前；
- 每个 Impact 主张都已经由 Description 中的事实和路径建立；
- 确定性路径使用确定表达，条件性路径写明具体条件；
- 多路径之间没有因合并而丢失区别；
- 不依赖代码片段、Title 或读者自行推理来补齐因果链。

## 7. Impact

Impact 使用 `Impact Brief.impact.description` 写成一个可独立理解的英文句子。它回答“谁或什么受到什么具体安全后果”，而不是再次解释代码缺陷。

Impact 必须：

- 只陈述已经确认的最严重且现实的一个后果；
- 指明受影响的 actor、asset、state、operation 或 security property；
- 只在省略边界会实质夸大成立概率或范围时加入必要边界；
- 能从 Description 中已经建立的事实推出；
- 与 `Impact Brief` 的结论、条件和边界保持同等强度；
- 恰好一个句子。

Impact 不包含 Root Cause、完整攻击路径、修复措施、Severity 理由或理论上的最大后果。不要把 `incorrect behavior`、`unexpected result`、`security risk` 或 `potential loss` 单独当作 Impact；这些表达没有说明受影响对象与具体后果。

通用逻辑形式：

```text
<Actor or affected object> can/will/may <concrete adverse consequence> [under the material boundary].
```

## 8. Suggestion

Suggestion 把 Remediation Invariant 转换成一个祈使句。它必须处理 Root Cause 并恢复 Expected Property，而不是只隐藏可见症状或阻断一个示例输入。

Suggestion 的写法：

1. 使用信息明确的动词开头，例如 `Validate`、`Require`、`Bind`、`Restrict`、`Enforce`、`Track`、`Update`、`Remove`、`Preserve` 或 `Compute`；
2. 指明受影响函数、生命周期阶段、状态变量、输入、顺序或必须保持的不变量；
3. 说明修复后必须满足的行为；
4. 多项修改同属一个不可分割的修复目标时，在一个并列结构中完整表达；
5. Brief 只支持目标行为而不支持唯一实现时，描述目标行为并保留实现选择；
6. Brief 已证明只有特定修改能够正确恢复不变量时，可以写明该修改。

不要使用 `Revise the logic accordingly`、`Handle the issue properly`、`Improve validation` 或 `Fix the code` 一类无法据此实施和复核的句子。不要添加新的防御性措施、监控、迁移、测试、重试或架构调整，除非它们是修复已确认 Root Cause 的必要组成部分。

Suggestion 完成标准：开发者能够据此判断修复是否恢复了预期属性；同时，句子没有越过 Brief 去指定未经证实的实现偏好。

## 9. Code locations

Code locations 只从 `Fact Brief.evidence` 中选择。每个位置使用 repo-relative 的最小闭区间：

```text
- path/to/File.ext:start-end
```

纳入：

- 直接证明 Root Cause 或 Deviation 的范围；
- 为证明差异而必需的对照范围；
- 多路径各自直接证明不同缺陷时的最小范围。

排除仅提供背景、只证明下游 Impact、重复同一事实、或只是调用链中间节点的范围。去重后按 Description 中首次使用的顺序排列。没有具体代码位置时，只有 `Fact Brief` 已明确确认该事实，才使用以下一种形式：

- 协议级 Finding：`Not applicable — protocol-level finding`；
- 非协议级、仅由审计人员确认、权威外部来源或纯运行条件支持的 Finding：`Not applicable — no repository location`。

Code locations 用于定位证据，不在这里重复代码片段或解释代码。

## 10. 确定性与 Issue 语气

Security Issue 的语气应当明确、书面且以证据为准。对已证实的 Root Cause 使用直接陈述；对路径和 Impact 按实际条件选择情态动词：

| 表达 | 使用条件 |
| --- | --- |
| `does`, `is`, `fails to` | 当前实现或缺陷已经由事实证实 |
| `will` | 一旦所列条件成立，结果必然发生 |
| `can` | actor 已被证明具有产生结果的能力 |
| `may` | 结果取决于尚未固定的外部条件 |
| `could` | 后果合理但不是确定发生，且条件已经说明 |

避免双重弱化，如 `can potentially`、`may possibly`、`could potentially`。不要用 `appears to`、`seems to` 或 `might be` 隐藏尚未解决的事实问题；应返回上游补充 Brief。反之，也不要把 `may` 改成 `will`，或把一个受限路径写成无条件结果。

问题的严重性来自已证实的因果链和 Impact，不来自 `critical`、`severe`、`significant`、`arbitrary`、`permanent`、`all` 或 `complete` 等形容词。只有 Brief 直接支持这些限定词时才使用。

## 11. 英文表达

最终 Finding 使用规范的技术英语：

- 使用现在时和第三人称；
- actor 重要时优先使用主动语态，采用清楚的 subject–verb–object 结构；
- 每句承载一个主要主张，必要的条件从句紧邻其所约束的结果；
- 使用具体动词描述代码行为，例如 `stores`、`computes`、`skips`、`accepts`、`reverts`、`overwrites`、`authorizes`；
- 避免以 `There is` 或 `There are` 开始，直接让实际对象作主语；
- 避免主观形容词和副词，用可证实的条件、范围或数值替代；
- 避免连续堆叠多个名词修饰同一名词；必要时改成介词短语或从句；
- 同一概念始终使用同一术语，不为避免重复而更换同义词；
- 保留必要冠词和介词，不使用为了缩短而形成的不自然“电报式”英语；
- 只在缩写确实通用或已在术语 Brief 中建立时使用缩写；
- 不使用口语、宣传语、比喻、反问或面向读者的 `you`；
- 不逐行翻译代码，而是解释行为、关系和状态变化。

具体项目标识符使用反引号，并在首次出现时配合语义类型：

```text
Function `foo()` validates ...
In contract `Bar`, function `foo()` ...
Variable `totalAssets` stores ...
Functions `a()`, `b()`, and `c()` ...
```

函数名保留 `()`；contract、function、file、variable、parameter、mapping、role、modifier、event、error、struct、module、interface、class、library 和精确配置值等项目标识符使用反引号。普通技术概念和语义类型词不使用反引号。

## 12. 常见失真及修正目标

| 失真 | 问题 | 修正目标 |
| --- | --- | --- |
| 只写漏洞类别 | 类别不能证明当前 Finding | 写明 Subject、Root Cause、Trigger 和 Result |
| 先写攻击者，后补机制 | 风险叙事先于事实 | 先建立 Expected–Actual 对照，再引入必要 actor |
| 把可能性附着在缺陷上 | 已证实问题被写成猜测 | 直接陈述缺陷，把条件附着在路径或后果上 |
| 跳过 Immediate Result | Root Cause 与 Impact 之间断链 | 补齐首个状态、资产、权限或控制流变化 |
| 把理论最大值当 Impact | 超过现实路径与边界 | 采用 `Impact Brief` 确认的最严重现实后果 |
| Description 与 Impact 重复 | 字段失去分工 | Description 证明，Impact 单句总结后果 |
| Suggestion 只写“revise logic” | 无法实施或复核 | 指明必须恢复的不变量与准确目标行为 |
| 为显得专业而创造术语 | 含义不可追溯 | 使用 `Terminology Brief` 或普通技术语言 |
| 合并不同路径 | 条件或结果被隐藏 | 保留稳定路径边界，只合并共同步骤 |
| 一句包含多个因果分支 | 主张关系难以验证 | 每句一个主张，按执行顺序拆分 |
| 罗列代码操作 | 读者仍需自行推导问题 | 解释代码行为在因果链中的作用 |
| 修复一个示例输入 | 根因仍可由其他路径触发 | 修复 Root Cause 或恢复 Expected Property |

## 13. 输出格式

只输出以下字段，并保持顺序：

```text
**Title:** <defect or consequence noun phrase>

**Description:**

<complete causal explanation>

**Impact:**

<exactly one sentence>

**Suggestion:**

<one imperative sentence>

**Code locations:**

- <repo-relative minimal closed range>
```

Severity 从 `Impact Brief.severity.level` 原样交给报告元数据层，不在这些文本字段中重复。Status、Introduced by、项目反馈和修复版本只在其他流程已经明确提供相应事实和输出字段时处理；本阶段不自行生成。

## 14. 最终一致性检查

返回 Finding 前逐项验证：

### 事实与因果

- 每个事实都来自 `Fact Brief`，每个 Impact 结论都来自 `Impact Brief`；
- Expected Property、Root Cause、Preconditions、Trigger、Causal Path、Immediate Result 和 Impact 之间没有缺口；
- Impact 可以由 Description 推出，且没有比 Brief 更强；
- 所有必要边界已经保留，没有把局部、有条件或可恢复的问题写成全局、无条件或永久问题；
- 多路径的条件、机制和 Result 仍可分别识别。

### 字段职责

- Title 同时识别 Subject 与区别性问题；
- Description 独立、完整地证明问题；
- Impact 只陈述一个最严重且现实的后果，并且只有一个句子；
- Suggestion 直接处理 Root Cause、恢复 Expected Property，并且是一个可执行的祈使句；
- Code locations 最小、准确、去重，并直接证明缺陷。

### 术语与语言

- 每个专业术语都按 `Terminology Brief` 的定义和语境使用；
- 缺少专业术语时使用清楚的普通技术语言；
- actor、时态、情态动词和连接词准确反映事实关系；
- 每句只有一个主要主张，主语、动词、宾语和修饰关系自然；
- 标识符、函数括号、大小写、标点和字段格式一致。

### Security Issue 语境

- 文本明确陈述已经证实的预期偏差，而不是把它写成改进机会；
- 条件性后果保留条件，但 Root Cause 不被无依据地弱化；
- 没有引入未经证实的攻击者能力、资产损失、权限、范围、修复方案或严重程度；
- 删除任何不承担事实、因果、边界、修复或定位职责的句子。

全部通过后，只返回完整 Finding，不附带候选标题、推理过程、检查结果、术语研究过程或写作说明。
