# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Personal Neovim config built on the [LazyVim](https://www.lazyvim.org/) starter, managed by lazy.nvim. There is no build or test suite; changes are validated by starting Neovim cleanly.

## Commands

- Format Lua: `stylua lua/ init.lua` (config in `stylua.toml`: 2 spaces, 120 cols)
- Check formatting: `stylua --check lua/ init.lua`
- Headless startup smoke test (prints active colorscheme and count of error messages):

  ```sh
  nvim --headless "+lua vim.defer_fn(function() io.write('colors=' .. tostring(vim.g.colors_name) .. ' errs=' .. #vim.tbl_filter(function(m) return m:find('Error') end, vim.split(vim.fn.execute('messages'), '\n')) .. '\n') vim.cmd('qa!') end, 3000)"
  ```

- Sync plugins to the lockfile: `nvim --headless "+Lazy! restore" +qa`
- Update plugins (rewrites `lazy-lock.json`): `nvim --headless "+Lazy! sync" +qa`
- macOS has no `timeout` binary; bound long runs with the tool timeout instead.

## Architecture

1. `init.lua` → `lua/config/lazy.lua` bootstraps lazy.nvim and loads `LazyVim/LazyVim` plugins, then every file in `lua/plugins/`.
2. `lua/config/{options,keymaps,autocmds}.lua` are loaded by LazyVim itself; they extend LazyVim's defaults (options before plugin startup, keymaps/autocmds on `VeryLazy`).
3. LazyVim extras (language support, formatters, linters, DAP, tests) are enabled in `lazyvim.json`, which is version-controlled. Enable an extra there (or via `:LazyExtras`) rather than hand-configuring its plugins.
4. Files in `lua/plugins/` return lazy.nvim specs that merge into LazyVim's specs by plugin name. Use `opts` (table or `function(_, opts)`) to extend; replace `config` only when required.
5. `defaults.lazy = false`: custom plugins load at startup unless the spec sets `lazy = true`.
6. `lazy-lock.json` pins plugin commits; lockfile bumps are committed separately as `chore: update plugin lockfile`.

## Three layers of behavior

When answering "how do I / does my config support" questions, identify which layer a keymap or feature comes from and read the files before answering:

1. Neovim built-ins
2. LazyVim defaults and active extras ([keymaps](https://www.lazyvim.org/keymaps), `lazyvim.json`)
3. Overrides in `lua/config/` and `lua/plugins/`

## Constraints and non-obvious behavior

- **Colorschemes:** kanagawa (`dragon` dark / `lotus` light) is the only `lazy = false` theme and is set via the LazyVim spec in `lua/plugins/kanagawa.lua`. catppuccin and tokyonight are backups and must stay `lazy = true`; a second eager `priority = 1000` theme changes startup load order and can apply over the default.
- **Kanagawa compile:** `compile = true` caches highlights. Run `:KanagawaCompile` after editing `kanagawa.lua` or changes will not appear.
- **Theme overrides stay palette-derived:** kanagawa overrides and `lua/plugins/bufferline.lua` read `require("kanagawa.colors").setup().theme` instead of hex values so they work across variants. `bufferline.lua` branches on `vim.g.colors_name` per theme.
- **Override specs for extra-provided plugins** should set `optional = true` (see `bufferline.lua`); without it, the spec installs the plugin even when its extra is disabled.
- **Macros:** bare `q` only stops a recording; `<leader>Q` starts recording into register `q` (`lua/config/keymaps.lua`). Stopping stays on bare `q` because which-key's leader capture is unreliable while recording.
- **Surround:** mini.surround is remapped to the `gz` prefix (`gza`, `gzd`, `gzr`, …).
- **Prettier** runs only when the project has a Prettier config (`vim.g.lazyvim_prettier_needs_config`).
- **Python:** LSP is `basedpyright`; conform runs `ruff_fix` → `ruff_organize_imports` → `ruff_format`.
- **Tests:** `test.core` ships no adapters; JS/TS uses `neotest-vitest` registered in `lua/plugins/neotest-vitest.lua`.
- **Markdown lint/format:** nvim-lint and conform pass `--config` pointing at `.markdownlint-cli2.jsonc` in this repo, so rule changes there apply to all markdown edited in Neovim, not just files in this repo.
