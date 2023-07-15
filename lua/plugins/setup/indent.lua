--- indent_blankline setup

require('indent_blankline').setup({
  -- show context if it is off
  show_current_context = true,
  show_current_context_start = false,
  show_end_of_line = true,
  space_char_blankline = ' ',
  char = '¦',
  char_blank_line = ' ',
  context_char_list = { '¦' },
})
