--- Main init file

-- Bootstrap the package manager
require('plugins').bootstrap_packman()
-- Setup the plugins
require('plugins').setup()
-- General editor settings
require('settings')
-- Keymaps
require('keymaps')
-- LSP Servers
require('lsp.setup')
-- Autocommands
require('autocmd')
