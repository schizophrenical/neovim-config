--- LSP Servers init

-- initialize neodev for lua_ls
require('neodev').setup({})

local lspconfig = require('lspconfig')

-- Shared config
local shared = require('lsp.conf')
-- Base config
local base_conf = {
  flags = shared.flags,
  capabilities = shared.flags,
  handlers = {
    ['$/progress'] = shared.progress_handler,
  },
}

---Merge base config with a language specific config
---@param base table base lsp config
---@param lang table language specific config
---@return table config merged base and language-specific config
local function merge_conf(base, lang)
  return vim.tbl_extend('force', base, lang)
end

---------------------------------------------------------------------------------------------------
----------------------------------- LSP Servers ---------------------------------------------------
---------------------------------------------------------------------------------------------------
-- Lua
local lua = require('lsp.setup.lua')
lspconfig.lua_ls.setup(merge_conf(base_conf, lua))

-- JSON
local json = require('lsp.setup.json')
lspconfig.jsonls.setup(merge_conf(base_conf, json))

-- YAML
local yaml = require('lsp.setup.yaml')
lspconfig.yamlls.setup(merge_conf(base_conf, yaml))
---------------------------------------------------------------------------------------------------
