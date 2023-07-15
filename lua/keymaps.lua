-- Global (default) Keymaps
local whichkey = require('which-key')

-- LEADER
vim.g.mapleader = ' '

---------------------------------------------------------------------------------------------------
-- Leader triggered keymaps
---------------------------------------------------------------------------------------------------
whichkey.register({
  ["<leader>"] = {
    -- Writing/saving file(s)
    w = {
      name = 'Save ...',
      w = { '<CMD>silent w<CR>', 'Save File' },
      a = { '<CMD>silent wa<CR>', 'Save All Files' }
    },
    -- Exit nvim (yeah, we FINALLY know how to do it)
    q = {
      name = 'Quit ...',
      q = { '<CMD>silent q!<CR>', 'Quit w/o Saving' },
      X = { '<CMD>silent q<CR>', 'Quit Neovim :(' },
    },
    -- File Browsing (Global)
    f = {
      name = 'Find Files ...',
      f = { "<CMD>silent lua require('telescope.builtin').find_files()<CR>", 'Find File(s)' },
      s = { "<CMD>silent lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", 'Search in File'},
      r = { "<CMD>silent lua require('telescope').extensions.recent_files.pick()<CR>", 'Find File(s)' },
      b = { "<CMD>silent lua require('telescope.builtin').buffers()<CR>", 'List Active Buffers' },
      h = { "<CMD>silent lua require('telescope.builtin').help_tags()<CR>", 'Find Help Tags' },
      g = { "<CMD>silent lua require('telescope.builtin').live_grep()<CR>", 'Live Grep' },
      t = { "<CMD>silent lua require('nvim-tree').toggle()<CR>", 'File Tree', },
      i = { "<CMD>silent lua require('nvim-tree/api').tree.focus()<CR>", 'Focus File Tree', },
    },
    -- Terminal
    t = {
      name = 'Terminal ...',
      d = { "<CMD>silent lua require('terminal').new()<CR>", 'Terminal at the bottom' },
      b = { "<CMD>silent term<CR>", 'Terminal in new buffer' },
    },
    -- Git
    g = {
      name = 'Git ...',
      g = { "<CMD>silent term lazygit<CR>", 'Launch Lazygit' },
      I = { "<CMD>silent DiffviewOpen<CR>", 'Diff to Index' },
      i = { "<CMD>silent DiffviewOpen -- %<CR>", 'Diff to Index (Current File)'},
      h = { "<CMD>silent DiffviewFileHistory %<CR>", 'History (Current File)' },
      b = { "<CMD>silent DiffviewFileHistory<CR>", 'History (Branch)' },
      B = { "<CMD>silent DiffviewFileHistory --no-merges<CR>", 'History (Branch - No merges)' },
      x = { "<CMD>silent DiffviewClose<CR>", 'Close Diff View' },
      t = { "<CMD>silent lua require('gitsigns').toggle_current_line_blame()<CR>", 'Toggle Line Blame'},
      p = { "<CMD>silent lua require('gitsigns').preview_hunk_inline()<CR>", 'Preview Hunk Inline'},
      r = { "<CMD>silent lua require('gitsigns').reset_hunk()<CR>", 'Reset Change'},
      s = { "<CMD>silent lua require('gitsigns').stage_hunk()<CR>", 'Stage Change' },
      S = { "<CMD>silent lua require('gitsigns').stage_buffer()<CR>", 'Stage File' },
      n = { "<CMD>silent lua require('gitsigns').next_hunk()<CR>", 'Next Change' },
      N = { "<CMD>silent lua require('gitsigns').prev_hunk()<CR>", 'Previous Change' },
      u = { "<CMD>silent lua require('gitsigns').undo_stage_hunk()<CR>", 'Unstage Change' },
    },
    -- Generate Code Docs
    a = {
      name = 'Generate Code Docs ...',
      c = { "<CMD>silent lua require('neogen').generate({type = 'class'})<CR>", 'Classes Annotations' },
      m = { "<CMD>silent lua require('neogen').generate({type = 'func'})<CR>", 'Method/Func Annotations' },
    },
    -- Colorizer
    c = {
      -- NOTE: Lazyloaded.
      name = 'Colorizer',
      l = { "<CMD>silent lua require('colorizer')<CR>", 'Load colorizer plugin' },
      t = { "<CMD>silent ColorizerToggle<CR>", 'Toggle Colorizer' },
    },
    -- Comment line.
    ['/'] = { '<Plug>kommentary_line_default', 'Comment Line' },
    -- Format using formatter
    F = {
      "<CMD>silent Format<CR>",
      'Format via Formatter',
      mode = {
        'n', 'v'
      },
    },
    -- Format using formatter
    u = {
      name = 'Plugins and Packages',
      l = {"<CMD>silent lua require('lazy').home()<CR>", 'Lazy'},
      m = {"<CMD>silent lua require('mason.ui').open()<CR>", 'Mason'},
    },
  }
})
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Non-leader triggered keymaps
---------------------------------------------------------------------------------------------------
-- Remap C-j to down
whichkey.register({
  name = 'Next Line',
  ['<C-j>'] = { 'j', 'Next Line' }, },{})
-- Remap j to jzz
whichkey.register({
  name = 'Next Line then Center',
  j = { 'jzz', 'Next Line then Center' },
}, {})

-- Remap C-k to up
whichkey.register({
  name = 'Previous Line',
  ['<C-k>'] = { 'k', 'Previous Line' },
},{})

-- Remap k to kzz
whichkey.register({
  name = 'Previous Line then Center',
  k = { 'kzz', 'Previous Line then Center' },
}, {})

-- Remap yy to yank to clipboard
whichkey.register({
  name = 'Yank to Clipboard',
  Y = {
    '"+y',
    'Yank to Clipboard',
    mode = {'v', 'n'},
  }
})

-- Remap pp to post from clipboard
whichkey.register({
  name = 'Post from Clipboard',
  P = {
    '"+p',
    'Post from Clipboard',
    mode = {'v', 'n'},
  }
})

-- Search highlights
whichkey.register({
  name = 'Search Highlights',
  n = { [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], 'Search Highlights' },
  N = { [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], 'Search Highlights' },
})

-- Close active buffer
whichkey.register({
  name = 'Close Buffer',
  ['<leader>'] = { ':bd<CR>', 'Close Buffer' },
}, { prefix = 'q' })

-- Clear search highlights
whichkey.register({
  name = 'Clear Search Highlights',
  ['<leader>'] = { ':noh<CR>', 'Clear Search Highlights' },
}, { prefix = ',' })

-- Comment selection.
whichkey.register({
  ['<leader>'] = {
    name = 'commentvisual',
    ['/'] = { '<Plug>kommentary_visual_default', 'Comment Selection', mode = 'v' },
  }
})
---------------------------------------------------------------------------------------------------


