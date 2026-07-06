-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_python_lsp = "basedpyright"
-- Only run Prettier when a project actually has a Prettier config. Prevents
-- reformatting files in repos that use a different style (or none), which
-- would otherwise produce large, unrequested diffs on save.
vim.g.lazyvim_prettier_needs_config = true
