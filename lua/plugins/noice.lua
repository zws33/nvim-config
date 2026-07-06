return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      signature = {
        enabled = true, -- keep enabled so you can trigger it manually
      },
      progress = {
        enabled = false, -- silence pyright/LSP progress toasts in the corner
      },
    },
  },
}
