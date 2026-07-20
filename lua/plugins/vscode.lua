-- vscode.nvim - VS Code Dark+/Light+ theme for Neovim
-- BACKUP COLORSCHEME - kanagawa is the default (see kanagawa.lua).
-- Activate manually with :colorscheme vscode
--
-- lazy: a second lazy=false/priority=1000 colorscheme perturbs the startup
-- load order and can end up applying over kanagawa. lazy.nvim loads this on
-- demand the moment you run `:colorscheme vscode`.
return {
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      -- Automatically uses vim.o.background ('dark' by default)
      -- Can override with style = "dark" or style = "light"

      -- Match catppuccin mocha preferences
      transparent = false,
      italic_comments = true,
      italic_inlayhints = true,
      underline_links = true,
      disable_nvimtree_bg = false,
      terminal_colors = true,

      -- Color overrides - vscode.nvim palette variables
      -- See: lua/vscode/colors.lua for the full set
      color_overrides = {
        -- vscLineNumber = '#FFFFFF',
      },

      -- Highlight group overrides to match catppuccin mocha aesthetic
      -- Using catppuccin mocha palette colors for consistency:
      -- rosewater = #f5e0dc, flamingo = #f2cdcd, pink = #f5c2e7, mauve = #cba6f7
      -- red = #f38ba8, maroon = #eba0ac, peach = #fab387, yellow = #f9e2af
      -- green = #a6e3a1, teal = #94e2d5, sky = #89d185, sapphire = #89b4fa
      -- blue = #89b4fa, lavender = #b4befe
      -- text = #cdd6f4, subtext1 = #bac2de, subtext2 = #a6adc8
      -- overlay2 = #9399b2, overlay1 = #7f849c
      -- surface2 = #6c7086, surface1 = #585b70, surface0 = #45475a
      -- base = #313244, mantle = #1e1e2e, crust = #11111b
      group_overrides = {
        -- Float borders - catppuccin uses lavender on mantle
        FloatBorder = { fg = "#b4befe", bg = "#1e1e2e" },
        -- Brighter comments like catppuccin (overlay2)
        Comment = { fg = "#9399b2", italic = true },
        -- Visual selection - catppuccin uses surface1 with bold
        Visual = { bg = "#585b70", bold = true },
        -- Inlay hints (Python type hints/ghost text) - VS Code default style
        -- Match VS Code's native inlay hint appearance
        LspInlayHint = { fg = "#6e7681", bg = "#1e1e1e" },
        -- Stronger cursor line - catppuccin mocha surface0 (its own CursorLine
        -- color), so the highlighted line stays on-palette instead of the
        -- bluish off-palette value it had before.
        CursorLine = { bg = "#313244" },
        -- Float background
        NormalFloat = { bg = "#1e1e2e" },
        FloatTitle = { fg = "#b4befe", bg = "#1e1e2e" },
        -- which-key popup: vscode.nvim themes only the icons + a grey border and
        -- leaves WhichKeyNormal/Title unset. which-key's own defaults are set
        -- with `default = true`, so vscode's `hi clear` on every colorscheme
        -- apply wipes them and they never come back (its ColorScheme autocmd
        -- only re-links the icon groups). Point the window groups at the themed
        -- float groups here — group_overrides run last in load(), so this wins
        -- and the popup matches LSP hovers (lavender border on mantle).
        WhichKeyNormal = { link = "NormalFloat" },
        WhichKeyBorder = { link = "FloatBorder" },
        WhichKeyTitle = { link = "FloatTitle" },
      },
    },
    config = function(_, opts)
      require("vscode").setup(opts)
    end,
  },
}
