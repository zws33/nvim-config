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

- **Colorschemes:** catppuccin (`mocha` dark / `latte` light) is the only configured theme, set via the LazyVim spec in `lua/plugins/catppuccin.lua`. It stays `lazy = true`: LazyVim applies the startup colorscheme itself, and lazy.nvim loads the owning plugin on demand. LazyVim still installs tokyonight as one of its own defaults — it is unconfigured, not a backup.
- **Catppuccin must be named `catppuccin-mocha`, never bare `catppuccin`:** Neovim 0.12 bundles `$VIMRUNTIME/colors/catppuccin.vim`. With the bare name, lazy.nvim's `Loader.colorscheme` sees the name in `getcompletion("", "color")` and never loads the plugin, so Neovim sources the builtin — the plugin's options compile to `~/.cache/nvim/catppuccin` and are silently ignored, and `:set background=light` drops the colorscheme. The suffix does not pin the flavour: catppuccin re-reads `background` on a flip and lands on latte. Verify with `:lua print(vim.g.colors_name, vim.g.terminal_color_3)` — the builtin leaves `terminal_color_3` nil.
- **Catppuccin config carries deltas only.** LazyVim's own catppuccin spec supplies the integration list and undercurl diagnostics, and `auto_integrations` enables every integration whose plugin is installed. Add an `integrations` entry only to pass an option, always with `enabled = true` — a table without it reads as disabled and undoes LazyVim's enable.
- **The colorscheme is transparent, and the background image lives in WezTerm.** Neovim cannot draw a background image; catppuccin only clears `Normal`'s bg so the terminal's wallpaper shows through. The image, its dimming, and the scrim are configured in `~/.config/wezterm/config/background.lua` (a separate git repo) and wired up in `config/schemes/catppuccin_glass.lua`. Editing transparency here without that file in place leaves a flat terminal-default background.
- **Transparency and `dim_inactive` are mutually exclusive.** With both set, catppuccin gives `NormalNC` an opaque `C.dim` background (`groups/editor.lua`), turning every inactive split into a solid rectangle over the wallpaper. `dim_inactive` is off and must stay off.
- **Floats stay opaque on purpose.** LSP hovers, which-key, and snacks pickers need a solid background to read against the image. catppuccin gates `NormalFloat` on the separate `float.transparent` option (not `transparent_background`), so it stays opaque by default — do not set it.
- **Theme overrides stay palette-derived:** `custom_highlights` takes the `colors` table catppuccin passes it rather than hex literals, so overrides follow a mocha/latte flip. Bufferline needs no override — LazyVim's catppuccin spec already ships one.
- **Override specs for extra-provided plugins** must set `optional = true`; without it, the spec installs the plugin even when its extra is disabled. No spec in `lua/plugins/` currently needs it.
- **Macros:** bare `q` only stops a recording; `<leader>Q` starts recording into register `q` (`lua/config/keymaps.lua`). Stopping stays on bare `q` because which-key's leader capture is unreliable while recording.
- **Surround:** mini.surround is remapped to the `gz` prefix (`gza`, `gzd`, `gzr`, …).
- **Prettier** runs only when the project has a Prettier config (`vim.g.lazyvim_prettier_needs_config`).
- **Python:** LSP is `basedpyright`; conform runs `ruff_fix` → `ruff_organize_imports` → `ruff_format`.
- **Tests:** `test.core` ships no adapters; JS/TS uses `neotest-vitest` registered in `lua/plugins/neotest-vitest.lua`.
- **Markdown lint/format:** nvim-lint and conform pass `--config` pointing at `.markdownlint-cli2.jsonc` in this repo, so rule changes there apply to all markdown edited in Neovim, not just files in this repo.
