--- which-key setup

require('which-key').setup({
  window = {
    border = 'single',
  },
  key_labels = {
    ['<leader>'] = 'LEADER',
    ['<tab>'] = 'TAB',
    ['<cr>'] = 'RET',
  },
  icons = {
    breadcrumb = ' » ',
    separator = '  ',
    group = '[] ',
  },
  hidden = {
    '<silent>',
    '<cmd>',
    '<CMD>',
    '<Cmd>',
    '<CR>',
    'call',
    'lua',
    '^:',
    '^ ',
    'silent',
  },
  disable = {
    buftypes = {},
    filetypes = {
      'Telescope',
      'NvimTree',
    },
  },
})
