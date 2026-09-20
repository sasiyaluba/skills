# Tao Skills

A focused AI workflow for **Codex**, **Claude Code**, **Oh My Pi**, and **Pi**.

## Workflows

| Workflow | Source | Purpose |
| --- | --- | --- |
| Development | [`mattpocock-skills`](./mattpocock-skills/) | Engineering workflows for planning, implementation, debugging, testing, review, and design. |
| Audit | [`code-audit`](./code-audit/) | Risk-oriented security audit orchestration. |
| Finding output | [`finding-writer`](./finding-writer/) | Write audit-report Issues, Recommendations, and Notes. |
| Attention control | [`attention-control`](./attention-control/skills/attention-control/) | ADHD-friendly output control, enabled only by explicit invocation. |
| Socratic teaching | [`socrates`](./socrates/) | Question-led teaching, enabled only by explicit invocation. |

These five workflow sources are installed. `mattpocock-skills` contains multiple individual skills; the other sources each provide one skill.

## Install

### 1. Clone

```sh
git clone --recurse-submodules git@github.com:sasiyaluba/skills.git tao-skills
cd tao-skills
```

HTTPS also works:

```sh
git clone --recurse-submodules https://github.com/sasiyaluba/skills.git tao-skills
cd tao-skills
```

### 2. Run the installer

```sh
./install.sh
```

The installer:

1. Initializes and updates the `code-audit`, `attention-control`, and `mattpocock-skills` submodules.
2. Discovers skills only from the five workflow sources listed above.
3. Rejects duplicate skill names.
4. Detects supported agents from their executable or configuration directory.
5. Links the selected skills into each detected agent.
6. Links this repository's [`AGENTS.md`](./AGENTS.md) as the agent's user-level instructions.
7. Archives conflicting instruction files and non-symlink skill directories under `~/.local/share/sasiyaluba-skills-backups/`.

### Installed locations

| Agent | Skills | Shared instructions |
| --- | --- | --- |
| Codex | `~/.codex/skills/` | `~/.codex/AGENTS.md` |
| Claude Code | `~/.claude/skills/` | `~/.claude/CLAUDE.md` |
| OMP | `~/.omp/agent/skills/` | `~/.omp/agent/AGENTS.md` |
| Pi | `~/.pi/agent/skills/` | `~/.pi/agent/AGENTS.md` |

Claude Code receives the shared instructions through `CLAUDE.md`, the filename it loads natively.

If the submodules are already synchronized and only the links need refreshing:

```sh
TAO_SKILLS_SKIP_SUBMODULE_UPDATE=1 ./install.sh
```

## Update

```sh
git pull --recurse-submodules
./install.sh
```

## Sources

- [`QLYZWD/code-audit`](https://github.com/QLYZWD/code-audit): security audit orchestration.
- [`mattpocock/skills`](https://github.com/mattpocock/skills): engineering workflows.
- [`aaddrick/attention-control`](https://github.com/aaddrick/attention-control): ADHD-friendly output control, enabled only by explicit invocation.
- Local skill: `finding-writer`.
- Adapted local skill: `socrates`, sourced from [`bevibing/socrates-skill`](https://github.com/bevibing/socrates-skill).
