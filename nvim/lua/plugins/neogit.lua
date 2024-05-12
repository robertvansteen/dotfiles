return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  cmd = "Neogit",
  lazy = true,
  config = function()
    require("neogit").setup()
    local theme = require("base46").get_theme_tb "base_16"
    local colors = require("base46").get_theme_tb "base_30"

    vim.api.nvim_set_hl(0, "NeogitDiffContext", { fg = theme.base05, bg = colors.base00 })
    vim.api.nvim_set_hl(0, "NeogitDiffContextHighlight", { fg = theme.base05, bg = colors.base00 })
    vim.api.nvim_set_hl(0, "NeogitCursorLine", { bg = colors.base00 })

    vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight", { fg = colors.green })
    vim.api.nvim_set_hl(0, "NeogitDiffAdd", { fg = colors.green })

    vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", { fg = colors.red })
    vim.api.nvim_set_hl(0, "NeogitDiffDelete", { fg = colors.red })
  end,
}
