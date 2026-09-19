-- kanagawa.nvim — PRIMARY COLORSCHEME
-- https://github.com/rebelot/kanagawa.nvim
--
-- Variants: wave (upstream default, warm mid-dark), dragon (darker/desaturated),
-- lotus (light). Switch live with :colorscheme kanagawa-{wave,dragon,lotus}.
--
-- Unlike catppuccin, kanagawa has no per-plugin `integrations` toggle list —
-- it ships highlights for a fixed set of plugins (neo-tree, neotest, dap-ui,
-- blink.cmp, mini.*, telescope, gitsigns, notify, treesitter-context, trouble)
-- and everything else inherits from the core groups it themes. See the
-- overrides block below for the few groups worth accenting by hand.
return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "dragon", -- wave, dragon, lotus
      -- Lock dragon for dark and lotus for light, so a `:set background` flip
      -- (or a terminal reporting light) can't bump you somewhere unexpected.
      background = { dark = "dragon", light = "lotus" },

      -- Bytecode-compile the highlight tables for faster startup. Re-run
      -- :KanagawaCompile after editing anything in this file.
      compile = true,

      undercurl = true,
      transparent = false,
      dimInactive = false, -- set true to dim non-focused splits

      -- Themes :terminal buffers (dev servers, REPLs, test watchers) with the
      -- kanagawa palette instead of your terminal's raw 16 colors.
      terminalColors = true,

      -- Mirrors the italics from the catppuccin setup. kanagawa exposes
      -- per-token-class style tables rather than a single `styles` block.
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = { italic = true },
      functionStyle = {},

      -- Palette / per-theme color overrides go here if you ever want them.
      colors = {
        palette = {},
        theme = { wave = {}, dragon = {}, lotus = {}, all = {} },
      },

      -- Highlight overrides. `colors.theme` is the resolved variant palette
      -- (ui/syn/diag/vcs/diff sub-tables), so using it instead of raw hexes
      -- keeps these correct across wave/dragon/lotus.
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- kanagawa's default comment grey is dim; nudge it brighter and
          -- keep the italic from `commentStyle`.
          Comment = { fg = theme.ui.fg_dim, italic = true },

          -- Accent floating-window borders (LSP hovers, which-key, snacks
          -- pickers) instead of the muted default border color.
          FloatBorder = { fg = theme.syn.special1, bg = theme.ui.bg_m1 },
          FloatTitle = { fg = theme.syn.special1, bg = theme.ui.bg_m1 },
          NormalFloat = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },

          -- Slightly stronger visual selection so it's unmistakable.
          Visual = { bg = theme.ui.bg_visual, bold = true },

          -- Inlay hints get a subtle background so pyright/ts_ls parameter
          -- and type hints don't blend into the line.
          LspInlayHint = { fg = theme.ui.fg_dim, bg = theme.ui.bg_p1 },

          -- snacks.nvim: kanagawa ships no Snacks* groups. Only the animated
          -- indent-scope guide is worth accenting — it defaults to `Special`,
          -- which is correct but generic. Everything else in snacks (picker,
          -- notifier, dashboard, zen) links to NormalFloat/FloatBorder/Normal
          -- and is already themed by the overrides above.
          SnacksIndent = { fg = theme.ui.bg_p2 },
          SnacksIndentScope = { fg = theme.syn.special1 },
        }
      end,
    },
  },
  -- Single source of truth for the startup theme. Without this, LazyVim's
  -- default loads and applies tokyonight before any other theme.
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "kanagawa" },
  },
}
