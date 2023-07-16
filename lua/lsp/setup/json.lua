--- JSON LSP server

local conf = require('lsp.conf')
local lspconfig = require('lspconfig')
local util = lspconfig.util

lspconfig.jsonls.setup({
  cmd = { 'vscode-json-language-server', '--stdio' },
  flags = conf.flags,
  handlers = {
    ['$/progress'] = conf.progress_handler,
  },
  filetypes = { 'json', 'jsonc' },
  root_dir = util.find_git_ancestor,
  single_file_support = true,
  init_options = {
    provideFormatter = true,
  },
  settings = {
    json = {
      schema = require('schemastore').json.schemas(),
      validate = {
        enable = true,
      },
    },
  },
})
