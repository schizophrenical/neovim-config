--- LSP related keymaps

---LSP kemaps for some languages
_G.lang_keymaps = {
  java = {
    j = {
      name = 'Java LSP ..',
      s = {
        "<CMD>lua require('jdtls').super_implementation()<CR>",
        'Super Implementation',
      },
      i = {
        "<CMD>lua require('jdtls').organize_imports()<CR>",
        'Organize Imports',
      },
      v = {
        "<CMD>lua require('jdtls').extract_variable()<CR>",
        'Extract Variable',
        mode = { 'n', 'v' },
      },
      m = {
        "<CMD>lua require('jdtls').extract_method()<CR>",
        'Extract Method',
        mode = { 'n', 'v' },
      },
      h = { '<CMD>Telescope lsp_incoming_calls()<CR>', 'Call Hierarchy' },
    },
    t = {
      name = 'Java Test ..',
      c = { "<CMD>lua require('jdtls').test_class()<CR>", 'Test Class' },
      m = {
        "<CMD>lua require('jdtls').test_nearest_method()<CR>",
        'Test Nearest Method',
      },
      r = {
        "<CMD>lua require('telescope').extensions.dap.configurations{}<CR>",
        'Run Configurations',
      },
      d = {
        name = 'Java Debug Repl ..',
        b = {
          "<CMD>lua require('dap').toggle_breakpoint()<CR>",
          'Toggle Breakpoint',
        },
        l = {
          "<CMD>lua require('dap').list_breakpoints()<CR>",
          'List All Breakpoints',
        },
        d = {
          "<CMD>lua require('dap').clear_breakpoints()<CR>",
          'Clear All Breakpoints',
        },
        c = { "<CMD>lua require('dap').continue()<CR>", 'Debug: Continue' },
        s = { "<CMD>lua require('dap').step_over()<CR>", 'Debug: Step Over' },
        i = { "<CMD>lua require('dap').step_into()<CR>", 'Debug: Step Into' },
        x = { "<CMD>lua require('dap').step_out()<CR>", 'Debug: Step Out' },
        X = { "<CMD>lua require('dap').repl.close()<CR>", 'Close DAP repl' },
        T = {
          "<CMD>lua require('dap').terminate()<CR>",
          'Terminate Debug Session',
        },
        u = { "<CMD>lua require('dapui').close()<CR>", 'Close Debug UI' },
      },
    },
  },
}

local M = {}

local lsp_mappings = {
  name = 'LSP ...',
  -- Finding references, diagnostics, etc.
  v = {
    name = 'Find Reference, Declaration, Definitions ...',
    r = { '<CMD>Lspsaga finder<CR>', 'Find References' },
    d = { '<CMD>Lspsaga goto_definition<CR>', 'Definition' },
    D = { '<CMD>Lspsaga goto_type_definition<CR>', 'Type Definition' },
    i = { '<CMD>Lspsaga finder imp<CR>', 'Implementation' },
    n = { '<CMD>Lspsaga incoming_calls<CR>', 'Incoming Calls' },
    o = { '<CMD>Lspsaga outgoing_calls<CR>', 'Outgoing Calls' },
  },
  -- Diagnostics.
  d = {
    name = 'Diagnostics ...',
    e = {
      '<CMD>Lspsaga show_line_diagnostics ++unfocus<CR>',
      'Line Diagnostics',
    },
    f = { '<CMD>Lspsaga show_buf_diagnostics<CR>', 'File Diagnostics' },
    c = { '<CMD>Lspsaga show_cursor_diagnostics<CR>', 'Diagnostics At Cursor' },
    n = { '<CMD>Lspsaga diagnostic_jump_next<CR>', 'Next LSP Diagnostics' },
    p = {
      '<CMD>Lspsaga diagnostic_jump_previous<CR>',
      'Previous LSP Diagnostics',
    },
  },
  -- Signature help.
  ['<C-k>'] = { '<CMD>lua vim.lsp.buf.signature_help()<CR>', 'Signature Help' },
  -- Workspace tools.
  w = {
    name = 'Workspace Tools ..',
    a = {
      '<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>',
      'Add Workspace Folder',
    },
    r = {
      '<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>',
      'Remove Workspace Folder',
    },
    l = {
      '<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
      'List Workspace Folders',
    },
  },
  -- Code Actions
  c = { '<CMD>Lspsaga code_action<CR>', 'Code Actions' },
  -- Rename Symbol
  r = { '<CMD>Lspsaga rename<CR>', 'Rename Symbol' },
  -- Format file.
  f = {
    '<CMD>lua vim.lsp.buf.format()<CR>',
    'Format File',
    mode = {
      'n',
      'v',
    },
  },
}

---Register keymaps to which-key.
---Providing a table will extend the default keymaps before registering them.
---@param filetype string map-like table of which-key mappings.
function M.register_keymaps(filetype)
  local whichkey = require('which-key')

  local ft = vim.tbl_get(_G.lang_keymaps, filetype)
  if ft then
    -- 'keep' to force myself to make proper mappings.
    lsp_mappings = vim.tbl_extend('keep', lsp_mappings, ft)
  end

  whichkey.register({
    ['<leader>'] = {
      l = lsp_mappings,
      -- Hover Doc
      K = { '<CMD>Lspsaga hover_doc<CR>', 'Hover Documentation' },
      -- Trouble
      x = {
        name = 'Trouble ..',
        x = { '<CMD>Trouble document_diagnostics<CR>', 'Document Diagnostics' },
        w = {
          '<CMD>Trouble workspace_diagnostics<CR>',
          'Workspace Diagnostics',
        },
        q = { '<CMD>Trouble quickfix<CR>', 'Quickfix' },
        r = { '<CMD>TroubleRefresh<CR>', 'Refresh Trouble List' },
        X = { '<CMD>TroubleToggle<CR>', 'Close Trouble Window' },
      },
      -- Document Outline
      o = { '<CMD>Lspsaga outline<CR>', 'Document Outline' },
    },
  })
end

return M