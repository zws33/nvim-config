-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>ub", function()
  vim.o.background = vim.o.background == "dark" and "light" or "dark"
end, { desc = "Toggle Light/Dark Background" })

-- Macros -------------------------------------------------------------------
-- `q` in normal mode is made "stop-only":
--   idle      -> does nothing (blocks accidental macro recording, the footgun)
--   recording -> `q` stops the recording (that press is never an accident)
-- Stopping stays on bare `q` on purpose: it's the classic Vim muscle memory
-- and, unlike a <leader> sequence, it does NOT route through which-key, whose
-- leader capture is unreliable while a macro is recording. expr mappings are
-- noremap, so the returned `q` reaches Neovim's built-in stop, not this map.
vim.keymap.set("n", "q", function()
  return vim.fn.reg_recording() ~= "" and "q" or ""
end, { expr = true, desc = "Stop macro recording (start disabled; use <leader>Q)" })

-- Deliberate start of a recording into register `q`. Also stops, but prefer
-- bare `q` to stop (see above). Replay with `@q`, repeat with `@@`.
vim.keymap.set("n", "<leader>Q", function()
  return vim.fn.reg_recording() ~= "" and "q" or "qq"
end, { expr = true, desc = "Record macro (reg q); stop with q" })
