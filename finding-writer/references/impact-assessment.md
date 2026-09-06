# Impact Assessment

基于用户输入和 `Fact Brief`，分别完成 Impact 分析和等级确认。

## Impact

确定该 Finding 最严重且现实的一个后果。

Impact 应说明受影响的对象、具体后果，以及决定该后果能否成立的必要条件和边界。选择有事实支持的最严重后果，不使用理论上可能但缺乏现实路径的最大后果。

- 用户未明确 Impact 时，提出一个 Impact 并请求用户确认。
- 用户已经明确 Impact，且 Fact Brief 支持该判断时，直接采用，无需再次确认。
- 用户给出的 Impact 与 Fact Brief 存在实质冲突，或者事实支持不同的最严重后果时，说明分歧和依据，请求用户确认最终 Impact。
- Impact 未确认前，不输出最终 `Impact Brief`。

一次只讨论一个最严重的 Impact。

## Severity

基于已经确认的 Impact、成立条件和影响边界确定等级。

- 用户已经给出等级时，直接采用该等级，不再次确认。
- 对用户给出的等级存在不同判断时，在 `severity_note` 中说明理由，但不因此询问用户。
- 用户未给出等级时，提出一个建议等级及理由，请求用户确认。
- 用户确认后采用其最终决定。

## 输出格式

```yaml
impact_brief:
  impact:
    description: >-
      <已经确认的最严重且现实的一个后果>
    based_on:
      - <Fact Brief 中支持该 Impact 的具体事实>
    source: user_specified | user_confirmed

  severity:
    level: <用户给出或确认的等级>
    rationale: >-
      <该等级与 Impact、成立条件和影响边界之间的关系>
    source: user_specified | user_confirmed
    severity_note: >-
      <可选；对用户给出的等级存在不同判断时，说明理由>
```
