# Tao Skills

A focused AI workflow for **Codex**, **Claude Code**, **Oh My Pi**, and **Pi**.

## Workflows

| Workflow | Source | Purpose |
| --- | --- | --- |
| Ask AI | [`answer-me`](./answer-me/) | Baseline response contract: complete first, then concise. |
| Development | [`mattpocock-skills`](./mattpocock-skills/) | Engineering workflows for planning, implementation, debugging, testing, review, and design. |
| Audit | [`code-audit`](./code-audit/) | Risk-oriented security audit orchestration. |
| Finding output | [`finding-writer`](./finding-writer/) | Write audit-report Issues, Recommendations, and Notes. |

Only these four workflow sources are installed. `mattpocock-skills` contains multiple individual skills; the other three sources each provide one skill.

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

1. Initializes and updates the `code-audit` and `mattpocock-skills` submodules.
2. Discovers skills only from the four workflow sources listed above.
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
- Local skills: `answer-me` and `finding-writer`.
