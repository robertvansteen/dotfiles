return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        prettier = {
          condition = function(self, ctx)
            return vim.fs.find({
              ".prettierrc",
              ".prettierrc.js",
              ".prettierrc.json",
              ".prettierrc.yaml",
              ".prettierrc.yml",
              "prettier.config.js",
              "prettier.config.mjs",
              "prettier.config.cjs",
            }, { path = ctx.dirname, upward = true })[1] ~= nil
          end,
        },
      },
    },
  },

  -- Disable autoformat for JSON files
  {
    "LazyVim/LazyVim",
    opts = {
      autoformat = true,
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "json", "jsonc" },
        callback = function()
          vim.b.autoformat = false
        end,
      })
    end,
  },
}
