if vim.g.did_load_neovim_ayu_plugin then
  return
end
vim.g.did_load_neovim_ayu_plugin = true

local colors = require 'ayu.colors'
colors.generate(true) -- Pass `true` to enable mirage

require('ayu').setup {
  mirage = true,
  terminal = true, -- Set to `false` to let terminal manage its own colors.

  overrides = {
    NormalFloat = { bg = colors.panel_bg },
    WhichKeyFloat = { bg = colors.panel_bg },
    FloatBorder = { bg = colors.panel_border },
    FloatShadow = { bg = colors.panel_shadow },
  },
}

require('ayu').colorscheme()

-- You can configure highlights by doing something like:
vim.cmd.hi 'Comment gui=none'
