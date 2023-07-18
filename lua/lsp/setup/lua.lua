--- Lua LSP Config

return {
  cmd = { 'lua-language-server' },
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
}
