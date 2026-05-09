# Skill Triggers

Before acting on any coding task, match intent against this table.
If a skill matches, read its SKILL.md and follow it. Announce in one line.

| Signal | Skill |
|---|---|
| New feature, behavior change, API/data change, requirements, 需求, 要不要 | grill |
| Plan, sequence, break down, multi-step, 怎么拆, 实现步骤 | plan |
| Bug, error, 报错, 异常, 失败, 没看到, 没显示, 空响应 | diagnose |
| Write code, implement, fix after diagnosis, 开始写 | tdd |
| Done, commit, push, PR, merge, 提交, 完成 | finish |
| Review feedback, reviewer says, 审查意见, requested changes | review |
| Coupling, structure, boundaries, 太乱了, 重构架构 | architecture |
| Try it, prototype, spike, PoC, 快速验证, 试一下 | prototype |
| Subagents, parallel agents, delegation, 并行 | subagents |
| 简洁点, caveman, terse, fewer tokens | caveman |

No match → proceed normally, no skill needed.
