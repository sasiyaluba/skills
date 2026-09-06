# skills

A personal collection of agent skills managed with Git submodules and vendored sources.

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

This pulls the repository when an upstream is configured, updates every skill submodule from its remote default branch, refreshes the vendored Web3 skills from `DarkNavySecurity/web3-skills`, and updates the agent links.
