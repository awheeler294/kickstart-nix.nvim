if vim.g.did_load_mini_statusline_plugin then
  return
end
vim.g.did_load_mini_statusline_plugin = true

local statusline = require 'mini.statusline'

statusline.setup({
   use_icons = vim.g.have_nerd_font
})

statusline.section_location = function() return '%2l:%-2v' end

