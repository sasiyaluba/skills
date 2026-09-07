# Terminology Discovery

基于用户输入、`Fact Brief` 和已有的可选 `Impact Brief`，全面搜索能够准确描述当前 Finding 的专业术语。

由 `finding-polisher` 调用时，原 Finding 和 `Content Lock` 分别替代用户 raw finding 与 Brief 输入。此时只研究 `Content Lock` 已有概念的表达，不得增加、删除或改变事实、条件、因果、Impact、修复目标或 Code locations；下文对 `Fact Brief`、`Impact Brief` 和“已确认内容”的引用均按此替代关系解释。

搜索应覆盖：

- 项目及依赖的官方文档；
- 控制性标准和正式规范；
- 权威安全分类和漏洞知识库；
- 相关协议、语言或技术栈的安全指南；
- 原始研究论文、技术报告和正式安全公告；
- 同类机制的权威实现或设计文档。

至少实际阅读 **20 个不同来源**。同一文档、规范或网站页面集合的不同章节只计为一个来源。搜索结果摘要、转载内容和未实际阅读的链接不计入来源数量。

搜索应尽可能全面，不因找到第一个可用术语而停止。继续比较不同来源中的定义、使用场景和语义边界，直到能够判断哪些术语与当前 Finding 最相关。

重点寻找描述以下内容的术语：

- 项目或协议机制；
- 产生当前行为的技术原因；
- 被破坏、削弱或依赖的安全属性；
- 当前行为对应的缺陷或失败模式；
- 已确认的 Impact。

每个采用的术语必须：

- 具有明确且可追溯的来源；
- 在来源中的含义与当前 Finding 一致；
- 比普通或泛化表达更准确；
- 说明它与当前 Finding 的具体关系；
- 说明适用场景和语义边界。

不要仅因为某个词听起来专业或与安全相关就采用它。无法找到准确专业术语时，使用清楚的普通技术语言，不创造新术语。

输出 YAML：

```yaml
terminology_brief:
  sources_reviewed:
    - id: S1
      source: <来源名称和 URL 或项目位置>
      type: standard | official_documentation | security_taxonomy | research | advisory | project_documentation
      reviewed_for: >-
        <检索该来源时重点确认的概念>
      result: >-
        <找到的相关术语，或未找到准确术语>

    # 至少列出 S1 至 S20

  terms:
    - term: <专业术语>
      category: domain | mechanism | security_property | failure_mode | impact
      definition: >-
        <该术语在权威来源中的准确含义>
      relevance: >-
        <该术语与当前 Finding 的事实或 Impact 之间的具体关系>
      usage: >-
        <该术语适合表达的内容及使用边界>
      supported_by:
        - S3
        - S11
```

只有在至少审阅 20 个不同来源，并对相关候选术语完成含义和适用性比较后，才能输出 `Terminology Brief`。
