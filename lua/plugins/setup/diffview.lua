-- Diffview setup

require('diffview').setup({
  enhanced_diff_hl = true,
  icons = {
    folder_closed = ' ',
    folder_open = ' ',
  },
  signs = {
    fold_closed = '󰡍',
    fold_open = '󰡏',
    done = ' ',
  },
  view = {
    default = {
      winbar_info = true,
    },
    file_panel = {
      width = 45,
    },
  },
})
