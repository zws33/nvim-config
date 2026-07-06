return {
  -- Vitest adapter for neotest. The `test.core` extra provides neotest itself
  -- but ships no language adapters, so the <leader>t* keymaps are inert for
  -- JS/TS until an adapter is registered here.
  { "marilari88/neotest-vitest" },
  {
    "nvim-neotest/neotest",
    opts = { adapters = { "neotest-vitest" } },
  },
}
