return {
    {
      "LazyVim/LazyVim",
      keys = {
        {
          "<leader>tf",
          function()
            -- Get all windows
            local winid = nil
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local buf = vim.api.nvim_win_get_buf(win)
              local ft = vim.api.nvim_buf_get_option(buf, "filetype")
              if ft == "lazyterm" then
                winid = win
                break
              end
            end
  
            if winid then
              if winid == vim.api.nvim_get_current_win() then
                -- If you're already in the terminal, close it
                vim.api.nvim_win_close(winid, true)
              else
                -- If terminal is open but you're not in it, jump to it
                vim.api.nvim_set_current_win(winid)
              end
            else
              -- If no floating terminal is open, open one
              require("lazyvim.util.terminal").open(nil, { float = true })
            end
          end,
          desc = "Smart toggle floating terminal",
        },
      },
    },
  }