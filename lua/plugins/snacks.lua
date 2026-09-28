return {
  "folke/snacks.nvim",
  -- stylua: ignore
  keys = {
    -- Zen: distraction-free single window. Uses the themed SnacksBackdrop/Dim.
    { "<leader>z", function() Snacks.zen() end, desc = "Zen Mode" },
    -- Zoom: maximize the current window without closing the others.
    { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom" },
    -- Override <leader>e to always open in the CWD instead of automatic root discovery
    { "<leader>e", function() Snacks.explorer({ cwd = vim.fn.getcwd() }) end, desc = "Explorer (CWD)" },
  },
  opts = {
    picker = {
      -- Float frequently/recently used and cwd-local results to the top
      matcher = {
        frecency = true,
        cwd_bonus = true,
      },
    },

    -- Indent guides + animated current-scope highlight. The scope line is
    -- colored by catppuccin's `snacks.indent_scope_color` integration option
    -- (see catppuccin.lua). `style = "out"` animates the scope outward from the
    -- cursor when you move into a new block.
    indent = {
      indent = { char = "│" },
      scope = { char = "│", underline = false },
      animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        style = "out",
        easing = "linear",
        duration = { step = 20, total = 300 },
      },
    },

    -- nvim-notify-style notifications, themed via SnacksNotifier* groups.
    -- LSP progress, formatter output, and test results render as fancy toasts.
    notifier = {
      enabled = true,
      style = "fancy",
      top_down = false, -- stack from the bottom-right, out of the way of code
    },

    -- Needs Kitty/WezTerm/Ghostty graphics protocol; no-ops elsewhere.
    image = { enabled = true },

    -- Two-pane "doom" dashboard. Header is overridden below; keys come from
    -- LazyVim's preset. Right pane shows recent files, projects, and a live
    -- `git status` (themed via SnacksDashboardTerminal) — handy on startup.
    dashboard = {
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
  },
}
