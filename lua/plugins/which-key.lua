return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      -- Explicit label + icon for the deliberate macro-record toggle defined
      -- in lua/config/keymaps.lua. which-key would show the mapping's `desc`
      -- on its own; this just gives it an icon and a stable label.
      { "<leader>Q", desc = "Record macro (reg q); stop with q", icon = { icon = "󰑋", color = "red" } },
    },
  },
}
