# Product Vault: ~/Documents/product-vault

## What this folder is

This is your **product work** home. It is an Obsidian vault for running
**projects** — spec planning, research, monthly roadmap reviews, and quarterly
strategy — where the real deliverable is usually a **product spec** that gets
mirrored into Notion (the team's home for specs).

This is **notes only**. Code repos live **outside this vault directory**, in
whatever location you keep them — they are *referenced* from a project, never
cloned inside `~/Documents/product-vault`. See
[Working with repos](#working-with-repos).

## Layout

| Path | Purpose |
|---|---|
| `~/Documents/product-vault/agents/` | The Obsidian vault — open this folder in Obsidian. See [`agents/AGENTS.md`](agents/AGENTS.md). |
| `~/Documents/product-vault/agents/projects/` | One folder per project. |

## How we work

Most product work is a **project**. Scaffold one by type:

```bash
bash ~/Documents/product-vault/agents/scripts/new-project.sh <slug> --type spec \
  [--tickets FIN-1,FIN-2] [--linear https://linear.app/...] [--notion https://notion.so/...]
```

| `--type` | For | Deliverable |
|---|---|---|
| `spec` (default) | Spec planning tied to a feature / Linear project | a product spec → mirrored to Notion |
| `research` | General topic research, usually **not** in Linear | a research writeup |
| `roadmap-review` | Monthly roadmap review meeting | rolling review doc referencing the month's projects |
| `strategy` | Quarterly strategic planning meeting | a team strategy doc |

Meeting notes feed projects — scaffold one with:

```bash
bash ~/Documents/product-vault/agents/scripts/new-meeting.sh <slug> --project YYYY-MM-<slug>
```

Full guide (folder structure, frontmatter, templates, linking, Mermaid,
lifecycle): [`agents/AGENTS.md`](agents/AGENTS.md).

## Working with repos

Product work occasionally touches code — prototypes in branches of the
**dashboard** repo, or reading other repos / BigQuery for research. Keep that
code **outside** the vault and reference it from the project instead:

- Prototypes → work in the repo's own clone wherever it lives on your machine
  (outside this vault), and record the branch/PR in `project.md` (`repos:`,
  `prototype_branch:`).
- Repo / BigQuery research → capture the queries, findings, and links in a
  `research/` note; the code and data stay in their own systems.

## Conventions

- **Notes only** — never clone repos, and never put credentials, `.env` files,
  or tokens in the vault. It may be synced via Obsidian Sync.
- **Specs live in Notion too** — the vault is where you draft and think; Notion
  is the shared source of truth. Paste the Notion URL back into `notion_url`.
- **Vault internals** — do not commit or modify `agents/.obsidian/`; it is
  managed by Obsidian.
