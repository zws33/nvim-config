# Enabled LazyVim extras

What each entry in `lazyvim.json` adds, and which keymaps come with it. Toggle entries with `:LazyExtras`; the file is version-controlled. Keymaps below are verified against the LazyVim commit pinned in `lazy-lock.json` (`9997009`) — re-check before trusting them after a lockfile bump.

Live sources of truth: `:LazyExtras`, `<leader>sk` (keymap picker), which-key on `<leader>`.

## TypeScript

- `lang.typescript` — vtsls LSP (`vim.g.lazyvim_ts_lsp = "vtsls"`). Buffer-local: `gD` goto source definition, `gR` file references, `<leader>cM` add missing imports, `<leader>cD` fix all diagnostics, `<leader>cV` select workspace TS version.
- `lang.typescript` also installs `js-debug-adapter`, registers the `pwa-node`/`chrome`/`msedge` adapters, and reads `.vscode/launch.json` via `dap.ext.vscode`.
- `linting.eslint` — eslint LSP with `workingDirectories = auto`, which finds configs in monorepo subfolders.
- `linting.eslint` registers ESLint as a **formatter** at priority 200 (`lazyvim_eslint_auto_format` defaults true), so `eslint --fix` runs on save alongside prettier.
- `formatting.prettier` — conform prettier, gated by `vim.g.lazyvim_prettier_needs_config = true` in `lua/config/options.lua`: no prettier config in the project, no prettier run.
- `lang.tailwind` — tailwindcss LSP. It attaches to every TS buffer under the resolved root, including backend packages with no Tailwind in them.
- `lang.json` / `lang.yaml` — SchemaStore validation and completion for `package.json`, `tsconfig.json`, GitHub Actions workflows, compose files.
- Tests: `lua/plugins/neotest-vitest.lua` registers the adapter; keys come from `test.core`.

## Python

- `lang.python` — ruff LSP for diagnostics and code actions, with `hoverProvider` disabled on attach so the type checker owns hover.
- `vim.g.lazyvim_python_lsp = "basedpyright"` in `lua/config/options.lua` replaces LazyVim's pyright default.
- `lang.python` adds the neotest-python adapter, `<leader>cv` venv selector, `<leader>dPt` debug test method, `<leader>dPc` debug test class.
- `lua/plugins/python.lua` sets the conform chain `ruff_fix` → `ruff_organize_imports` → `ruff_format`.

## Tasks, tests, debugging

- `editor.overseer` — `<leader>oo` run task, `<leader>ow` task list, `<leader>ot` task action. Ships templates for npm (`package.json` scripts), tox, make, just, mise, and `.vscode/tasks.json`.
- `test.core` — `<leader>tr` nearest, `<leader>tt` file, `<leader>tT` all files, `<leader>tw` watch, `<leader>ts` summary, `<leader>to` output, `<leader>tO` output panel, `<leader>tl` last, `<leader>tS` stop, `<leader>td` debug nearest.
- `dap.core` — `<leader>db` breakpoint, `<leader>dB` conditional breakpoint, `<leader>dc` run/continue, `<leader>da` run with args, `<leader>di`/`<leader>dO`/`<leader>do` step in/over/out, `<leader>du` dap-ui, `<leader>de` eval (normal and visual).

## Editing and navigation

- `coding.mini-comment` — `gc` with `ts-context-commentstring`, so JSX regions comment as `{/* */}` in the same file.
- `coding.mini-surround` — remapped to the `gz` prefix in `lua/plugins/mini-surround.lua` (`gza`, `gzd`, `gzr`).
- `coding.yanky` — `<leader>p` yank-history picker, `[y`/`]y` cycle the ring after pasting, `]p`/`[p` paste with reindent.
- `editor.refactoring` — `<leader>r` group: extract function, extract to file, extract variable, inline variable, debug prints, `<leader>rd` cleanup.
- `editor.aerial` — `<leader>cs` symbol outline.
- `editor.snacks_explorer` — `<leader>e` (overridden to cwd in `lua/plugins/snacks.lua`), `<leader>E`.
- `ui.edgy` — `<leader>ue` toggle, `<leader>uE` pick window; docks neotest summary, overseer list, DBUI and trouble.

## Other languages and tooling

- `lang.markdown` — marksman, render-markdown (`<leader>um`), `<leader>cp` preview. `lua/plugins/markdown.lua` points both nvim-lint and conform at this repo's `.markdownlint-cli2.jsonc`.
- `lang.sql` — dadbod, `<leader>D` DBUI, blink completion in SQL buffers.
- `lang.git` — treesitter parsers for gitcommit, git_rebase, gitconfig, gitignore, gitattributes.
- `util.dot` — bashls, shellcheck, dotfile treesitter parsers.
- `util.gh` — gh.nvim + litee, `<leader>G` tree (PRs, reviews, threads, issues). Requires the `gh` CLI.
- `lang.docker`, `lang.toml`, `lang.prisma`, `lang.java` (jdtls, `<leader>cx*` extracts), `lang.kotlin`, `lang.tex` (vimtex) — LSP, formatters and treesitter for those filetypes; idle otherwise, but they do pull mason packages.

## Non-obvious behavior

- LazyVim picks **one** explorer, one picker and one completion engine from an ordered defaults list (`lazyvim/config/init.lua`, `register_defaults`). `editor.snacks_explorer` outranks `editor.neo-tree`, so enabling both leaves neo-tree uninstalled — it was removed from `lazyvim.json` for that reason.
- Specs keyed on `"hrsh7th/nvim-cmp"` with `optional = true` never load here, because the completion engine is blink: `lang.git`'s cmp-git source and `lang.tailwind`'s colour swatches are both inert.
- Aerial's lualine symbol component is gated on `not vim.g.trouble_lualine`, and LazyVim sets that global true. The statusline breadcrumb comes from trouble; aerial contributes only `<leader>cs`.
- An override spec for a plugin that an extra provides must set `optional = true`, or it installs the plugin even when the extra is off.
