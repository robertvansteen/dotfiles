local dashboard = require('dashboard')
local ascii = require('ascii')

dashboard.setup({
  config = {
    header = ascii.art.text.neovim.sharp,
  }
})
