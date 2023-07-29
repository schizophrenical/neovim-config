--- Lazy Package Manager

local util = require('plugins.util')

-- While we can use lazy opts with config, the plugins' setup will be tied up to its specifications.
-- Using the good old require('plugin').setup() files decouples them from lazy.
-- Just in case a new viable plugin manager arrives. Who knows? :)
local plugins = {
  -------------------------------------------------------------------------------------------------
  ------------------------ Syntax Highlighting and code formatters --------------------------------
  -------------------------------------------------------------------------------------------------
  ---Code highlights
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufRead',
    config = util.get_config('treesitter'),
    init = function()
      require('nvim-treesitter.install').update({
        with_sync = true,
      })
    end,
  },
  ---Autopairs
  {
    'windwp/nvim-autopairs',
    event = 'BufRead',
    config = true,
  },
  ---Markdown highlights
  {
    'lukas-reineke/headlines.nvim',
    config = true,
    ft = {
      'markdown',
      'rmd',
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  ---Code comments
  {
    'b3nj5m1n/kommentary',
    config = util.get_config('kommentary'),
  },
  ---Formatter
  {
    'mhartington/formatter.nvim',
    ft = {
      'java',
      'lua',
      'sh',
    },
    config = util.get_config('formatter'),
  },
  ---Code folding
  {
    'kevinhwang91/nvim-ufo',
    event = 'LspAttach',
    config = util.get_config('ufo'),
    dependencies = {
      'kevinhwang91/promise-async',
    },
  },
  ---Indent lines
  {
    'lukas-reineke/indent-blankline.nvim',
    config = util.get_config('indent'),
  },
  ---Illuminate (variable/function usage highlight)
  {
    'RRethy/vim-illuminate',
    event = 'BufRead',
    config = util.get_config('illuminate'),
  },
  ---Treesitter context
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = util.get_config('ts-context'),
  },
  ---Nim
  {
    'alaviss/nim.nvim',
    ft = { 'nim' }
  },
  -------------------------------------------------------------------------------------------------
  ----------------------------------------- LSP ---------------------------------------------------
  -------------------------------------------------------------------------------------------------
  ---Lsp configurations
  {
    'neovim/nvim-lspconfig',
    lazy = true,
  },
  ---Neodev
  {
    'folke/neodev.nvim',
    lazy = true,
  },
  ---LSP Saga (lsp ui enhancements)
  {
    'nvimdev/lspsaga.nvim',
    config = util.get_config('lspsaga'),
    event = 'LspAttach',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  ---Code completion (nvim-cmp)
  ---Plugins completion
  {
    'KadoBOT/cmp-plugins',
    lazy = true,
    config = util.get_config('cmp-plugins'),
  },
  ---LSP Kinds (Initialized by CMP)
  {
    'onsails/lspkind.nvim',
    lazy = true,
  },
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    config = util.get_config('cmp'),
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'dmitmel/cmp-cmdline-history',
      'amarakon/nvim-cmp-buffer-lines',
      -- Luasnip
      {
        'L3MON4D3/LuaSnip',
        version = '1.2.1',
        config = util.get_config('luasnip'),
        dependencies = {
          'rafamadriz/friendly-snippets',
        },
        build = 'make install_jsregexp',
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'prabirshrestha/vim-lsp',
      'dmitmel/cmp-vim-lsp',
      'lukas-reineke/cmp-under-comparator',
      'KadoBOT/cmp-plugins',
      'onsails/lspkind.nvim',
    },
  },
  ---Trouble
  {
    'folke/trouble.nvim',
    lazy = true,
    -- Just use defaults
    config = true,
  },
  ---Java Language Server (jdtls)
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
  },
  -------------------------------------------------------------------------------------------------
  ----------------------------------------- DAP ---------------------------------------------------
  -------------------------------------------------------------------------------------------------
  {
    'rcarriga/nvim-dap-ui',
    -- Java for now ...
    ft = 'java',
    config = util.get_config('dap-ui'),
    dependencies = {
      'mfussenegger/nvim-dap',
    },
  },
  -------------------------------------------------------------------------------------------------
  ----------------------------------- Versioning (Git) --------------------------------------------
  -------------------------------------------------------------------------------------------------
  {
    'sindrets/diffview.nvim',
    cond = util.is_git_tracked,
    config = util.get_config('diffview'),
  },
  {
    'lewis6991/gitsigns.nvim',
    cond = util.is_git_tracked,
    config = util.get_config('gitsigns'),
  },
  -------------------------------------------------------------------------------------------------
  ---------------------------------- External Packages --------------------------------------------
  -------------------------------------------------------------------------------------------------
  --- Mason
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
    build = ':MasonUpdate',
  },
  ---JSON schemastore
  {
    'b0o/schemastore.nvim',
    lazy = true,
  },
  -------------------------------------------------------------------------------------------------
  -------------------------------------- Keymap ---------------------------------------------------
  -------------------------------------------------------------------------------------------------
  ---Keymapping (which-key)
  {
    'folke/which-key.nvim',
    lazy = true,
    config = util.get_config('which-key'),
  },
  -------------------------------------------------------------------------------------------------
  -------------------------------- Files and Files Search -----------------------------------------
  -------------------------------------------------------------------------------------------------
  ---Finder (telescope)
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    lazy = true,
    config = util.get_config('telescope'),
    -- extensions
    dependencies = {
      -- Plenary
      'nvim-lua/plenary.nvim',
      -- Fzy plugin
      'nvim-telescope/telescope-fzy-native.nvim',
      -- UI Select
      'nvim-telescope/telescope-ui-select.nvim',
      -- Recent files
      'smartpde/telescope-recent-files',
      -- Telescope dap extension
      -- 'nvim-telescope/telescope-dap.nvim',
    },
  },
  ---Filetree (nvim-tree)
  {
    'nvim-tree/nvim-tree.lua',
    lazy = true,
    tag = 'nightly',
    config = util.get_config('nvim-tree'),
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },
  ---Leap (fast motion)
  {
    'ggandor/leap.nvim',
    keys = {
      's',
      'S',
    },
    config = function()
      require('leap').add_default_mappings()
    end,
    dependencies = {
      'ggandor/flit.nvim',
      keys = {
        'f',
        'F',
      },
      config = true,
    },
  },
  -------------------------------------------------------------------------------------------------
  ------------------------------------ UI/UX Stuff ------------------------------------------------
  -------------------------------------------------------------------------------------------------
  ---Colorscheme
  {
    dir = '~/Dev/projects/midnight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('midnight').setup({
        on_highlight = function(hl, color)
          --`DiagnosticSignError`
          hl.DiagnosticSignError = {
            fg = color.red,
            bg = color.violet2,
            bold = true,
          }
          --`DiagnosticSignWarn`
          hl.DiagnosticSignWarn = {
            fg = color.orange,
            bg = color.violet2,
            bold = true,
          }
          --`DiagnosticSignInfo`
          hl.DiagnosticSignInfo = {
            fg = color.green,
            bg = color.violet2,
            bold = true,
          }
          --`DiagnosticSignHint`
          hl.DiagnosticSignHint = {
            fg = color.green3,
            bg = color.violet2,
            bold = true,
          }
        end,
      })
    end,
  },
  ---Statusline (lualine)
  {
    'nvim-lualine/lualine.nvim',
    config = util.get_config('statusline'),
  },
  ---Statuscolumn
  {
    'luukvbaal/statuscol.nvim',
    event = 'BufRead',
    config = util.get_config('statuscolumn'),
  },
  ---Todo comments
  {
    'folke/todo-comments.nvim',
    priority = 200,
    config = util.get_config('todo'),
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  ---Hex color highlights
  {
    'norcalli/nvim-colorizer.lua',
    lazy = true,
  },
  ---Smooth scroll (cinnamon)
  {
    'declancm/cinnamon.nvim',
    config = true,
  },
  ---Search highlights
  {
    'kevinhwang91/nvim-hlslens',
    lazy = true,
    config = true,
  },
  ---Greeter (alpha)
  {
    'goolord/alpha-nvim',
    config = util.get_config('alpha'),
  },
}

---------------------------------------------------------------------------------------------------
-------------------------------- Lazy Bootstrap and Setup -----------------------------------------
---------------------------------------------------------------------------------------------------
local M = {}

---Bootstrap lazy on first load
function M.bootstrap()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      -- latest stable release
      '--branch=stable',
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)
end

---Lazy package manager setup
function M.setup()
  require('lazy').setup(plugins, {
    -- use defaults.
  })
end

return M
