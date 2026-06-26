return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "frappe",
      term_colors = true,
      transparent_background = true,
      show_end_of_buffer = true,
      float = {
        transparent = true,
        solid = false,
      },
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.10,
      },

      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        keywords = { "italic" },
      },

      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        telescope = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
          inlay_hints = {
            background = true,
          },
        },
        mason = true,
        noice = true,
        notify = true,
        mini = true,
        which_key = true,
        snacks = {
          enabled = true,
          indent_scope_color = "lavender",
        },
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin" },
  },
}
