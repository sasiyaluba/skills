# skills

A personal collection of agent skills managed with Git submodules.

## Install

```sh
git clone --recurse-submodules https://github.com/sasiyaluba/skills.git
cd skills
./install.sh
```

`install.sh` discovers every `SKILL.md` in this repository and links the skills into each installed agent it recognizes: Codex, Claude Code, OMP, and Pi.

## Update

```sh
./update.sh
```

This pulls the repository when an upstream is configured, updates every skill submodule from its remote default branch, and refreshes the agent links.
