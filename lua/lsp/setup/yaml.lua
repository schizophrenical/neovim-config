--- YAML LSP Setup

local conf = require('lsp.conf')
local lspconfig = require('lspconfig')
local util = lspconfig.util

lspconfig.yamlls.setup({
  flags = conf.flags,
  capabilities = conf.capabilities,
  cmd = { 'yaml-language-server', '--stdio' },
  root_dir = util.find_git_ancestor,
  handlers = {
    ['$/progress'] = conf.progress_handler,
  },
  single_file_support = true,
  settings = {
    schemasStrore = {
      enabled = false,
    },
    schemas = require('schemastore').yaml.schemas(),
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
})
