return {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = false,
          },
          grep = {
            hidden = true,
            ignored = false,
          },
          explorer = {
            hidden = true,  -- Show hidden files (dotfiles)
            ignored = true, -- Show files ignored by Git
          },
        },
      },
    },
  }