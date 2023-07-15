-- vim-illuminate setup

require('illuminate').configure({
  -- providers: provider used to get references in the buffer, ordered by priority
  providers = {
    'lsp',
    'treesitter',
  },
  filetypes_denylist = {
    'NvimTree',
    'alpha',
    'qf',
    'Trouble',
    'TelescopePrompt',
  },
  under_cursor = true,
  modes_allowlist = { 'n' },
  large_file_cutoff = 2200,
  min_count_to_highlight = 2,
})