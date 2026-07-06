return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      -- Lock frappe for dark and latte for light, so a `:set background`
      -- flip (or a terminal that reports light) can't bump you off frappe.
      background = { dark = "mocha", light = "latte" },

      -- Make :terminal buffers (dev servers, REPLs, test watchers) use the
      -- catppuccin palette instead of your terminal's raw 16 colors.
      term_colors = true,

      -- transparent_background = true

      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        keywords = { "italic" },
        types = { "italic" },
      },

      -- Inlay hints get a subtle background so pyright/ts_ls parameter and
      -- type hints don't blend into the line. (Merges with LazyVim's
      -- existing lsp_styles, which already sets undercurl underlines.)
      lsp_styles = {
        inlay_hints = { background = true },
      },

      -- LazyVim already enables most integrations (snacks, telescope, gitsigns,
      -- neotest, neo-tree, noice, mason, treesitter_context, which_key, …).
      -- These are the deltas worth setting for this config's extras/workflow.
      integrations = {
        diffview = true, -- you have the diffview extra; off by default in catppuccin
        dap = true, -- Python/JS debugging UI theming
        dap_ui = true,
        render_markdown = true, -- markdown extra preview rendering
        illuminate = { enabled = true, lsp = true }, -- LSP-aware word highlight
        -- Snacks is already enabled by LazyVim's catppuccin spec; declaring it
        -- here lets us color the animated indent-scope guide. "lavender" is the
        -- frappe accent — swap for mauve/sky/teal/peach to taste.
        snacks = { enabled = true, indent_scope_color = "lavender" },
      },

      -- A few popular readability tweaks. `colors` is the resolved frappe
      -- palette, so these stay theme-consistent.
      custom_highlights = function(colors)
        return {
          -- Frappe's default comment grey is dim; nudge it brighter. Keep the
          -- italic from `styles.comments` by re-declaring it here.
          Comment = { fg = colors.overlay2, italic = true },
          -- Theme floating-window borders to the lavender accent instead of
          -- the muted default (LSP hovers, which-key, snacks pickers).
          FloatBorder = { fg = colors.lavender, bg = colors.mantle },
          -- Slightly stronger visual selection so it's unmistakable.
          Visual = { bg = colors.surface1, bold = true },
        }
      end,
    },

    -- Apply the colorscheme *after* setup() so our opts are loaded before
    -- catppuccin paints the screen. Without this, LazyVim runs
    -- `colorscheme catppuccin` before setup() and the screen keeps defaults.
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin" },
  },
}
