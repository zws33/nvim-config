return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      hover = {
        -- noice toasts "No information available" per client that returns
        -- nothing, which tailwindcss does on every TS hover. K is now silent
        -- when no client has docs.
        silent = true,
      },
      signature = {
        enabled = true, -- keep enabled so you can trigger it manually
      },
      progress = {
        enabled = false, -- silence pyright/LSP progress toasts in the corner
      },
    },

    -- Border on the `hover` view, shared by hover and signature help.
    presets = {
      lsp_doc_border = true,
    },

    views = {
      hover = {
        win_options = {
          -- Hover only; other floats keep NormalFloat's mantle.
          winhighlight = { Normal = "NoiceHoverNormal", FloatBorder = "NoiceHoverBorder" },
        },
      },
    },
  },
}
