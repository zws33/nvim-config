return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      -- Run in order:
      -- 1) fix autofixable Ruff issues
      -- 2) organize imports
      -- 3) apply Ruff formatter
      --
      -- This gives you behavior closer to:
      --   ruff check --fix
      --   ruff format
      opts.formatters_by_ft.python = {
        "ruff_fix",
        "ruff_organize_imports",
        "ruff_format",
      }

      return opts
    end,
  },
}
