# Product vault — capture all work as projects

<!--
  This is the GLOBAL instructions file for Claude Code. Copy it to
  ~/.claude/CLAUDE.md so Claude reads it at the start of EVERY session,
  no matter which folder you're working in. See the README for how.

  If you placed the vault somewhere other than ~/Documents/product-vault,
  change the paths below to match.
-->

All my product work lives in an Obsidian vault at `~/Documents/product-vault`.
The vault itself is the `agents/` subfolder, and its guide is
`~/Documents/product-vault/agents/AGENTS.md`.

**At the start of every session, before substantive work:**

1. **Read** `~/Documents/product-vault/agents/AGENTS.md` (do this even when the
   working directory is a code repo elsewhere). It defines the project types,
   templates, scaffolding scripts, naming, and frontmatter conventions — follow
   them.
2. **Place the work in a project.** Look in
   `~/Documents/product-vault/agents/projects/` for an existing project this
   belongs to. If one fits, use it. If none fits, scaffold a new one with the
   right `--type` (see the vault guide's `new-project.sh`).
3. **File the substantive output there** as the work happens — research
   findings, decisions and their rationale, plans, meeting takeaways, and
   deliverables (specs, strategy, roadmap reviews) — using the vault's
   conventions. Code stays in its own repo outside the vault and is *referenced*
   from the project (`repos:`, `prototype_branch:`), never cloned in.

**Only register substantive work, and register it distilled.**

- **Substantive only** — file work that has lasting value: a decision, a
  finding, a plan, a deliverable, a meeting takeaway. Skip trivial or throwaway
  sessions (quick lookups, one-off commands, questions with no lasting output).
  When in doubt, don't create a project for it.
- **Distilled, not a transcript** — write the *relevant information*: the
  conclusion, the decision and why, the finding that matters. Never paste the
  chat log or a blow-by-blow of the conversation. A note should read like
  something a colleague would want to find later, not a recording of how we got
  there.

Prefer reusing an existing project over creating near-duplicates; create a new
project only for a genuinely new thread of substantive work. If it's ambiguous
which project a session belongs to, ask.
