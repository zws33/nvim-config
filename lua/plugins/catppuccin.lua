-- Catppuccin (mocha) — the default colorscheme. LazyVim already ships the
-- catppuccin spec with its integration list and undercurl diagnostics, so this
-- file carries only the deltas from catppuccin's own defaults.
--
-- `colorscheme = "catppuccin-mocha"`, not the bare "catppuccin": Neovim 0.12
-- bundles its own $VIMRUNTIME/colors/catppuccin.vim. With the bare name,
-- lazy.nvim's colorscheme handler finds it in `getcompletion("", "color")` and
-- returns without loading the plugin (`lazy/core/loader.lua`, Loader.colorscheme),
-- so Neovim sources the builtin: every option below is compiled to
-- ~/.cache/nvim/catppuccin and never applied, and `:set background=light` drops
-- the colorscheme entirely. The builtin looks close enough that it passes for
-- the real thing — the tells are an unset FloatBorder and no terminal colors.
--
-- The flavour suffix does not pin the flavour here: on a `:set background` flip
-- catppuccin re-reads `background` (default `{ dark = "mocha", light = "latte" }`)
-- and lands on latte.
return {
  {
    "catppuccin/nvim",
    -- Required: LazyVim's spec is keyed on this name, and merging with it is
    -- what keeps its integration list and lsp_styles.
    name = "catppuccin",
    lazy = true,
    opts = {
      -- Clears Normal's bg to NONE so the WezTerm wallpaper shows through.
      -- Neovim cannot draw a background image; it can only decline to paint over
      -- one. The image itself is configured in ~/.config/wezterm/config/background.lua.
      -- Floats are unaffected: NormalFloat is gated on the separate `float.transparent`
      -- option (groups/editor.lua), which stays false, so LSP hovers, which-key and
      -- snacks pickers keep an opaque mantle to read against the wallpaper.
      transparent_background = true,

      -- Themes :terminal buffers (dev servers, REPLs, test watchers) with the
      -- catppuccin palette instead of the terminal's raw 16 colors.
      term_colors = true,

      -- Must stay off while transparent_background is on: with both set,
      -- groups/editor.lua gives NormalNC an opaque `C.dim` background, turning
      -- every inactive split into a solid rectangle over the wallpaper.
      dim_inactive = { enabled = false },

      -- Deltas only: comments and conditionals are italic by default.
      styles = {
        keywords = { "italic" },
        types = { "italic" },
      },

      -- `auto_integrations` (on by default) enables every integration whose
      -- plugin lazy has installed, so only entries carrying an *option* belong
      -- here. `enabled = true` is load-bearing: a table without it reads as
      -- disabled (`catppuccin/lib/mapper.lua`) and would undo LazyVim's enable.
      integrations = {
        illuminate = { enabled = true, lsp = true },
        snacks = { enabled = true, indent_scope_color = "lavender" },
      },

      -- Float borders default to blue; lavender reads as an accent against the
      -- wallpaper. Palette-derived, so latte works too. Only `fg` is set —
      -- catppuccin deep-merges this over its own FloatBorder, so the background
      -- keeps following `transparent_background`/`float`.
      custom_highlights = function(colors)
        return {
          FloatBorder = { fg = colors.lavender },
        }
      end,
    },
  },
  -- Single source of truth for the startup theme.
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-mocha" },
  },
}
