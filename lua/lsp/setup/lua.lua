--- Lua LSP Server

-- Lua LSP config
local conf = require('lsp.conf')
local lsp = require('lspconfig')

-- Neodev
require('neodev').setup({})

lsp.lua_ls.setup({
  -- root dir is found via the .stylua.toml file.
  flags = conf.flags,
  capabilities = conf.capabilities,
  cmd = { 'lua-language-server' },
  handlers = {
    ['$/progress'] = conf.progress_handler,
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      completion = {
        displayContext = 1,
      },
      diagnostics = {
        -- Make the server recognize vim globals.
        globals = { 'vim' },
      },
      -- WARN: Follow virtual text PR and update accordingly.
      hint = {
        enable = true,
        -- setType = true,
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        -- Neverrr!!
        enable = false,
      },
      -- formatting disabled in favor of stylua and editorconfig
      format = {
        enable = false,
      },
    },
  },
})
