# Finding Grounding

充分探索用户提供的 Finding 及相关项目，确认并解释其中的事实。

以此为完成标准：**一个从未阅读过该项目代码的人，仅阅读输出内容，就能准确、完整地理解这个 Finding。**

不要预设调查范围或限制应当发现什么。保留理解 Finding 所需的全部背景、条件、执行过程、对象关系、直接结果和边界。

优先自行检查代码、配置、文档、测试和依赖。只有无法自行确认且会影响事实理解的信息，才询问用户。

除非审计人员明确指出某个 audited in-scope instance 已经部署，否则将当前审计范围内的合约视为尚未部署。历史部署、旧版本或依赖合约的部署状态不能改变这一默认值。区分 in-scope contract 与 dependency contract，并在部署状态会影响事实、Impact 或 remediation 时，把对应依据和边界写入 `Fact Brief`。

每项事实必须有明确证据。不得将推测写成事实。

输出 YAML：

```yaml
fact_brief:
  facts: |-
    <对 Finding 事实的完整、详尽且可独立理解的描述>

  evidence:
    - source: <repo-relative path:start-end、用户确认或权威来源>
      supports: >-
        <该证据支持的具体事实>
```
