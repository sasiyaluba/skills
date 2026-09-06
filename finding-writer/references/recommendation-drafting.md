# Recommendation Drafting

基于完整的 `Fact Brief` 和 `Terminology Brief`，并在已有 Impact Assessment 时先验证 Finding Type 兼容性，编写可直接进入审计报告的 Recommendation。最终 Finding 使用英文；本文件定义从上游分析结果到最终文本的通用推导方法，不重新调查事实、夸大后果或搜索术语。

## 1. Recommendation 的边界

Recommendation 请求一项具体改进，但现有事实没有建立具体的安全属性违反和不利安全后果。它通常改善标准符合性、防御性验证、健壮性、一致性、可维护性、可观测性、可用性、集成体验或执行效率。

Recommendation 不是低等级 Security Issue：

- 只要事实已经证明资产安全、权限、数据完整性、可用性、协议运行或用户利益受到具体安全影响，就应返回 Security Issue 分类，即使影响很小；
- 如果内容只是披露设计选择、信任假设、特权能力、外部依赖或运维义务，而不要求修改当前实现，就应返回 Note 分类；
- 只有“当前行为存在明确改进空间，但没有已经成立的安全属性违反”时，才继续 Recommendation drafting。

历史报告中的 Finding Type 和字段安排只能作为表达样本，不能覆盖上述类型定义。历史 Recommendation 一旦包含已证实的资产损失、权限突破、伪造、未授权操作或其他具体安全后果，应视为分类反例并返回分类，而不是把该写法提炼成通用规则。

发现类型不兼容时，只返回：

```text
RETURN_TO_CLASSIFICATION: <具体的不兼容事实及其对应类型>
```

不得通过删掉攻击路径、弱化 Impact 或改写情态动词，把一个 Security Issue 强行写成 Recommendation。

## 2. 输入边界

写作前读取：

- `references/finding-grounding.md` 产出的 `Fact Brief`；
- `references/terminology-discovery.md` 产出的 `Terminology Brief`；
- `references/impact-assessment.md` 的结论或其产出的 `Impact Brief`，如果上游已经执行 Impact Assessment。

这些输入在 Recommendation 中承担不同职责：

- `Fact Brief` 是当前行为、改进缺口、直接价值、可选的有限非安全后果、改进范围、目标行为和证据的事实来源；
- Impact Assessment 是 Finding Type 的兼容性门槛，而不是为 Recommendation 生成 Severity 的步骤；
- `Terminology Brief` 只提供词汇证据，不能补充事实、改进价值、后果或实现方案。

如果 `Impact Brief` 已经确认具体安全 Impact 并给出 High、Medium 或 Low 等级，当前 Finding 与 Recommendation 不兼容，应返回分类。Recommendation 不继承、不降低也不输出该 Severity。

Recommendation 可以包含一个已经证实、范围有限且不构成安全属性违反的非安全后果。该后果应来自 `Fact Brief` 中的事实；不能为了填充 Impact 字段，把“更清楚”“更一致”“更易维护”等直接价值改写成后果。

### 2.1 输入完成条件

开始写作前确认：

1. `Fact Brief` 清楚说明当前行为及直接证据；
2. 改进缺口能够与当前行为明确区分；
3. 直接价值具体说明为什么改进值得实施，而不是只有 `for clarity`、`for maintainability` 或 `best practice` 等分类标签；
4. 目标行为足以形成可实施、可复核的 Suggestion；
5. 可选的非安全后果已经证实、范围有限，并且不同于 Direct Rationale；
6. 事实没有建立具体安全属性违反，也不是仅供披露的设计或信任条件；
7. 所有计划采用的专业术语都能在 `Terminology Brief` 中找到对应定义、用途和边界；没有准确专业术语的概念使用普通技术语言；
8. 输入之间没有未解决的矛盾。

输入不完整但 Finding Type 仍然兼容时，只返回：

```text
RECOMMENDATION_DRAFTING_BLOCKED: <Fact Brief | Terminology Brief | Impact Assessment>: <具体缺失或冲突>
```

## 3. Recommendation 的核心逻辑

写作前先建立以下逻辑链：

```text
Current Behavior
    -> Improvement Gap
    -> Direct Rationale
    -> [Bounded Non-Security Consequence]
    -> Remediation Goal
```

也可以形式化为：

```text
当前实现或设计存在行为 A；
相对目标质量 Q，A 存在改进缺口 G；
消除 G 会直接带来价值 V；
如果存在独立且已确认的有限非安全后果 C，则单独记录 C；
改进目标 R 定义修复后应达到的行为，而不扩大到未证实的问题。
```

各节点含义如下：

- **Current Behavior**：相关代码、设计、接口、文档或配置现在实际做什么；
- **Improvement Gap**：当前行为在标准、验证、健壮性、一致性、可维护性、可观测性、可用性或效率方面的具体不足；
- **Direct Rationale**：消除该不足会直接改善什么，以及为什么；
- **Bounded Non-Security Consequence**：可选的、已经发生或可明确推出的有限非安全结果；
- **Remediation Goal**：改进后应满足的目标行为、约束、范围或生命周期位置。

Recommendation 不需要复制 Security Issue 的完整结构。只有当 actor、输入、执行顺序、生命周期阶段或局部结果会改变改进价值或安全实施方式时，才保留这些信息。不要为了让 Recommendation 显得重要而构造 Preconditions、Trigger、Attack Path、Immediate Result 和安全 Impact。

## 4. 字段分工

| 字段 | 职责 | 读者应得到的答案 |
| --- | --- | --- |
| Title | 识别改进 | 应对哪个对象采取什么区别性改进？ |
| Description | 解释改进 | 当前行为是什么、具体不足是什么、改进为何有直接价值？ |
| Impact | 陈述例外后果 | 是否存在独立、有限且非安全的已确认后果？ |
| Suggestion | 定义目标行为 | 实现完成后必须满足什么具体要求？ |
| Code locations | 定位事实 | 哪些最小范围直接证明当前行为或改进缺口？ |

字段构成“识别—解释—可选后果—实施—定位”的关系：

- Title 是简短索引；
- Description 建立改进逻辑；
- Impact 默认不存在；
- Suggestion 给出准确目标；
- Code locations 绑定证据。

Description 不提前给出完整 Suggestion，Suggestion 也不重复 Description 的背景和理由。Title 与 Suggestion 可以共享核心动词，但 Suggestion 必须提供 Title 无法容纳的准确目标、范围或时机。

## 5. 起草流程

### 5.1 建立 Recommendation Map

从输入中提取以下内部映射：

```text
Subject:
Current Behavior:
Improvement Gap:
Direct Rationale:
Bounded Non-Security Consequence:   # 可选
Remediation Goal:
Necessary Scope / Lifecycle Timing:
Direct Evidence:
Preferred Terms:
```

完成标准：

- Current Behavior 与 Improvement Gap 是两个不同命题；
- Direct Rationale 能从二者直接推出，并说明真实价值；
- 可选 Consequence 不重复 Rationale，不暗示安全属性违反；
- Remediation Goal 精确覆盖 Gap，但不添加“顺便”改进；
- 每项事实都有 `Fact Brief` Evidence 或已确认外部事实支持。

### 5.2 判断是否合并多个位置

当多个位置具有相同的 Current Behavior、Improvement Gap、Direct Rationale 和 Remediation Goal 时，将它们合并为一项 Recommendation，并在 Description 中集中说明范围。

以下任一项不同，就保留为独立 Recommendation 或在当前 Finding 中明确区分：

- 改进价值；
- 安全实施方式；
- 生命周期时机；
- 目标行为；
- 所需证据；
- 一项修改是否可以独立完成。

不要只因为多个位置都属于“validation”“documentation”或“redundant code”就合并。类别相同不代表改进逻辑相同。

### 5.3 映射术语

依据 `Terminology Brief` 使用词汇：

- `domain` 描述 Subject 和 Current Behavior；
- `mechanism` 描述现有机制和改进目标；
- `security_property` 仅用于确认没有被具体违反，不能用来制造 Security Issue 语气；
- `failure_mode` 只有在来源含义与非安全改进缺口一致时才使用；
- `impact` 术语只用于确实存在的 Bounded Non-Security Consequence。

标准名称、协议机制、设计模式和工程术语必须按来源中的准确含义使用。不能仅因为某个术语听起来更权威，就用它替代普通而准确的描述。

### 5.4 分配内容后再写句子

先确定每条信息属于哪个字段，再写最终英文：

- Subject 与区别性 Improvement 进入 Title；
- Current Behavior、Improvement Gap 和 Direct Rationale 进入 Description；
- 独立的 Bounded Non-Security Consequence 才进入 Impact；
- Remediation Goal 与必要范围进入 Suggestion；
- 直接证明 Current Behavior 或 Gap 的 Evidence 进入 Code locations。

完成后检查是否有一个事实被多个字段完整重复；如有，保留在职责最匹配的字段，并让其他字段只承担必要的连接作用。

## 6. Title

Recommendation 的 Title 通常使用祈使短语，直接指出具体改进。先在内部形成至少三个实质不同的候选，再选择最短、最自然且保留完整 Title Kernel 的一个。

```text
Title Kernel = Affected Subject + Distinguishing Improvement
```

### 6.1 优先形式

使用信息明确的原形动词：

```text
Add <missing capability or validation> to <subject>
Remove <redundant, obsolete, or misleading element>
Align <artifact or behavior> with <authoritative counterpart>
Use <established mechanism> for <purpose>
Emit <event or data> for <operation>
Expose <state or capability> through <interface>
Rename <identifier> to reflect <actual meaning>
Validate <input or relation> before <operation>
Document <behavior, constraint, or assumption>
Consolidate <duplicated behavior> in <shared location>
```

模板只表示逻辑形式。最终措辞必须符合当前机制的自然搭配，不能机械替换占位符。

优先选择能够准确描述改进的动词，如 `Add`、`Remove`、`Align`、`Use`、`Emit`、`Expose`、`Rename`、`Validate`、`Document`、`Consolidate`、`Restrict`、`Return` 或 `Preserve`。当 Brief 支持更具体动作时，不使用 `Improve`、`Update`、`Revise`、`Fix` 或 `Handle` 等宽泛动词。

### 6.2 非祈使形式

当祈使 Title 会虚假指定唯一实现，而 Fact Brief 只确定目标质量时，使用简洁的非安全缺口短语。该短语必须识别 Subject 与具体 Gap，不能使用 `Potential issue`、`Improper logic` 或 `Code quality` 等类别标签。

### 6.3 Title 完成标准

Title 必须：

- 同时说明改进动作或 Gap 与 Affected Subject；
- 使用 sentence case；
- 不以 gerund 开头；
- 不包含 Severity、攻击者、利用结果、`vulnerability`、`security issue` 或风险宣传；
- 不把未经证实的实现选择写成唯一正确答案；
- 在不丢失必要标识符或区别性事实时，尽量控制在 12 个英文单词以内；
- 能与同一报告中关于相似对象的其他 Recommendation 区分。

## 7. Description

Description 是 Recommendation Map 的按比例压缩：

```text
Current Behavior -> Improvement Gap -> Direct Rationale
```

该顺序是逻辑要求，不是固定句式。使用足够的句子让开发者理解“当前是什么、哪里值得改、改进带来什么直接价值”。

### 7.1 Current Behavior

只说明理解 Gap 所需的实现或设计事实：

- 相关组件的用途；
- 当前数据、控制流、接口、文档或配置行为；
- 能够证明差异的必要对照；
- 会改变目标行为的范围或生命周期阶段。

不要逐行复述代码，也不要保留与改进目标无关的调用链、调查历史、替代假设或版本演变。

### 7.2 Improvement Gap

用一个可验证的命题说明不足。Gap 应指出当前行为与准确目标之间的差异，例如缺少可查询能力、重复工作、接口与实现不一致、命名无法反映实际语义、事件缺少必要上下文，或校验发生在不合适的阶段。

这些类别不能直接作为最终文字。必须说明具体对象、具体差异和相关范围。`The code can be improved`、`The logic is improper` 和 `The implementation is not best practice` 都不是充分的 Gap。

当 Gap 依据标准、规范或权威设计模式成立时：

- 写明准确标准或规则；
- 确认它确实适用于当前组件和版本；
- 说明当前行为与该要求的具体差异；
- 不把可选惯例写成强制要求；
- 术语和要求必须能追溯到 `Terminology Brief` 或 `Fact Brief` Evidence。

### 7.3 Direct Rationale

Direct Rationale 回答“为什么这项改进在当前项目中有直接价值”。它应连接 Gap 与一个具体工程结果，例如：

- 让接口消费者能够直接获得必要状态；
- 使实现、接口和文档表达同一语义；
- 消除重复计算、存储、调用或无效分支；
- 使错误在正确边界被识别并返回；
- 让事件携带足以被可靠归属的信息；
- 防止无效配置或无意义操作进入后续流程。

这些仍然只是逻辑类别。只有 Fact Brief 证明的具体价值才能写入 Finding。不能用 `for clarity`、`for readability`、`for maintainability`、`for safety` 或 `to follow best practices` 单独代替 Rationale。

### 7.4 Recommendation 语气

Description 使用中性、确定、书面的表达：

- 直接陈述已经证实的 Current Behavior 和 Gap；
- 使用 `However,` 对照两个真实不一致的行为；
- 使用 `This requires ...`、`This leaves ...` 或具体动词说明直接价值；
- 不在 Description 中写 `It is recommended to ...`，因为 Suggestion 专门承担该职责；
- 不使用 `attacker`、`exploit`、`drain`、`steal`、`unauthorized`、`permanent loss` 或类似 Security Issue 语言；如果这些词准确描述已证实事实，应返回分类；
- 不用 `potential risk` 或假设性事故让改进显得更严重。

### 7.5 比例与长度

常见 Recommendation 可以用两至四句完成，且 Description 不得超过六个英文句子。长度由理解 Current Behavior、Gap 和 Rationale 所需的信息决定：

- 单一、局部 Gap 保持直接；
- 多个同构位置可以用列表或并列结构集中说明；
- 存在会改变安全实施方式的生命周期差异时，完整保留；
- 不为追求简短删除必要对照、范围或 Rationale；
- 也不加入 Security Issue 式的完整触发链和理论后果。

完成标准：未阅读代码的技术读者能够准确解释当前行为、具体改进缺口和改进价值，并且不会把文本误读为已经发生的安全属性违反。

## 8. Impact

Recommendation 默认不输出 Impact。只有 `Fact Brief` 明确包含一个独立、已确认、范围有限且非安全的后果时，才添加 Impact 字段。

该后果必须同时满足：

1. **Observable**：能够由事实观察或直接推出；
2. **Bounded**：发生范围、对象或程度明确有限；
3. **Non-security**：不构成资产、权限、数据完整性、可用性、协议运行或用户安全方面的具体违反；
4. **Distinct**：不是 Direct Rationale 换一种说法；
5. **Supported**：不依赖猜测、理论事故或未确认部署条件。

Impact 写成一个可独立理解的英文句子。它不重复 Gap、Suggestion 或一般工程价值，不加入 Severity，也不使用安全风险语言。

以下内容通常属于 Direct Rationale，而不是独立 Impact：

- 代码更难阅读；
- 接口不够清楚；
- 文档可能令人困惑；
- 维护工作可能增加；
- 实现不符合惯例。

只有当 Fact Brief 证明了具体、独立且有限的结果时，才保留 Impact。无法清楚区分时，省略字段。

历史 Recommendation 曾经输出 Impact，不代表该后果满足本节门槛。逐项执行 Observable、Bounded、Non-security、Distinct 和 Supported 检查；不满足任一项时省略 Impact，或在存在具体安全后果时返回分类。

## 9. Suggestion

Suggestion 将 Remediation Goal 写成一个祈使句。开发者应能根据该句实施改进，复核人员也应能判断目标是否达成。

Suggestion 必须：

1. 以准确的原形动词开头；
2. 指明需要修改的对象；
3. 写明目标行为、约束或一致性关系；
4. 保留必要的范围和生命周期时机；
5. 覆盖 Description 中所有共用同一 Gap 的位置；
6. 只处理当前 Recommendation，不加入额外 hardening、重构、监控、测试、迁移或架构调整；
7. 只在 Fact Brief 支持唯一实现时写明具体实现方式。

### 9.1 Title 与 Suggestion 的区别

Title 用于索引，可以是：

```text
Align the interface with the implementation
```

Suggestion 应提供可复核的目标，例如：

```text
Declare every externally supported operation in the public interface and keep its parameter semantics aligned with the implementation.
```

不能仅把 Title 原样复制为 Suggestion，除非 Title 已经包含完整目标、范围和行为，而且继续扩写只会重复信息。

### 9.2 多项改动

多个动作是同一 Remediation Goal 的不可分割部分时，用并列结构写成一个句子：

```text
<Verb A> <target A>, and <verb B> <target B> so that <required relation>.
```

如果动作能够独立实施、解决不同 Gap 或具有不同 Rationale，应拆分 Recommendation，而不是用一个过长 Suggestion 捆绑。

### 9.3 实现选择

- 只有一个已经证实的正确实现：写明该实现；
- 多种实现都可恢复目标行为：优先描述共同目标和约束，让项目选择实现；
- 只有 Fact Brief 已经证明多个方案都完整、等价地关闭同一 Gap，且不会改变安全性、外部语义或兼容性时，才可以在一个句子中列出备选方案，并写明它们共同满足的完成条件；
- 实现与文档不一致，但 Fact Brief 已确认“一致性”本身就是目标且两侧语义均可接受时，使用 `Align ...`，必要时列出经过证明的等价方案；
- 如果选择不同方案会改变产品语义、安全性或兼容性，返回 Fact Brief 补充权威预期；
- 不能通过 `either X or Y` 掩盖尚未解决的产品决策。

不要使用：

```text
Revise the logic accordingly.
Handle the issue properly.
Improve the code.
Add proper validation.
Update the documentation accordingly.
```

用具体目标替代 `logic`、`code`、`proper` 和 `accordingly`。Suggestion 完成时，读者无需返回 Description 猜测“究竟要改什么”。

## 10. Code locations

Code locations 只从 `Fact Brief.evidence` 中选择，每个位置使用 repo-relative 的最小闭区间：

```text
- path/to/File.ext:start-end
```

纳入：

- 直接证明 Current Behavior 的范围；
- 直接证明 Improvement Gap 的范围；
- 为建立不一致或差异而必需的对照范围；
- 多个同构位置中各自证明受影响范围的最小位置。

排除：

- 只提供背景或 Rationale 的位置；
- 与 Gap 无关的调用链中间节点；
- 重复证明同一事实的更大范围；
- 仅用于展示代码风格但不建立当前 Recommendation 的位置。

去重后按 Description 首次使用顺序排列。没有具体代码位置时，只有 `Fact Brief` 已明确确认该事实，才使用以下一种形式：

- 协议级 Recommendation：`Not applicable — protocol-level finding`；
- 非协议级、仅由审计人员确认、权威外部来源或纯运行条件支持的 Recommendation：`Not applicable — no repository location`。

Code locations 只定位证据，不重复代码片段或分析说明。

## 11. 确定性

情态动词必须匹配已经建立的事实：

| 表达 | 使用条件 |
| --- | --- |
| `does`, `is`, `uses`, `omits` | Current Behavior 或 Gap 已经证实 |
| `will` | 在已说明条件下，有限非安全结果必然发生 |
| `can` | 组件或用户具有已经证明的非安全能力 |
| `may` | 结果取决于未固定的外部条件 |
| `could` | 后果合理但非确定，并且仍属于有限非安全结果 |

对已证实的 Current Behavior 不使用 `appears to`、`seems to` 或 `might be`。事实仍不确定时返回上游补充 Brief。避免 `can potentially`、`may possibly` 和 `could potentially` 等双重弱化。

Recommendation 的价值不需要通过 `critical`、`severe`、`significant` 或 `security-sensitive` 等词增强。使用事实说明改进价值，并保持与实际范围一致。

## 12. 英文表达

最终 Finding 使用规范的技术英语：

- 使用现在时和第三人称；
- actor 重要时优先使用主动语态；
- 采用清楚的 subject–verb–object 结构；
- 每句承担一个主要主张；
- 条件放在它所约束的行为或指令之前；
- 使用具体动词，例如 `stores`、`returns`、`omits`、`duplicates`、`emits`、`exposes`、`computes`、`documents`；
- 避免以 `There is` 或 `There are` 开始，让实际组件作主语；
- 避免主观形容词和副词，用可证实的差异、范围或数值替代；
- 避免长 noun stack，必要时改成介词短语或从句；
- 同一概念使用同一术语，不为避免重复而更换同义词；
- 保留必要冠词和介词，不使用压缩过度的电报式英语；
- 不使用口语、宣传语、比喻、反问或面向读者的 `you`；
- 不逐行翻译代码，说明行为和关系。

具体项目标识符使用反引号，并在首次出现时配合语义类型：

```text
Function `foo()` returns ...
In contract `Bar`, function `foo()` ...
Variable `totalAssets` stores ...
Functions `a()`, `b()`, and `c()` ...
File `path/to/File.sol` documents ...
```

函数名保留 `()`；contract、function、file、variable、parameter、mapping、role、modifier、event、error、struct、module、interface、class、library 和精确配置值等项目标识符使用反引号。普通技术概念和语义类型词不使用反引号。

## 13. 常见失真及修正目标

| 失真 | 问题 | 修正目标 |
| --- | --- | --- |
| 把 Recommendation 写成低等级漏洞 | 类型边界被破坏 | 有具体安全属性违反时返回分类 |
| Title 只写 `Improve code quality` | 无法识别动作和对象 | 写明区别性动词与 Subject |
| Description 以 `It is recommended` 开始 | 提前重复 Suggestion | 先陈述 Current Behavior、Gap 和 Rationale |
| 只写 `for clarity` 或 `best practice` | 没有证明直接价值 | 写明该改进如何改变当前工程行为 |
| 构造攻击路径或理论事故 | 人为提高重要性 | 保留 Recommendation 级别的最小事实链 |
| 把 Direct Rationale 写成 Impact | 可选字段失去门槛 | 仅保留独立、有限、已确认的非安全后果 |
| Title 与 Suggestion 完全相同 | Suggestion 没有实施信息 | 在 Suggestion 中加入准确目标、范围和时机 |
| Suggestion 使用 `accordingly` | 读者必须猜测修改内容 | 明确对象、行为和完成条件 |
| 引用 `best practice` 但无来源 | 要求不可追溯 | 指明适用标准及当前差异 |
| 合并同类别但不同目标的位置 | Gap 和修复逻辑被隐藏 | 只合并 Behavior、Gap、Rationale、Goal 相同的位置 |
| 罗列全部调用链和版本历史 | 信息与改进无关 | 只保留理解和安全实施所需事实 |
| 指定未经证实的唯一实现 | 限制项目的正确选择 | Brief 只支持目标时描述目标行为 |
| 在 Suggestion 中加入顺便改进 | 扩大 Finding 范围 | 只关闭当前已建立的 Improvement Gap |

## 14. 输出格式

默认只输出以下字段，并保持顺序：

```text
**Title:** <imperative improvement phrase or precise non-security gap phrase>

**Description:**

<current behavior, improvement gap, and direct rationale>

**Suggestion:**

<one imperative sentence>

**Code locations:**

- <repo-relative minimal closed range>
```

只有存在满足全部门槛的 Bounded Non-Security Consequence 时，才在 Description 与 Suggestion 之间加入：

```text
**Impact:**

<exactly one bounded non-security consequence sentence>
```

没有 Bounded Non-Security Consequence 时，完整省略 Impact 标签及其空行，不输出 `N/A`、`None` 或占位符。

Recommendation 不输出 Severity。Status、Introduced by、项目反馈、修复版本和报告级元数据只在其他流程明确提供相应字段时处理；本阶段不自行生成。

## 15. 最终一致性检查

返回 Finding 前逐项验证：

### 类型

- 文本请求具体改进，但没有声称已经发生具体安全属性违反；
- 没有通过弱化措辞隐藏 Security Issue；
- 内容不是仅供披露的设计、信任或运维条件；
- 未输出 Severity；
- 可选 Impact 保持有限、非安全并与 Rationale 不同。

### 事实与改进逻辑

- 每个事实都来自 `Fact Brief`；
- Current Behavior、Improvement Gap、Direct Rationale 和 Remediation Goal 均完整且互不替代；
- Gap 能从 Current Behavior 和目标质量的差异推出；
- Rationale 具体说明当前项目中的直接价值；
- Suggestion 精确关闭 Gap，没有处理下游症状或扩大范围；
- 所有必要的作用域、生命周期和多位置差异都已保留。

### 字段职责

- Title 同时识别 Subject 与区别性改进；
- Description 独立解释当前行为、Gap 和 Rationale；
- Impact 仅在满足全部门槛时出现，并且只有一个句子；
- Suggestion 是一个准确、可实施、可复核的祈使句；
- Code locations 最小、准确、去重，并直接证明 Behavior 或 Gap；
- Description、Impact 和 Suggestion 没有完整重复同一信息。

### 术语与英文

- 每个专业术语都按 `Terminology Brief` 的含义和语境使用；
- 没有准确术语时使用清楚的普通技术语言；
- 动词、情态词、连接词和条件位置反映真实关系；
- 每句只有一个主要主张，主语、动词、宾语和修饰关系自然；
- 标识符、函数括号、大小写、标点和字段格式一致；
- 文本保持中性、正式，没有安全风险宣传或含糊的“专业化”表达。

全部通过后，只返回完整 Recommendation，不附带候选标题、推理过程、检查结果、术语研究过程或写作说明。
