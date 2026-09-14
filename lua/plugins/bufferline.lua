return {
  "akinsho/bufferline.nvim",
  optional = true,
  opts = function(_, opts)
    local colorscheme = vim.g.colors_name or ""
    if colorscheme:find("kanagawa") then
      -- kanagawa ships no BufferLine* highlights and no helper module like
      -- catppuccin's. Derive them from the resolved variant palette so this
      -- stays correct across wave/dragon/lotus. `colors.setup()` reads the
      -- currently loaded theme, so it's safe here (kanagawa is already active).
      local theme = require("kanagawa.colors").setup().theme
      local selected = { fg = theme.ui.fg, bg = theme.ui.bg }
      local inactive = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 }
      opts.highlights = {
        fill = { bg = theme.ui.bg_m3 },
        background = inactive,
        buffer_visible = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
        buffer_selected = vim.tbl_extend("force", selected, { bold = true, italic = false }),
        separator = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },
        separator_visible = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m1 },
        separator_selected = { fg = theme.ui.bg_m3, bg = theme.ui.bg },
        close_button = inactive,
        close_button_visible = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
        close_button_selected = { fg = theme.syn.special1, bg = theme.ui.bg },
        indicator_selected = { fg = theme.syn.special1, bg = theme.ui.bg },
        tab = inactive,
        tab_selected = vim.tbl_extend("force", selected, { bold = true }),
        tab_close = inactive,
        duplicate = vim.tbl_extend("force", inactive, { italic = true }),
        duplicate_visible = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1, italic = true },
        duplicate_selected = vim.tbl_extend("force", selected, { italic = true }),
        modified = { fg = theme.vcs.changed, bg = theme.ui.bg_m3 },
        modified_visible = { fg = theme.vcs.changed, bg = theme.ui.bg_m1 },
        modified_selected = { fg = theme.vcs.changed, bg = theme.ui.bg },
        pick = { fg = theme.diag.error, bg = theme.ui.bg_m3, bold = true },
        pick_visible = { fg = theme.diag.error, bg = theme.ui.bg_m1, bold = true },
        pick_selected = { fg = theme.diag.error, bg = theme.ui.bg, bold = true },
      }
    elseif colorscheme:find("catppuccin") then
      opts.highlights = require("catppuccin.special.bufferline").get_theme()
    end
  end,
}
