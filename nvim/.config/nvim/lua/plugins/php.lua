return {
  -- Add phpstan to linting (LazyVim PHP extra only ships phpcs)
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        php = { "phpstan" },
      },
    },
  },

  -- Ensure phpstan is installed via Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "phpstan" },
    },
  },

  -- Blade template support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "blade" },
    },
  },
}
