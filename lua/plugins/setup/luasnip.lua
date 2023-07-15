--- Luasnip setup

local config = require('luasnip.config')

config.set_config({
  history = true,
  updateevents = 'TextChanged, TextChangedI',
  enable_autosnippets = true,
  ext_opts = {
    [require('luasnip.util.types').choiceNode] = {
      active = {
        virt_text = {
          {
            '',
            'DiagnosticHint',
          },
        },
      },
    },
  },
})
