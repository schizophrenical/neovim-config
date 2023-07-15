--- Telescope setup

require('telescope').setup({
  defaults = {
    prompt_prefix = '  ',
    selection_caret = '  ',
    entry_prefix = '  ',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    set_env = { ['COLORTERM'] = 'truecolor' },
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    path_display = {
      truncate = 3,
      shorten = 3,
    },
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
      },
    },
    preview = {
      filesize_hook = function(filepath, bufnr, opts)
        local max_bytes = 10000
        local cmd = { 'head', '-c', max_bytes, filepath }
        require('telescope.previewers.utils').job_maker(cmd, bufnr, opts)
      end,
    },
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    winblend = 0,
    border = {},
    borderchars = {
      '═',
      '║',
      '═',
      '║',
      '╔',
      '╗',
      '╝',
      '╚',
    },
    file_ignore_patterns = {
      'node_modules',
      'npm_cache',
      '%.pdf',
      '%.tc',
      '%.groovy',
      '%.rs',
      '%.docx',
      '%.dat',
      '%.xls',
      '%.xlsx',
      '%.ts',
      '%.glbl',
      '%.png',
      '%.svg',
      '%.jpg',
      '%.jpeg',
      '%.odt',
      '%.jar',
      '%.doc',
      '%.cnf',
      '%.prj',
      '%.odg',
      '%.meta',
      '%.csv',
      '%.xcf',
      '%.gif',
      '%lock.json',
      '%.locale',
      '%.class',
    },
  },
  pickers = {
    find_files = {
      find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },
    },
    buffers = {
      theme = 'dropdown',
      initial_mode = 'normal',
    },
    current_buffer_fuzzy_find = {
      -- insert mode on buffer find.
      initial_mode = 'insert',
    },
  },
  extensions = {
    recent_files = {
      only_cwd = true,
    },
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    ['ui-select'] = {
      require('telescope.themes').get_ivy({}),
    },
    ['dap'] = {
      require('telescope.themes').get_ivy({}),
    },
  },
})

-- load extensions
require('telescope').load_extension('recent_files')
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('ui-select')
-- require('telescope').load_extension('dap')
