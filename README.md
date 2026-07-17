# Product Vault — starter kit

A ready-made setup for running your product work (specs, research, roadmap
reviews, strategy) with **Claude Code** helping you, and everything saved as
organized notes in **Obsidian**. The main thing you produce is usually a
**product spec**, which you then copy into Notion.

You don't need to have used Obsidian, a terminal, or any developer tools before.
Follow the steps below in order.

---

## The two apps you'll install

- **Obsidian** — a free note-taking app. It opens a *folder of notes* (called a
  "vault") and lets you link and search them. This starter kit **is** that
  folder.
- **Claude Code** — Anthropic's AI assistant that runs in the **Terminal** (the
  Mac app where you type commands). It reads the instructions in this kit and
  files your work into the right place automatically.

> **Terminal?** It's a built-in Mac app. Open it by pressing `Cmd + Space`,
> typing `Terminal`, and pressing `Enter`. You'll paste commands into it and
> press `Enter` to run them. Commands below are shown in `monospace`.

---

## One-time setup

### Step 1 — Put this folder in the right place

This kit should live at `~/Documents/product-vault` (`~` means your home
folder). However you received it (a download or a shared folder), move it there
and name the folder `product-vault`.

If it's sitting in your Downloads as `product-vault-template`, this command moves
and renames it:

```bash
mv ~/Downloads/product-vault-template ~/Documents/product-vault
```

### Step 2 — Install Obsidian and open the vault

1. Download and install Obsidian (free): **https://obsidian.md**
2. Open Obsidian. On the welcome screen choose **"Open folder as vault"**.
3. Navigate into `~/Documents/product-vault` and select the **`agents`** folder
   inside it (not the top `product-vault` folder — the vault is the `agents`
   subfolder). Click **Open**.
4. If Obsidian asks whether to trust the folder / enable it, say yes.

You'll now see the notes and templates in Obsidian's left sidebar.

### Step 3 — Install Claude Code

Follow the official guide to install it and sign in with your Claude account:
**https://docs.claude.com/en/docs/claude-code**

To check it worked, open Terminal and run:

```bash
claude --version
```

If you see a version number, you're set.

### Step 4 — Tell Claude to always file work into the vault

This is the step that makes Claude treat the vault as your home for product
work in **every** session. You'll copy one instructions file into place.

`~/.claude/CLAUDE.md` is a file Claude Code reads at the start of every session,
no matter which folder you're in. This kit includes a ready-made one.

Run these two commands in Terminal:

```bash
mkdir -p ~/.claude
cp ~/Documents/product-vault/setup/global-CLAUDE.md ~/.claude/CLAUDE.md
```

> **Already have a `~/.claude/CLAUDE.md`?** Don't overwrite it. Instead open
> `~/Documents/product-vault/setup/global-CLAUDE.md`, copy its contents, and
> paste them at the bottom of your existing `~/.claude/CLAUDE.md`.

That's it. Setup is done.

---

## Everyday use

**Start a working session:**

```bash
cd ~/Documents/product-vault
claude
```

Then just tell Claude what you're working on. Because of Step 4, it will read
the vault's guide, put your work in the right **project** (a folder under
`agents/projects/`), and save the important notes there — the decisions,
findings, and the spec — not a copy of your chat.

**Start a project yourself** (optional — Claude can do this for you):

```bash
# A spec (the default)
bash agents/scripts/new-project.sh manual-accreditation --type spec

# Other kinds of work
bash agents/scripts/new-project.sh cross-border-fees --type research
bash agents/scripts/new-project.sh onboarding-july   --type roadmap-review
bash agents/scripts/new-project.sh onboarding-q3     --type strategy
```

**Capture a meeting note:**

```bash
bash agents/scripts/new-meeting.sh kickoff-call --project 2026-07-manual-accreditation
```

**When a spec is ready**, copy it into Notion (the team's shared home for specs)
and paste the Notion link back into the note's `notion_url` field.

---

## How it's organized

Each piece of work is a **project** folder under `agents/projects/` that holds
research, meeting notes, decisions, and the deliverable (usually a spec). The
templates in `agents/templates/` mirror the team's Notion formats.

The full guide — project types, folder structure, note conventions, and diagrams
— is in **`agents/AGENTS.md`**. Claude reads it automatically; you can read it
too, right inside Obsidian.

---

## Ground rules

- **Notes only.** Never put code, passwords, `.env` files, or API tokens in the
  vault. Code repositories live in their own place on your computer and are only
  *referenced* from a project note.
- **Specs live in Notion too.** The vault is where you draft and think; Notion is
  the shared source of truth.
- **Back it up (optional).** Obsidian offers a paid **Sync** service to back up
  and sync your vault across devices (Settings → Sync).
