--- UI related settings

-- init lsp kind (does not need an actual LSP client to work)
require('lspkind').init()

-- add diagnostic signs
local signs = {
  Error = '',
  Warn = '',
  Hint = '',
  Info = '',
}
-- alternative signs
local alt_signs = {
  Error = '',
  Warn = '',
  Hint = '',
  Info = '',
}

-- add debug signs
local debug_signs = {
  DapBreakpoint = {
    text = '',
    texthl = 'TodoSignTODO',
    linehl = '',
    numhl = '',
  },
  DapBreakpointCondition = {
    text = '',
    texthl = 'Conditional',
    linehl = '',
    numhl = '',
  },
  DapBreakpointRejected = {
    text = '',
    texthl = 'Comment',
    linehl = '',
    numhl = '',
  },
}

for type, icon in pairs(alt_signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

for sign in pairs(debug_signs) do
  vim.fn.sign_define(sign, debug_signs[sign])
end

---Override diagnostic signs and virtual text.
vim.diagnostic.config({
  virtual_text = {
    --severity = vim.diagnostic.severity.ERROR,
    underline = true,
    source = 'if_many',
    prefix = ' ',
  },
  signs = true,
  update_in_insert = false,
})

vim.cmd([[colorscheme midnight]])
