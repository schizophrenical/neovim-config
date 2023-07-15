--- Formatter setup

local util = require('formatter.util')

require('formatter').setup({
  filetype = {
    lua = {
      function()
        return {
          exe = 'stylua',
          args = {
            '--search-parent-directories',
            '--stdin-filepath',
            util.escape_path(util.get_current_buffer_file_path()),
            '--',
            '-',
          },
          stdin = true,
        }
      end,
    },
    java = {
      function()
        return {
          exe = 'google-java-format',
          args = {
            vim.api.nvim_buf_get_name(0),
          },
          stdin = true,
        }
      end,
    },
    sh = {
      require('formatter.filetypes.sh').shfmt,
    },
  },
})
