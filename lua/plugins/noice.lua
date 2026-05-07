return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      signature = {
        enabled = true, -- keep enabled so you can trigger it manually
        auto_open = false, -- <== this stops the insert-mode popup
      },
    },
  },
}
