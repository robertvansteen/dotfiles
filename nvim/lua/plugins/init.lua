return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require("conform").setup {
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        },
        formatters_by_ft = {
          lua = { "stylua" },
          rust = { "rustfmt" },
        },
      }
    end,
  },

  "williamboman/mason.nvim",
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "rust-analyzer",
        "rustfmt",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    opts = {
      window = {
        documentation = {
          border = "rounded",
          winhighlight = "NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder",
        },
      },
    },
  },
}
