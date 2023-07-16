-- Autocmds

local group = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_autocmd
local prefix = '_mine.'

---------------------------------------------------------------------------------------------------
-- Terminal autocmd
---------------------------------------------------------------------------------------------------
local term = group(prefix .. 'Terminal', { clear = true })

-- Remove line numbers on terminal.
cmd('TermOpen', {
  command = 'silent setlocal nonumber norelativenumber nocul',
  group = term,
})
-- Start with insert mode
cmd('TermOpen', {
  command = 'startinsert',
  group = term,
})
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Quickfix to Trouble autocmd
---------------------------------------------------------------------------------------------------
local quickfix = group(prefix .. 'Quickfix', { clear = true })

---Defer to trouble when opening quickfix items.
function Quickfix_to_trouble()
  local ok, trouble = pcall(require, 'trouble')
  if ok then
    vim.defer_fn(function()
      vim.cmd('cclose')
      trouble.open('quickfix')
    end, 0)
  end
end

-- Push quickfix list to trouble.
cmd('BufWinEnter', {
  pattern = { 'quickfix' },
  command = 'silent lua Quickfix_to_trouble()',
  group = quickfix,
})
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- NvimTree autocmd
---------------------------------------------------------------------------------------------------
local treeclose = group(prefix .. 'NvimTree', { clear = true })

local tree_api = require('nvim-tree.api')
local is_tree_open = false

---Autoclose nvim-tree on bufferleave
function Auto_close_nvimtree()
  -- nvim-tree has an autoclose feature,
  -- but it's only for floating windows.
  if is_tree_open then tree_api.tree.close() end
end

tree_api.events.subscribe(tree_api.events.Event.TreeOpen, function()
  is_tree_open = true
end)

tree_api.events.subscribe(tree_api.events.Event.TreeClose, function()
  is_tree_open = false
end)

---Autoclose nvim-tree on bufferleave
cmd('BufWinEnter', {
  pattern = { '*', '^\\NvimTree' },
  command = 'silent lua Auto_close_nvimtree()',
  group = treeclose,
})
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- q on help and man
---------------------------------------------------------------------------------------------------
local q_help = group(prefix .. 'QHelp', { clear = true })

-- q to quit in help or man files
cmd('FileType', {
  pattern = {
    'help',
    'man',
    'vimdoc',
  },
  group = q_help,
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Always open help on a vertical split.
---------------------------------------------------------------------------------------------------
local vertical_help = group(prefix .. 'verticalHelp', { clear = true })

cmd('BufEnter', {
  pattern = {
    '*.txt',
  },
  group = vertical_help,
  callback = function()
    if vim.o.filetype == 'help' then vim.cmd.wincmd('L') end
  end,
})
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- LSP Attach and detach
---------------------------------------------------------------------------------------------------
local lsp = group(prefix .. 'lsppp', { clear = true })

cmd('LspAttach', {
  group = lsp,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
    if client then
      if client.server_capabilities.completionProvider then
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
      end
      if client.server_capabilities.definitionProvider then
        vim.bo[bufnr].tagfunc = 'v:lua.vim.lsp.tagfunc'
      end
      if ft == 'java' then
        -- Disable semantic tokens for Java
        client.server_capabilities.semanticTokenProvider = nil
        local dap_overrides = require('lsp.conf').java.dap_overrides
        require('jdtls').setup_dap(dap_overrides)
      end
    end
    -- register language specific keymaps
    require('lsp.keymaps').register_keymaps(ft)
    -- enable inlay hints
    if not ft == 'java' then vim.lsp.inlay_hint(bufnr, true) end
  end,
})

cmd('LspDetach', {
  group = lsp,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then vim.cmd('setlocal tagfunc< omnifunc<') end
  end,
})
---------------------------------------------------------------------------------------------------
