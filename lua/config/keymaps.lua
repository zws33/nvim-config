-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>ub", function()
  vim.o.background = vim.o.background == "dark" and "light" or "dark"
end, { desc = "Toggle Light/Dark Background" })

-- Disable accidental macro recording
vim.keymap.set("n", "q", "<Nop>")
-- Use <leader>m for macros
vim.keymap.set("n", "<leader>m", "q", { desc = "Macro" })
