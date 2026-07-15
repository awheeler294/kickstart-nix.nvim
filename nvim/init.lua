vim.loader.enable()

local cmd = vim.cmd
local opt = vim.o

-- <leader> key. Defaults to `\`. Some people prefer space.
-- The default leader is '\'. Some people prefer <space>. Uncomment this if you do, too.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- See :h <option> to see what the options do

-- Search down into subfolders
opt.path = vim.o.path .. '**'

opt.number = true
-- opt.relativenumber = true
opt.cursorline = true -- Show which line your cursor is on
-- opt.lazyredraw = true
opt.showmatch = true  -- Highlight matching parentheses, etc
opt.incsearch = true
opt.hlsearch = true

opt.spell = false
opt.spelllang = 'en'
opt.spelloptions = 'camel'

opt.expandtab = true -- bool: Use spaces instead of tabs
opt.tabstop = 3      -- num:  Number of spaces tabs count for
opt.softtabstop = 3  -- num:  Number of spaces tabs count for in insert mode
opt.shiftwidth = 3   -- num:  Size of an indent
opt.foldenable = true
opt.history = 2000
opt.nrformats = 'alpha,bin,hex,octal'
opt.undofile = true
opt.splitright = true
opt.splitbelow = true

-- opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
opt.colorcolumn = '81' -- str:  Show col for max line length

--
-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after  because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Every wrapped line will continue visually indented (same amount of
-- space as the beginning of that line), thus preserving horizontal blocks
-- of text.
opt.breakindent = true

-- when wrapping, break line at word boundaries
opt.linebreak = true

-- Enable undo/redo changes even after closing and reopening a file
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 5

-- if performing an operation that would fail due to unsaved changes in the buffer (like ),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See
opt.confirm = true

-- hide the default mode display, eg --Insert--
vim.opt.showmode = false

-- Configure Neovim diagnostic messages

local function prefix_diagnostic(prefix, diagnostic)
   return string.format(prefix .. ' %s', diagnostic.message)
end

vim.diagnostic.config {
   virtual_text = {
      prefix = '',
      format = function(diagnostic)
         local severity = diagnostic.severity
         if severity == vim.diagnostic.severity.ERROR then
            return prefix_diagnostic('󰅚', diagnostic)
         end
         if severity == vim.diagnostic.severity.WARN then
            return prefix_diagnostic('⚠', diagnostic)
         end
         if severity == vim.diagnostic.severity.INFO then
            return prefix_diagnostic('ⓘ', diagnostic)
         end
         if severity == vim.diagnostic.severity.HINT then
            return prefix_diagnostic('󰌶', diagnostic)
         end
         return prefix_diagnostic('■', diagnostic)
      end,
   },
   signs = {
      text = {
         -- Requires Nerd fonts
         [vim.diagnostic.severity.ERROR] = '󰅚',
         [vim.diagnostic.severity.WARN] = '⚠',
         [vim.diagnostic.severity.INFO] = 'ⓘ',
         [vim.diagnostic.severity.HINT] = '󰌶',
      },
   },
   update_in_insert = false,
   underline = true,
   severity_sort = true,
   float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'if_many',
      header = '',
      prefix = '',
   },

   -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
   jump = { on_jump = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Native plugins
cmd.filetype('plugin', 'indent', 'on')
cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo

-- let sqlite.lua (which some plugins depend on) know where to find sqlite
vim.g.sqlite_clib_path = require('luv').os_getenv('LIBSQLITE')

-- harper for grammar checking
vim.lsp.config['harper_ls'] = {
   cmd = { 'harper-ls', '--stdio' },
   filetypes = { 'markdown', 'text', 'tex', 'typst', 'gitcommit' },
   root_markers = { '.git' },
   settings = {
      ["harper-ls"] = {
         userDictPath = "~/dict.txt",
         linters = {
            SpellCheck = true,
            SpelledNumbers = false,
            SentenceCapitalization = true,
         }
      }
   }
}

-- harper code aware grammar checking
vim.lsp.enable('harper_ls')

-- codebook code aware spellchecking
vim.lsp.enable('codebook')
