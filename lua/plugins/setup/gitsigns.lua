--- Gitsigns setup

require('gitsigns').setup({
  signcolumn = true,
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '╍' },
    topdelete    = { text = '━' },
    changedelete = { text = '╼' },
    untracked    = { text = '' },
  },
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 700,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '  <author>, <author_time:%Y-%m-%d> - <summary>',
})