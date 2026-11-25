return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      hover = {
        -- noice replaces vim.lsp.buf.hover with a per-client fan-out and notifies
        -- "No information available" for every client that returns nothing, so
        -- tailwindcss attached alongside vtsls adds a toast to each TS hover.
        -- Neovim's own hover aggregates instead. Cost: hovering where no client
        -- has docs is now silent.
        silent = true,
      },
      signature = {
        enabled = true, -- keep enabled so you can trigger it manually
      },
      progress = {
        enabled = false, -- silence pyright/LSP progress toasts in the corner
      },
    },
  },
}
