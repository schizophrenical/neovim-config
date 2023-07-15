-- Common settings

local listchars = {
  tab = '',
  lead = '-',
  trail = '!',
  eol = '',
}

-- Disable default keymaps for comments
vim.g.kommentary_create_default_mappings = false

local opt = vim.opt
local glob = vim.g
local wo = vim.wo

-- nvim tree suggests to disable netrw
glob.loaded_netrw = 1
glob.loaded_netrwPlugin = 1

-- enable mouse movement (bufferline)
opt.mousemev = true
-- enable line numbers
opt.number = true
-- enable relative line numbers
opt.relativenumber = true
-- enable cursor line
opt.cursorline = true
-- auto complete opts
opt.completeopt = 'menu,menuone,noselect'
-- enable term gui colors
opt.termguicolors = true
-- enable leading/trailing characters
opt.list = true
opt.listchars = listchars
-- dont show cmd
opt.showcmd = false
-- disable mode display
opt.showmode = false
--enable to force unix line endings even on windows
--opt.fileformat = 'unix'
--opt.fileformats = 'unix'
opt.ruler = false
-- set colorcolumn (window local)
wo.colorcolumn = '100'
wo.cursorlineopt = 'number'
opt.fillchars:append({ diff = '╱' })
wo.foldcolumn = 'auto'
wo.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
wo.foldenable = true
