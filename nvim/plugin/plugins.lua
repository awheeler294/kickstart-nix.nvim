if vim.g.did_load_plugins_plugin then
   return
end
vim.g.did_load_plugins_plugin = true

-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

-- Indent Blankline - adds indentation guides
require("ibl").setup()

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup { n_lines = 500 }

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

-- Commenting support
--
--
-- Toggle comment (like `gcip` - comment inner paragraph) for both
-- Normal and Visual modes
-- 'gc'

-- Toggle comment on current line
-- 'gcc',

-- Toggle comment on visual selection
-- 'gc',

-- Define 'comment' textobject (like `dgc` - delete whole comment block)
-- Works also in Visual mode if mapping differs from `comment_visual`
-- 'gc',
require('mini.comment').setup()

-- TODO: add a comment here
require("todo-comments").setup { signs = false }

require("colorizer").setup({
   options = { parsers = { css = true } },
})
