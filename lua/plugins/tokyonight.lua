-- Tokyonight, configured to mirror the catppuccin frappe setup in
-- colorscheme.lua so you can A/B the two. This installs tokyonight alongside
-- the other themes but does NOT make it active — kanagawa is the default.
--
-- To compare, switch live:
--   :colorscheme tokyonight-moon   (this config)
--   :colorscheme kanagawa          (your default)
-- To make tokyonight the permanent default, point the LazyVim spec's
-- `colorscheme` at "tokyonight-moon" (see kanagawa.lua for the pattern).
--
-- Why no `config`-function fix like catppuccin needs: tokyonight's `load()`
-- recomputes highlights live from its options on every call, so opts always
-- apply regardless of load order. Plain `opts` is enough here.
return {
  "folke/tokyonight.nvim",
  -- lazy: tokyonight is NOT the active theme, so keep it out of the startup
  -- load order (a second lazy=false/priority=1000 colorscheme perturbs when
  -- catppuccin's setup runs and can bump it off frappe). lazy.nvim loads this
  -- on demand the moment you run `:colorscheme tokyonight-moon`.
  lazy = true,
  opts = {
    -- "moon" is the closest analogue to frappe: a soft, mid-dark variant.
    -- (storm = brighter, night = darkest, day = light/latte equivalent.)
    style = "moon",
    light_style = "day", -- the latte equivalent for :set background=light

    -- Themes :terminal buffers (dev servers, REPLs, watchers) with the
    -- tokyonight palette. Mirrors catppuccin's `term_colors = true`.
    terminal_colors = true,

    -- transparent = true,

    styles = {
      -- tokyonight only exposes italic toggles for these token classes;
      -- conditionals/types are handled in on_highlights below to match
      -- the catppuccin `styles` block.
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      -- Give floats and sidebars (neo-tree, help) a slightly darker bg so
      -- they separate from the editor — tokyonight's analogue to theming
      -- the FloatBorder/mantle in catppuccin.
      sidebars = "dark",
      floats = "dark",
    },

    -- Resolved palette tweaks. `c` is the moon palette (theme-consistent),
    -- mirroring catppuccin's `color_overrides`. Left empty by default.
    on_colors = function(colors)
      -- Example: colors.comment = colors.blue1
    end,

    -- Highlight overrides — the tokyonight equivalent of catppuccin's
    -- `custom_highlights`. `hl` is the highlight table, `c` the palette.
    on_highlights = function(hl, c)
      -- Frappe nudged comments brighter; do the same here. tokyonight's
      -- default comment grey is dim — bump it and keep the italic.
      hl.Comment = { fg = c.dark5, italic = true }

      -- Match the catppuccin `styles` italics that tokyonight lacks toggles
      -- for: conditionals and types.
      hl.Conditional = { fg = c.purple, italic = true }
      hl.Type = { fg = c.blue1, italic = true }

      -- Accent the floating-window borders (LSP hovers, which-key, snacks
      -- pickers) with blue — the moon analogue to frappe's lavender.
      hl.FloatBorder = { fg = c.blue, bg = c.bg_float }

      -- Stronger, unmistakable visual selection (catppuccin used surface1 + bold).
      hl.Visual = { bg = c.bg_highlight, bold = true }

      -- Inlay hints get a subtle background so pyright/ts_ls hints don't
      -- blend into the line — mirrors `lsp_styles.inlay_hints.background`.
      hl.LspInlayHint = { fg = c.dark5, bg = c.bg_highlight }

      -- Color the snacks animated indent-scope guide to match — this is the
      -- tokyonight equivalent of catppuccin's `snacks.indent_scope_color`.
      hl.SnacksIndentScope = { fg = c.blue }
    end,

    -- tokyonight auto-styles most plugins; it has no per-integration toggle
    -- list like catppuccin. The `plugins` table can force-enable/disable
    -- specific ones, but auto-detection covers your extras (diffview, dap,
    -- render-markdown, illuminate, snacks, neo-tree, etc.) out of the box.
  },
}
