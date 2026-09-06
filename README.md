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

This pulls the repository when an upstream is configured, updates every skill submodule, merges `DarkNavySecurity/web3-skills` into the customized `sasiyaluba/web3-skills` fork, refreshes the three vendored Web3 skills, and updates the agent links. A merge conflict stops the update without replacing the installed skills.
