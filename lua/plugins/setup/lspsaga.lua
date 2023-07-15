-- LSP Saga setup

require('lspsaga').setup({
  ui = {
    -- currently only round theme
    theme = 'round',
    -- border type can be single,double,rounded,solid,shadow.
    border = 'solid',
    winblend = 0,
    expand = ' ',
    collapse = 'ﬔ ',
    preview = ' ',
    code_action = ' ',
    action_fix = ' ',
    diagnostic = ' ',
    incoming = ' ',
    outgoing = ' ',
    title = false,
  },
  diagnostic = {
    show_code_action = true,
    jump_num_shortcut = true,
    text_hl_follow = true,
    border_follow = false,
  },
  symbol_in_winbar = {
    enable = false,
  },
  lightbulb = {
    enable = false,
  }
})