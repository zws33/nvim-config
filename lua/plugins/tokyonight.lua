-- Tokyonight (moon) — the default colorscheme, configured to mirror the
-- catppuccin mocha setup in colorscheme.lua. kanagawa and catppuccin are
-- backups and must stay `lazy = true`: a second eager priority = 1000 theme
-- perturbs the startup load order and can apply over the default.
--
-- To compare, switch live:
--   :colorscheme tokyonight-moon   (this config)
--   :colorscheme kanagawa          (backup)
--   :colorscheme catppuccin        (backup)
--
-- Why no `config`-function fix like catppuccin needs: tokyonight's `load()`
-- recomputes highlights live from its options on every call, so opts always
-- apply regardless of load order. Plain `opts` is enough here.
--
-- No compile step either (unlike kanagawa): `on_highlights` runs after the
-- highlight cache is read, and the cache key already covers styles,
-- dim_inactive and the on_colors result, so edits here apply on next start.
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- "moon" is a soft, mid-dark variant.
      -- (storm = brighter, night = darkest, day = light/latte equivalent.)
      style = "moon",
      light_style = "day", -- the latte equivalent for :set background=light

      -- Themes :terminal buffers (dev servers, REPLs, watchers) with the
      -- tokyonight palette. Mirrors catppuccin's `term_colors = true`.
      terminal_colors = true,

      -- transparent = true,

      dim_inactive = true,

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

      -- Resolved palette tweaks. `colors` is the moon palette (theme-consistent),
      -- analogous to catppuccin's `color_overrides` option. Left empty by default.
      on_colors = function(colors)
        -- Example: colors.comment = colors.blue1
      end,

      -- Highlight overrides — the tokyonight equivalent of catppuccin's
      -- `custom_highlights`. `hl` is the highlight table, `c` the palette.
      on_highlights = function(hl, c)
        -- The catppuccin config nudges comments brighter; do the same here. tokyonight's
        -- default comment grey is dim — bump it and keep the italic.
        hl.Comment = { fg = c.dark5, italic = true }

        -- Match the catppuccin `styles` italics that tokyonight lacks toggles
        -- for: conditionals and types.
        hl.Conditional = { fg = c.purple, italic = true }
        hl.Type = { fg = c.blue1, italic = true }

        -- Accent the floating-window borders (LSP hovers, which-key, snacks
        -- pickers) with blue — the moon analogue to catppuccin's lavender.
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
      -- specific ones, but auto-detection covers your extras (dap,
      -- render-markdown, illuminate, snacks, neo-tree, etc.) out of the box.
    },
  },
  -- Single source of truth for the startup theme. Use "tokyonight" rather than
  -- "tokyonight-moon": the bare name routes through tokyonight's `load()`,
  -- which honors `style`/`light_style`, so a `:set background=light` flip
  -- lands on day instead of being pinned to moon.
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "tokyonight" },
  },
}
