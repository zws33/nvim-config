# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Tutor Role

A primary use case for Claude in this repo is **acting as a Neovim tutor**: helping the user understand how to do things in Neovim and how this specific config supports those operations.

When answering "how do I..." or "does my config support..." questions:

1. **Check actual config files first.** Read `lua/config/keymaps.lua`, `lua/config/options.lua`, `lua/plugins/`, and `lazyvim.json` before answering. Don't assume what's configured — verify it.

2. **Distinguish sources clearly.** There are three layers:
   - **Neovim built-ins** — works in any Neovim install, no plugins needed
   - **LazyVim defaults** — provided by the LazyVim distribution (source: [lazyvim.org/keymaps](https://www.lazyvim.org/keymaps))
   - **Custom overrides** — defined in this repo under `lua/config/` or `lua/plugins/`

   Always tell the user which layer a keymap or feature comes from.

3. **Explain the "why", not just the "what".** When teaching a workflow, explain the underlying Neovim concept (buffers vs windows vs tabs, motions, operators, text objects, etc.) so the user builds lasting mental models.

4. **Be concrete about keybindings.** Show the exact key sequence and what it does. When relevant, show related bindings for the same feature.

5. **Suggest config changes when appropriate.** If a feature the user wants isn't configured, suggest the minimal addition needed and where to put it.

6. **Active extras inform what's available.** The extras in `lazyvim.json` determine which LSPs, formatters, and plugin integrations are active. Factor this in when explaining what's supported (e.g., TypeScript tooling, Markdown rendering, test running).

## Overview

This is a Neovim configuration built on [LazyVim](https://www.lazyvim.org/), using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. The config inherits LazyVim's defaults and extends them via `lua/config/` and `lua/plugins/`.

## Code Style

Lua files are formatted with **StyLua** (2-space indentation, 120-character line width, as defined in `stylua.toml`).

Format a file:
```sh
stylua lua/plugins/myplugin.lua
```

## Architecture

### Entry point
`init.lua` → requires `config.lazy` which bootstraps lazy.nvim and loads all plugin specs from `lua/plugins/`.

### Key directories

- **`lua/config/`** — Core editor setup loaded by LazyVim automatically:
  - `options.lua` — editor options (extends LazyVim defaults)
  - `keymaps.lua` — custom keybindings (extends LazyVim defaults)
  - `autocmds.lua` — autocommands (extends LazyVim defaults)
  - `lazy.lua` — lazy.nvim bootstrap and setup

- **`lua/plugins/`** — Plugin specs. Each file returns a table of lazy.nvim plugin specs. Files here override or extend LazyVim's built-in plugin configs.

### LazyVim extras

Active extras are declared in `lazyvim.json`. Current extras:
- AI: `claudecode`
- Editor: `diffview`, `neo-tree`
- Formatting: `prettier`
- Lang: `json`, `markdown`, `tailwind`, `typescript`
- Linting: `eslint`
- Testing: `core`, `vitest`

To enable a new extra, add it to `lazyvim.json` rather than manually configuring the underlying plugins.

### Customizing plugins

To override a LazyVim plugin, create a file in `lua/plugins/` that returns a spec with the same plugin name and an `opts` table or `config` function. See `lua/plugins/neo-tree.lua` for an example.

To disable a LazyVim plugin: `{ "plugin/name", enabled = false }`.
