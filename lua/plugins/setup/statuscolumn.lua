-- Statuscolumn
local builtin = require('statuscol.builtin')

require('statuscol').setup({
  relculright = true,
  ft_ignore = {
    'NvimTree',
    'alpha',
    'help',
    '',
    'TelescopePrompt',
    'TelescopeResults',
    'lazy',
    'DiffviewFiles',
    'dapui_breakpoints',
    'dapui_console',
    'dapui_hover',
    'dap-repl',
    'dapui_scopes',
    'dapui_stacks',
    'dapui_watches',
  },
  segments = {
    -- Folds
    {
      text = {
        -- replace signs for folds before
        -- sending it to the builtin.
        function(args)
          args.fold.open = ''
          args.fold.close = ''
          args.fold.sep = '┆'
          return builtin.foldfunc(args)
        end
      },
      hl = 'CmpItemKindUnit',
      click = 'v:lua.ScFa',
      auto = true
    },
    -- Separator
    {
      text = { ' ' },
      hl = "SignColumn",
      maxwidth = 1,
      colwidth = 1,
    },
    -- Diagnostic/Todo
    {
      sign = {
        name = {
          'Diagnostic',
          'NOTE.*',
          'FIX.*',
          'TODO.*',
          'HACK.*',
          'WARN.*',
          'PERF.*',
          'TEST.*',
          'FIXME.*',
          'BUG.*',
          'FIXIT.*',
          'ISSUE.*',
          'ERROR.*',
        },
        maxwidth = 1,
        -- prevent flickering due to removing/applying the diagnostic column
        auto = false,
      },
      click = 'v:lua.ScSa'
    },
    -- Line numbers
    {
      text = { builtin.lnumfunc, ' ' },
      condition = { true, builtin.not_empty },
      click = "v:lua.ScLa",
    },
    -- Git signs
    {
      sign = {
        name = { 'GitSign.*' },
        maxwidth = 1,
        auto = false,
        colwidth = 1,
        fillchar = '│',
        fillcharhl = 'WhichKeySeparator',
      },
      click = "v:lua.ScSa",
    },
  },
})
