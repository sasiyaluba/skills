# Note Drafting

本文件给出 Security Note 的通用编写方法。它基于以下上游分析产物：

- `references/finding-grounding.md` 产出的 `Fact Brief`；
- `references/impact-assessment.md` 的结论或其产出的 `Impact Brief`，如果上游已经执行 Impact Assessment；
- `references/terminology-discovery.md` 产出的 `Terminology Brief`。

其目标不是把一个安全问题写得更委婉，也不是把一条建议删掉 `Suggestion` 后改名为 Note。Note 的任务是：**准确披露项目已经接受的设计选择、信任关系、权限能力、外部依赖、部署边界或运行条件，使读者知道系统在什么前提下才能正确或安全地运行，以及系统本身不保证什么。**

2026 年 1 月至 8 月的 94 份报告中，共检查了 339 个带 `\subsection` 的 Note 叶子文件：336 个由报告清单引用的最终 Note、2 个与已引用内容重复的孤立叶子，以及 1 个只有省略号的未完成孤立占位文件。下文只从 336 个报告实际采用的 Note 提炼稳定规则；孤立文件只用于核对覆盖范围，不作为独立先例。历史文件中的类型混淆、泛化标题、命令式措辞和无边界风险描述只作为反例，不构成优先于本文件的先例。

### Finding Polisher compatibility

由 `finding-polisher` 调用时，格式无关的 `Content Lock` 替代 `Fact Brief` 和已有的可选 Impact Assessment 输入，`Terminology Brief` 的职责不变。输入的标题、字段、顺序和格式不构成输出约束；先从语义单位建立 Note Map，再按本文件的字段职责和标准格式重新分配内容。下文所有事实来源、Evidence、接受依据、类型兼容性和语义一致性规则均对 `Content Lock` 执行。任何需要调查、评估、重新分类或新增实质内容的情况返回 `POLISH_DRAFTING_BLOCKED`，不得返回上游流程、修改已确认类型或补充输入没有的保证、假设或条件性后果。

## 1. Note 的类型边界

Note 披露一个**已经存在且已被接受的安全相关上下文**。典型对象包括：

- 某个角色被授予的权限及其信任要求；
- 正确运行依赖的链下服务、人工流程、第三方系统或外部数据；
- 部署链、运行环境、配置、调用顺序或集成方式的必要条件；
- 协议刻意采用、明确接受或由产品语义决定的行为；
- 系统提供的保证和明确不提供的保证；
- 使用者、运营方、治理方或集成方必须维持的操作前提。

Note 不声称当前实现违反了应当成立的安全属性，也不请求改变当前行为。可用下面的逻辑测试区分三种 Finding：

```text
D = 当前设计
A = 已接受的信任或运行假设
C = 不利后果

D ∧ A 仍然产生 C，且原因是未接受的实现偏差
    -> Security Issue

D 本身可接受，但希望改变 D 以获得更好的性质
    -> Recommendation

D 在 A 成立时按预期运行；仅当 A 不成立时才可能产生 C
    -> Note
```

这个测试关注后果的**因果归属**，而不是后果有多严重。受信任管理员被攻陷后可能造成严重损失，不会自动把已接受的权限模型变成 Security Issue；反之，即使后果较轻，只要它在所有已声明假设成立时仍由实现缺陷触发，就不是 Note。

### 1.1 必须返回类型判定的情况

遇到以下任一情况，不得继续编写 Note：

- 已确认当前实现偏离规范、设计或应成立的安全属性，并因此形成现实安全影响；
- 后果在所有已声明的信任和运行假设均成立时仍可发生；
- Finding 的核心目的，是要求项目增加检查、限制权限、调整流程、改变机制或采用另一种实现；
- 文本只有把 `should`、`recommend` 或 `consider` 删除后才像 Note，实质上仍在请求改变行为；
- 必须虚构“这是有意设计”或“项目已经接受”才能维持 Note 分类。

此时返回：

```text
RETURN_TO_CLASSIFICATION: <说明不相容事实及其因果关系>
```

不得自行加载另一个 Finding 分支，也不得用弱化语气掩盖类型冲突。

### 1.2 严重后果与 Note 并不矛盾

Note 可以说明严重的条件性后果，但必须同时满足：

1. 后果只在明确的信任或运行假设不成立时发生；
2. 该假设不由当前被审计实现负责强制保证，或其不被保证本身是已接受设计；
3. Note 的目的仍是披露这一前提，而不是要求修改设计；
4. 后果、条件和边界均已有事实支持。

若后果是当前实现直接造成的非预期安全属性违反，应转回 Security Issue；若项目虽接受现状但报告意图是推动改进，应转回 Recommendation。

## 2. 输入边界

### 2.1 `Fact Brief`

`Fact Brief` 是项目事实、机制和对象关系的来源；已有的 Impact Assessment 或 `Impact Brief` 校准已确认的条件性后果及其边界；`Terminology Brief` 只决定术语。编写前至少应能从 `Fact Brief` 中确认：

- **Subject**：被披露的组件、角色、依赖、流程或行为；
- **Design / Trust Context**：当前设计或信任关系究竟是什么；
- **Operational Assumption**：正确或安全运行依赖什么条件；
- **Responsible Party**：哪一方负责维持条件；仅在事实已经分配责任时填写；
- **Guaranteed Behavior**：系统在条件成立时明确保证什么；仅在有证据时填写；
- **Non-guaranteed Behavior**：系统明确不保证什么；仅在有证据时填写；
- **Conditional Consequence**：条件不成立时可能或必然发生什么；仅在已确认且有助于理解时填写；
- **Boundary**：适用对象、状态、链、配置、权限、时序或其他限制；
- **Relevant Project Position**：项目已经确认的设计意图、部署范围、受信任关系或运营安排；
- **Evidence**：支撑每项仓库事实的最小代码位置。

不要从代码沉默中推导承诺。例如，代码没有执行某项校验，不等于项目承诺链下系统一定会执行该校验；缺少链上保证也不等于可以断言所有集成都不安全。必须由 `Fact Brief` 明确说明实际依赖和边界。

### 2.2 `Impact Assessment` 与 `Impact Brief`

如果上游已经执行 Impact Assessment，其结论或 `Impact Brief` 在 Note 流程中的作用，是校准条件性后果及其边界，并再次检查类型是否兼容；Note 不要求为了填充字段而执行额外的 Impact Assessment，也不输出独立的 `Impact` 或 `Severity` 字段。

处理方式如下：

- 若已确认的后果只在 Operational Assumption 被违反时成立，可把该后果连同条件和边界写入 Description；
- 若后果在 Operational Assumption 成立时仍然成立，返回类型判定；
- 若前置分析没有确认任何有助于解释的后果，可以只披露假设、责任和保证边界；不要为了让 Note 看起来“更安全相关”而编造后果；
- 不把 Severity 写入 Note，也不根据 Severity 词汇增强语气；
- 不把一个条件性后果改写成无条件 Impact。

### 2.3 `Terminology Brief`

`Terminology Brief` 只决定术语选择，不提供新事实。使用时按概念映射，而不是按词汇堆砌：

- domain term 描述协议、产品和业务对象；
- mechanism term 描述权限、依赖、状态转换或运行机制；
- security-property term 描述被依赖、被保证或明确不保证的属性；
- failure-mode term 只描述假设失败时的已确认模式，不得暗示当前实现已经存在该缺陷；
- impact term 只用于已确认的 Conditional Consequence。

找不到精确专业术语时，使用清楚的普通技术语言。不得创造术语，也不得用 `centralization risk`、`security risk`、`trust issue` 等宽泛标签替代具体事实。

### 2.4 输入不完整

缺少以下任一信息且无法从前置产物确定时，停止编写：

- 当前设计或信任上下文；
- 需要披露的具体假设或边界；
- Note 分类得以成立的接受依据；
- 任何拟写入的 Responsible Party、Guaranteed Behavior、Non-guaranteed Behavior 或 Conditional Consequence 缺少依据、条件或边界；
- 使用专业术语所需的 Terminology Brief 依据。

返回：

```text
NOTE_DRAFTING_BLOCKED: <缺少或矛盾的具体字段>
```

不得用“通常”“一般而言”“理论上”等泛化知识补齐项目事实。

## 3. 核心逻辑链

一条完整 Note 的通用逻辑链是：

```text
Design / Trust Context
    -> Operational Assumption + Responsible Party
    -> Guaranteed Behavior / Non-guaranteed Behavior
    -> Conditional Consequence if the assumption fails
```

不是每条 Note 都需要显式写出链上的每一项，但任何被写出的后项都必须能由前项建立：

- 没有说明设计或信任上下文，就无法判断假设为什么存在；
- 没有说明具体假设，就无法判断谁需要做什么；
- 没有证据，不得声称系统提供或不提供某种保证；
- 没有触发条件，不得陈述条件性后果；
- 没有责任分配证据，不得自行把义务分配给项目方、用户或第三方。

可把核心关系表示为：

```text
Given <accepted design D>, correct or secure operation relies on <condition A>
maintained by <party P> within <boundary B>.
The system guarantees <G> and does not guarantee <N>.
If <A is false>, <consequence C> may or will occur under <B>.
```

这些占位符是逻辑角色，不是固定句式。草稿应形成自然、书面的英文，而不是逐项填模板。

## 4. 建立 `Note Map`

在写作前，将前置产物归一化为一张 `Note Map`：

```text
Subject:
Design / Trust Context:
Operational Assumption:
Responsible Party:
Guaranteed Behavior:
Non-guaranteed Behavior:
Conditional Consequence:
Consequence Condition:
Boundary:
Relevant Project Position:
Adopted Terms:
Evidence:
```

### 4.1 归一化规则

1. **Subject 必须具体。** 写角色、组件、机制或依赖，不写“system”“contract”“risk”这类无法定位主题的泛词。
2. **Context 必须是现状。** 说明现在如何设计、谁拥有什么能力、系统依赖什么，不写期望修改后的状态。
3. **Assumption 必须可判定。** “管理员值得信任”“链下服务正确运行”过于宽泛；应说明它具体需要维持哪项行为或属性。
4. **Responsible Party 只记录事实分配。** 如果代码和项目说明没有分配责任，就省略，不要把“依赖某条件”自动改成“项目必须保证”。
5. **Guaranteed 与 Non-guaranteed 分开。** 两者不是互为反义词，也不能由其中一个自动推导另一个。
6. **Conditional Consequence 必须绑定条件。** 记录触发条件、受影响对象、具体结果和必要边界。
7. **Project Position 只保留影响解释的内容。** 版本计划、客套回应和不影响类型或边界的信息不进入最终 Note。
8. **Evidence 必须按主张绑定。** 不因多个主张位于同一文件，就把整个文件或整个合约作为位置。

### 4.2 多个事实的合并与拆分

只在以下条件同时成立时，才把多个能力、依赖或条件合并为一条 Note：

- 它们属于同一个设计或信任上下文；
- 依赖同一个核心假设；
- 由同一责任方维持，或无需指出责任方；
- 保证边界和条件性后果相同；
- 合并后仍能用一个准确标题概括。

若不同事项具有不同责任方、不同运行条件、不同保证边界或不同后果，应拆分。不要因为它们都涉及 `owner`、链下服务或部署配置，就把它们合成一条泛化的“centralization risk”或“operational risk”。

## 5. Title

Title 应是中性的名词短语，直接标识被披露的设计属性、信任关系、运行条件或保证边界。读者只看标题，应能知道 Note 的主题，而不会误以为报告正在指控缺陷或要求修改。

### 5.1 可用的语义结构

按事实选择，不要机械套用：

```text
Reliance on <party or dependency> for <operation>
<Subject> trust assumption
<Subject> operational requirement
<Subject> deployment condition
<Subject> compatibility boundary
<Role> authority over <capability>
<Subject> non-guaranteed behavior
<Subject> integration requirement
```

Title 的两个基本组成通常是：

```text
<specific subject> + <disclosed relationship or condition>
```

例如，权限类标题应指出哪个角色控制什么能力；依赖类标题应指出依赖谁完成什么操作；部署类标题应指出具体兼容性或环境边界。

### 5.2 禁止的标题形式

- **命令式标题**：`Ensure ...`、`Use ...`、`Validate ...`；它们表达 Recommendation。
- **质量评价式标题**：`Proper ...`、`Better ...`、`Improved ...`；它们暗示当前实现应被改变。
- **缺陷式标题**：`Missing ...`、`Incorrect ...`、`Insufficient ...`、`Lack of ...`；除非这些词只是在准确命名已接受的非保证，否则通常表明 Security Issue 或 Recommendation。
- **泛化风险标题**：`Potential centralization risk`、`Security risks`、`Trust risks`；它们没有说明谁、拥有什么能力、依赖什么条件。
- **后果式标题**：只写资产损失、服务中断或账户冻结，而不写触发该后果的已接受上下文；这会使 Note 看起来像 Security Issue。
- **非正式或带评价的术语**：`weird token`、`dangerous admin`、`bad configuration`。
- **与 Description 不一致的标题**：标题说“dependency”，正文却主要请求增加校验；标题说“compatibility”，正文却证明了当前实现错误。

### 5.3 标题压缩原则

Title 不需要装入全部条件。保留能区分该 Note 的最小主题和关系，把精确条件、保证边界和后果放入 Description。不要在标题中重复函数列表，也不要用不受支持的形容词增强严重性。

## 6. Description

Description 应使不了解项目代码的读者，仅凭正文即可回答所有适用问题：

1. 当前设计或信任关系是什么？
2. 正确或安全运行依赖什么具体条件？
3. 如果责任已经分配，谁负责维持该条件？
4. 如果保证边界已经建立，系统明确保证什么、不保证什么？
5. 如果已确认条件性后果，条件不成立时会影响谁并产生什么具体结果？
6. 这些陈述适用于什么对象和边界？

### 6.1 推荐叙述顺序

通常按以下顺序组织：

1. **建立上下文**：说明组件、角色、依赖或行为在当前设计中的作用；
2. **陈述具体能力或依赖**：说明谁能做什么，或哪个机制依赖哪项外部行为；
3. **陈述运行假设**：说明正确运行要求维持的条件；
4. **说明保证边界**：区分系统保证和系统不保证的内容；
5. **说明责任方**：仅在责任已由事实分配时写入；
6. **绑定条件性后果**：说明假设失效时的具体结果和适用边界；
7. **整合项目立场**：若项目确认改变了设计意图或部署边界，在正文中以第三人称陈述。

顺序可以因可读性调整，但不得先用严重后果制造 Security Issue 语气，再到结尾补充“这其实是受信任设计”。读者应先理解已接受上下文，再理解为什么需要披露该前提。

### 6.2 首句应直接建立现状

使用直接、可验证的句子：

```text
By design, <component> relies on <dependency> to <operation>.
The <role> can <specific capability> within <scope>.
The protocol supports <scope> and does not enforce <external condition> on-chain.
Correct <operation> depends on <specific condition> maintained by <party>.
```

只有 `Fact Brief` 或 Relevant Project Position 已确认设计有意接受时，才使用 `By design`。不得凭分类结果反推“有意设计”。

避免以下空泛开头：

```text
There may be some risks.
This introduces potential centralization risks.
It should be noted that ...
Generally, trusted parties are important.
```

### 6.3 权限和信任关系

披露权限模型时，应写清：

- 具体角色或账户；
- 可执行的关键能力；
- 能力作用的对象和范围；
- 系统为何信任该角色；
- 权限被误用、账户被攻陷或职责未履行时的条件性后果。

不要把“存在管理员”直接等同于缺陷，也不要把所有权限函数逐行罗列。选择足以定义信任边界和后果的能力；若多个能力造成不同后果，则拆分或分别解释。

`centralization` 只有在 Terminology Brief 证明它准确描述治理或控制集中度时才使用。即使使用，也必须先写具体权限事实；`centralization risk` 不能替代能力、条件和后果。

### 6.4 外部和链下依赖

披露依赖时，应说明：

- 哪个链上或本地组件依赖哪个外部实体；
- 外部实体需要提供、验证、排序、签名、存储、监控或协调什么；
- 被审计系统能够验证哪些属性，不能验证哪些属性；
- 哪一方负责维持外部条件；
- 外部条件失效时的已确认结果。

不要只写“the off-chain service must work correctly”。应把 `correctly` 展开为实际职责，例如保持唯一性、使用相同参数、按特定顺序处理、核对状态或提供符合边界的数据。

### 6.5 部署、配置和兼容性边界

说明：

- 支持或假定的链、虚拟机、标准、代币行为、配置或版本；
- 依赖该边界的具体机制；
- 超出边界时哪些行为不再有保证；
- 项目确认的部署或集成范围。

不要把当前范围外的理论不兼容写成当前缺陷，也不要把“项目目前计划这样部署”强化为协议永久保证。对时间、版本和环境保持原有边界。

### 6.6 已接受的行为和非保证

若 Note 解释协议刻意采用的语义，应同时区分：

- 代码现在实际做什么；
- 该行为为什么属于已接受设计或产品语义；
- 使用者可以依赖什么；
- 使用者不能依赖什么；
- 哪些边缘状态需要由外部流程处理。

“代码没有实现 X”只有在 X 本来就不由系统保证且这一边界已确认时，才能作为 Note 的非保证。若 X 应当由系统保证，则这是类型判定问题。

### 6.7 将操作义务写成条件，而不是建议

Note 可以披露运行责任，但不能发出改进请求。优先使用事实性条件表达：

```text
Correct settlement relies on the operator submitting <data> in <order>.
Operation requires the integrator to preserve <property>.
The deployment is compatible only with <environment>.
The contract does not verify <property>; the backend is therefore responsible for <specific duty>.
```

避免：

```text
The project should ensure ...
It is recommended to ...
Consider validating ...
The team must improve ...
```

`must` 仅可表达由协议、规范或逻辑决定的真实必要条件，不得借此偷偷加入 Recommendation。通常 `requires`、`relies on` 或 `is responsible for` 更清楚地区分运行前提与修改请求。

### 6.8 整合项目反馈

项目反馈若影响设计意图、责任分配、部署范围或接受状态，应把其确认内容整合进 Description，例如：

```text
The project confirmed that <accepted design or bounded deployment fact>.
```

必须保持以下限制：

- 不把计划、意图或承诺写成已经部署的事实；
- 不把项目的风险接受写成技术保证；
- 不复制客套、修复状态或与披露无关的回应；
- 不用项目反馈覆盖与仓库证据冲突的事实；发生实质冲突时返回前置分析；
- 除非报告格式明确要求，不在 drafted Note 中新增独立 `Feedback from the project` 字段。

## 7. Guaranteed Behavior 与 Non-guaranteed Behavior

保证边界是 Note 最容易被写错的部分。

### 7.1 Guaranteed Behavior

只有以下证据可以支持保证性陈述：

- 代码对相关路径实施了完整约束；
- 规范或项目文档明确作出保证；
- 项目确认了具有明确范围的行为，且与代码和配置一致；
- 已确认的部署或运营机制能够建立该保证。

不要把当前测试通过、当前配置值或项目“计划保持”某行为写成无条件保证。

### 7.2 Non-guaranteed Behavior

Non-guaranteed Behavior 必须说明保证缺口的准确边界：

```text
The contract does not verify <property> on-chain.
The protocol does not guarantee <behavior> when <boundary>.
<Outcome> depends on <party>; it is not derived from <on-chain state>.
```

“未看到实现”不等于“明确不保证”。必须结合完整执行路径、接口边界、规范或项目确认判断。若缺少实现本身违反预期，应返回 Security Issue，而不是把缺陷包装成 non-guarantee。

### 7.3 不要强行同时写两者

有些 Note 只需说明依赖和责任，有些只需说明部署边界。没有证据时可以省略 Guaranteed Behavior 或 Non-guaranteed Behavior；不能为了模板对称而虚构一个反向陈述。

## 8. Conditional Consequence

Conditional Consequence 的作用是解释该假设为什么值得披露，而不是制造 Impact 段落。

### 8.1 完整结构

每个条件性后果应包含：

```text
<trigger or failed assumption>
    -> <affected object>
    -> <specific consequence>
    -> <necessary boundary, if any>
```

正文通常写为：

```text
If <assumption fails>, <affected object> may <consequence> under <boundary>.
Unless <condition is maintained>, <deterministic consequence> will occur.
```

### 8.2 情态强度

按证据选择：

- `will`：条件满足后结果由代码或协议确定发生；
- `can`：存在已证实的能力或可达路径；
- `may`：结果还依赖未完全固定的现实条件；
- `could`：只在合理但仍有不确定性的情境中使用，并明确必要条件。

不得把 `may` 改成 `will`，也不得为避免严重语气把确定后果弱化为 `might`。确定性来自事实链，不来自 Finding 类型。

### 8.3 保持条件和边界

错误：

```text
This can lead to loss of funds.
```

该句没有说明谁的资产、什么条件、什么路径和适用范围。

正确逻辑：

```text
If <specific trusted action is omitted or abused>, <identified users or assets>
may <specific result> because <system does not guarantee the missing property>.
```

条件必须与前文 Operational Assumption 使用同一概念，不要在后果句中悄悄加入新的攻击能力、市场条件或部署状态。

### 8.4 是否省略后果

若前置分析没有确认具体后果，或后果只是普遍常识，省略比猜测更好。Note 可以只准确披露权限、依赖或运行边界。不要用“may pose significant risks to the protocol”填充空白。

## 9. Responsible Party

责任分配应回答“谁维持哪个条件”，而不是寻找一个可以被命令的对象。

- 代码明确指定角色时，使用该角色名；
- 项目文档或确认指定运营方、后端、治理方或集成方时，使用其正式名称；
- 多方共同维持条件时，分别说明各自职责；
- 责任在边界外且未分配时，只说明依赖，不推断责任人；
- 不把 `owner`、`admin`、`operator` 当作可互换术语；使用项目中的真实角色及 Terminology Brief 定义。

责任句应可验证。例如，`the backend is responsible for generating a unique identifier per operation` 比 `the project must operate securely` 更具体。

## 10. Code locations

Code locations 仅从 `Fact Brief.evidence` 中选择。其作用是证明 Description 中的设计、能力、依赖或保证边界，而不是列出整个调用路径。

规则：

1. 使用 repo-relative 路径和最小、完整行范围；严格写成 `- path:start-end`，不得在 Code locations 中给路径添加反引号；
2. 每个位置必须支撑至少一项已写入的关键主张；
3. 优先选择定义能力、约束或边界的位置；只有理解语义确实需要时才加入调用点；
4. 不把项目反馈、外部规范或用户确认伪装成仓库位置；
5. 不为同一事实列出重复位置；
6. 不因某个组件在正文中被提及，就机械加入其定义位置；
7. 如果没有仓库位置，只有 `Fact Brief` 已明确确认该事实，才使用 `Not applicable — protocol-level finding` 或 `Not applicable — no repository location`；不得虚构位置。

Description 应独立可读；Code locations 是证据索引，不能替代正文解释。

## 11. 语气、确定性与安全语境

Note 仍是安全报告中的正式披露，不是一般项目文档。语气应中性、明确、可证实。

### 11.1 现状用直接陈述

对已确认事实使用：

```text
allows
relies on
requires
accepts
supports
does not enforce
does not guarantee
```

不要使用 `appears to`、`seems`、`probably` 掩盖尚未完成的事实调查。真正不确定的信息应回到前置分析，或以已确认的条件边界表达。

### 11.2 不把风险标签当作分析

避免：

```text
This introduces potential risks.
This is a centralization concern.
This may have security implications.
```

这些句子没有说明具体安全关系。替换为角色、能力、依赖、条件和后果组成的因果链。

### 11.3 不使用 Issue 语气

Note 不使用以下框架描述已接受设计：

- `vulnerability`、`flaw`、`bug`、`defect`；
- `allows an attacker to ...`，除非攻击者能力本身是已确认条件且不会暗示当前缺陷；
- `fails to`、`incorrectly`、`insufficiently`；
- `as a result` 后直接接无条件安全后果；
- 对当前设计作价值判断的 `unsafe`、`insecure`、`dangerous`。

需要描述假设失败时的攻击情境时，先明确受信任边界和失败条件，再陈述后果。不要让攻击者句成为没有上下文的主句。

### 11.4 不使用 Recommendation 语气

不得使用：

```text
should
recommend
consider
preferably
best practice
for maintainability
for clarity
```

唯一例外是引用规范中的规范性 `SHOULD`，且 Terminology Brief 或 Fact Brief 已确认其准确含义；即便如此，也应优先解释该规范要求与当前边界，而不是对项目发出建议。

## 12. 英文表达方法

### 12.1 一句一个主命题

每个句子承载一个主要事实和最多一个紧密相关的从属关系。长条件链拆分为上下文句、假设句和后果句。不要为追求简短而删除主语、条件或受影响对象。

### 12.2 主动语态和明确主语

优先写：

```text
The operator supplies <data>.
The contract verifies <property>.
The integration relies on <dependency>.
```

避免：

```text
It must be ensured that ...
It is expected that ...
Validation should be performed ...
```

被动语态只在执行者未知、不重要，或结果本身比执行者更重要时使用。

### 12.3 具体动词替代抽象名词

优先写：

```text
The role can pause withdrawals.
The backend reconciles deposits and withdrawals.
The contract does not validate the sequence.
```

避免：

```text
The role has control capabilities.
The backend performs management.
There is a validation dependency.
```

### 12.4 连接词必须忠实表达关系

- `because`：原因；
- `therefore` / `consequently`：已建立的结果；
- `however`：真正的对比；
- `if` / `unless`：条件；
- `while`：并行事实或有限对比，避免承载模糊逻辑；
- `in addition`：补充独立事实，不用来掩盖因果跳跃。

不要在没有因果证明时使用 `as a result`，也不要用 `however` 连接实际并不矛盾的句子。

### 12.5 指代、标识符和格式

- 首次出现时写清组件、角色或机制；之后的代词必须只有一个明确先行词；
- 合约、函数、变量、角色、配置键等标识符使用报告约定的代码格式；
- 函数名保留 `()`；
- 不用第二人称 `you`；使用 `users`、`integrators`、`operators` 等准确主体；
- 使用标准、正式、精确的英语，避免口语、夸张、修辞问题和宣传措辞；
- 保持标点、路径、代码位置和输出格式与本文件前述规则一致。

这些规则与 Google Technical Writing 对主动语态、短句、明确主语和因果表达的要求，以及 Microsoft Writing Style Guide 对简洁、具体、可操作技术表达的要求一致。安全上下文的建模遵循 OWASP Threat Modeling Cheat Sheet 对系统、依赖、信任边界、责任和失败场景的区分。

## 13. 历史语料中的常见反例

### 13.1 用泛化标题替代具体主题

```text
Potential centralization risk
Potential security risks
Proper off-chain validation
```

问题：第一、二类没有标识具体权限或依赖；第三类通过 `Proper` 暗示应当改进。改写时回到 Subject 和 disclosed relationship。

### 13.2 把运行前提写成项目建议

```text
The project should ensure that the backend behaves correctly.
```

问题：`should ensure` 是 Recommendation 语气，`correctly` 也没有定义可验证条件。应写出系统依赖的具体后端职责，并仅在已有责任分配时指出负责方。

### 13.3 只有能力列表，没有信任逻辑

```text
The owner can call A, B, C, D, and E. This creates centralization risks.
```

问题：函数清单没有解释关键能力、作用范围、依赖的信任属性和条件性后果。应按语义归纳能力，而不是机械枚举调用入口。

### 13.4 只有严重后果，没有失败条件

```text
This may lead to asset loss and protocol failure.
```

问题：无法判断后果是否来自当前缺陷、受信任方失效、错误配置或范围外集成。必须绑定 Operational Assumption、受影响对象和边界；否则省略。

### 13.5 把代码沉默写成系统保证

```text
The system expects all tokens to behave normally.
```

问题：`normally` 没有定义，代码未处理某种行为也不能证明系统作出该期望。应使用已确认的兼容性边界和准确术语。

### 13.6 把项目确认强化成永久事实

```text
The protocol will only ever be deployed on <environment>.
```

问题：项目当前计划或当前范围不一定是永久保证。保留 `currently`、版本、审计范围和部署计划的原始确定性。

### 13.7 为了“完整”增加修复方案

```text
Operators should use a multisig and add monitoring.
```

问题：这是独立 Recommendation，而且可能没有出现在 Fact Brief。Note 只披露现有信任关系和运行条件；若报告目的包括改进，应重新分类。

### 13.8 把不同假设压成一个风险标签

```text
The system has multiple trusted components and therefore has operational risk.
```

问题：不同组件可能具有不同责任、失败条件和后果。应拆分，或在确有同一核心假设时建立一个共同的 Design / Trust Context。

## 14. 精简原则

完整不等于冗长。删除以下内容不会损失事实链：

- 重复标题的开场句；
- 逐行复述代码；
- 与假设无关的调用细节；
- 无法落到具体后果的风险形容词；
- 与设计意图或边界无关的项目反馈；
- 在 Description 中重复 Code locations；
- 对专业读者无帮助的一般安全常识；
- 同一条件或责任的多次改写。

不得删除：

- 区分 Note 与 Security Issue 所需的接受上下文；
- 运行假设的具体内容；
- 责任分配；
- 保证与非保证的边界；
- 条件性后果的触发条件；
- 限制后果成立范围的事实；
- 使 Description 可独立理解的对象关系。

长度由逻辑链决定，不设低于共享上限的固定句数。一条简单部署条件可以很短；一个跨链、链下或多角色信任模型可能需要多个段落，但 Description 不得超过六个英文句子。

## 15. 输出格式

只输出以下字段，且严格保持顺序：

```text
**Title:** <neutral design, trust, dependency, or operational-condition noun phrase>

**Description:**

<self-contained disclosure>

**Code locations:**

- <repo-relative path:start-end>
```

没有仓库位置时，协议级 Note 的 Code locations 严格写为 `Not applicable — protocol-level finding`；非协议级、仅由审计人员确认、权威外部来源或纯运行条件支持的 Note 严格写为 `Not applicable — no repository location`。

不要输出：

- Severity；
- Impact；
- Suggestion；
- Status；
- Introduced by；
- Root Cause；
- Remediation Goal；
- 独立的 Project Feedback；
- 分类过程、备选标题、推理、检查表或写作说明。

如果上层报告模板负责 `Status`、`Introduced by` 或反馈段落，由上层模板填充；Note drafter 不推断这些元数据。

## 16. 最终检查

输出前逐项检查：

### 16.1 类型

- [ ] 文本披露的是已接受的设计、信任关系、权限、依赖、部署边界或运行条件；
- [ ] 在全部已声明假设成立时，不存在由当前实现偏差直接造成的已确认安全后果；
- [ ] 文本没有请求改变当前行为；
- [ ] 严重后果只作为条件性后果出现，不改变 Note 的因果归属；
- [ ] 历史报告的标签没有被当作分类权威。

### 16.2 逻辑

- [ ] Design / Trust Context 明确；
- [ ] Operational Assumption 具体且可判定；
- [ ] Responsible Party 只在有依据时出现；
- [ ] Guaranteed Behavior 与 Non-guaranteed Behavior 均有独立证据；
- [ ] Conditional Consequence 具有明确条件、受影响对象、具体结果和必要边界；
- [ ] Description 中不存在从代码沉默、一般常识或分类标签推导出的事实；
- [ ] 项目立场保持原有时态、范围和确定性。

### 16.3 Title

- [ ] 是中性名词短语；
- [ ] 同时标识具体 Subject 和被披露的关系或条件；
- [ ] 不使用命令式、缺陷式、泛化风险或后果式标题；
- [ ] 不用 `Proper`、`Ensure`、`Potential risk` 等措辞掩盖类型；
- [ ] 与 Description 的核心上下文完全一致。

### 16.4 Description

- [ ] 不读代码也能理解当前设计、假设、责任、边界和条件性后果；
- [ ] 先建立已接受上下文，再说明假设失败后的后果；
- [ ] 操作义务被写成运行条件，而不是 Suggestion；
- [ ] 权限被归纳为具体能力，而不是函数清单；
- [ ] 外部依赖被展开为可验证职责，而不是“正确运行”；
- [ ] 没有空泛的 `centralization risk`、`security implications` 或 `significant risks`；
- [ ] 没有 Severity、独立 Impact 或修复方案。

### 16.5 术语与证据

- [ ] 每个专业术语都来自 Terminology Brief，并保持其定义和适用边界；
- [ ] 没有准确术语时使用清楚的普通技术语言；
- [ ] 标识符、角色和责任方名称与项目一致；
- [ ] 每个 Code location 都最小、准确，并支撑正文关键主张；
- [ ] 外部事实、项目确认和仓库证据没有混为一类。

### 16.6 英文与格式

- [ ] 每句只有一个主命题和必要的从属关系；
- [ ] 主语明确，主动语态优先；
- [ ] 条件、因果、对比和补充连接词使用准确；
- [ ] 情态动词与证据确定性一致；
- [ ] 无口语、夸张、模糊代词、修辞问题或无意义开场；
- [ ] 输出字段、顺序、标点、代码格式和路径格式符合本文件的规则。

只有全部适用项通过后，才输出最终 Note。

## 17. 外部写作与安全建模依据

- [Google Technical Writing — Active voice](https://developers.google.com/tech-writing/one/active-voice)
- [Google Technical Writing — Clear sentences](https://developers.google.com/tech-writing/one/clear-sentences)
- [Google Technical Writing — Short sentences](https://developers.google.com/tech-writing/one/short-sentences)
- [Microsoft Writing Style Guide — Writing tips](https://learn.microsoft.com/en-us/style-guide/global-communications/writing-tips)
- [OWASP Threat Modeling Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Threat_Modeling_Cheat_Sheet.html)
- [OWASP Threat Modeling Process](https://owasp.org/www-community/Threat_Modeling_Process)
