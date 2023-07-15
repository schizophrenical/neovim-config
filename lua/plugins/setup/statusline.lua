-- custom status line
-- Based on evil_lualine
-- https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua
-- Credits: glepnir, shadmansaleh

local lualine = require('lualine')

-- Colors
local colors = {
  bg = '#1A1A2E',
  fg = '#C5C8C6',
  peach = '#FECEA8',
  yellow = '#FFBA33',
  yellow2 = '#F4A64E',
  orange = '#F8961E',
  orange2 = '#F9844A',
  green = '#90BE6D',
  green3 = '#43AA8B',
  blue = '#3D9CE1',
  blue2 = '#94B4DA',
  turquoise = '#39E6CF',
  violet = '#26264C',
  violet3 = '#1C1C33',
  grey2 = '#708090',
  red = '#E84A5F',
  red2 = '#CC6666',
  git = {
    add = '#43AA8B',
    remove = '#CC6666',
  },
}

local theme = {
  normal = {
    c = { fg = colors.grey2, bg = colors.violet3 },
  },
  inactive = {
    c = { fg = colors.grey2, bg = colors.violet3 },
  },
}

-- conditions
local fn = vim.fn
local conditions = {
  buffer_not_empty = function()
    return fn.empty(fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = fn.expand('%:p:h')
    local gitdir = fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- lualine bare config
local config = {
  options = {
    -- disable separators
    component_separators = '',
    section_separators = '',
    theme = theme,
    globalstatus = true,
    disabled_filetypes = {
      'packer',
      'alpha',
      'man',
      'lspsagaoutline',
      'qf',
      'NvimTree',
      '',
    },
    ignore_focus = {
      'qf',
      'NvimTree',
      'DiffviewFiles',
      'prompt',
      '',
    },
    extensions = {},
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- will be used for custom items
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
  table.insert(config.inactive_sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
  table.insert(config.inactive_sections.lualine_x, component)
end

local git_stat = { ahead = 0, behind = 0 }
local function update_git_stat()
  local Job = require('plenary.job')
  Job:new({
    command = 'git',
    args = { 'rev-list', '--left-right', '--count', 'HEAD...@{upstream}' },
    on_exit = function(job, _)
      local res = job:result()[1]
      if type(res) ~= 'string' then
        git_stat = { ahead = 0, behind = 0 }
        return
      end
      local ok, ahead, behind = pcall(string.match, res, '(%d+)%s*(%d+)')
      if not ok then
        ahead, behind = 0, 0
      end
      git_stat = { ahead = ahead, behind = behind }
    end,
  }):start()
end

if _G.Gstatus_timer == nil then
  _G.Gstatus_timer = vim.loop.new_timer()
else
  _G.Gstatus_timer:stop()
end
_G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_git_stat))

ins_left({
  function()
    return '▊'
  end,
  -- Sets highlighting of component
  color = {
    fg = colors.blue,
  },
  padding = { left = 0, right = 1 },
})

ins_left({
  -- mode component
  'mode',
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.fg,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.yellow,
      no = colors.red2,
      s = colors.orange,
      S = colors.orange2,
      [''] = colors.blue,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.blue,
      rm = colors.blue,
      ['r?'] = colors.cyan,
      ['!'] = colors.turquoise,
      t = colors.red2,
    }
    return {
      fg = mode_color[vim.fn.mode()],
    }
  end,
  padding = { right = 1 },
})

-- filetype
ins_left({
  'filetype',
  colored = true,
  icon_only = true,
  padding = { right = 1 },
  cond = conditions.buffer_not_empty,
})

-- filename
-- relative path with filename
-- finame will have a different color
ins_left({
  function()
    return vim.fn.fnamemodify(vim.fn.expand('%'), ':p:.:h') .. '/'
  end,
  color = {
    fg = colors.grey2,
  },
  padding = { right = 0 },
  cond = conditions.buffer_not_empty,
})

ins_left({
  'filename',
  file_status = true,
  new_file_status = true,
  path = 0,
  color = {
    fg = colors.yellow,
  },
  symbols = {
    modified = '',
    readonly = '',
    unnamed = '-',
    newfile = '',
  },
  padding = { right = 1 },
  cond = conditions.buffer_not_empty,
})

-- diff
ins_left({
  'diff',
  symbols = {
    added = ' ',
    modified = ' ',
    removed = ' ',
  },
  diff_color = {
    added = { fg = colors.git.add },
    modified = { fg = colors.yellow2 },
    removed = { fg = colors.git.remove },
  },
  cond = conditions.check_git_workspace,
})

-- diagnostics
ins_right({
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  colored = true,
  always_visibile = true,
  padding = { left = 1 },
  cond = conditions.hide_in_width,
})

-- location (line:col)
ins_right({
  'location',
  padding = { left = 1 },
  color = {
    fg = colors.grey2,
  },
  cond = conditions.hide_in_width,
})

-- progress
ins_right({
  'progress',
  color = {
    fg = colors.grey2,
  },
  padding = { left = 1 },
  cond = conditions.hide_in_width,
})

-- Spaces/Tabs plus size
ins_right({
  function()
    local bufopt = vim.api.nvim_buf_get_option
    local width = bufopt(0, 'tabstop')
    local effective_width = 0
    local msg = ' '
    if width then
      effective_width = width
      msg = msg .. effective_width
    end

    return msg
  end,
  color = function()
    return {
      fg = vim.api.nvim_buf_get_option(0, 'expandtab') and colors.blue
        or colors.red2,
    }
  end,
  padding = { left = 1 },
  cond = conditions.hide_in_width,
})

-- File format (line endings)
ins_right({
  'fileformat',
  symbols = {
    unix = '󰌽 ', -- e712
    dos = ' ', -- e70f
    mac = ' ', -- e711
  },
  padding = { left = 1 },
  color = {
    fg = colors.green,
  },
  cond = conditions.hide_in_width,
})

-- File encoding
ins_right({
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper,
  padding = { left = 0 },
  color = {
    fg = colors.green,
  },
  cond = conditions.hide_in_width,
})

-- Buffer count
ins_right({
  function()
    local len = vim.fn.len
    local bufinfo = vim.fn.getbufinfo
    local count = len(bufinfo({ buflisted = 1 }))
    return '󱃸 ' .. count
  end,
  color = {
    fg = colors.peach,
  },
  padding = { left = 1 },
  cond = conditions.hide_in_width,
})

-- Lsp server name.
ins_right({
  function()
    local nolsp = ' No LSP'
    local lsp = ' '
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then return nolsp end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return lsp .. client.name
      end
    end
    return nolsp
  end,
  color = {
    fg = colors.orange,
  },
  padding = { left = 1 },
  cond = conditions.hide_in_width,
})

-- git branch
ins_right({
  'branch',
  icon = '',
  fmt = function(str)
    -- with git status ahead/behind
    return str .. ' ' .. git_stat.ahead .. ' ' .. git_stat.behind .. ''
  end,
  color = {
    fg = colors.green3,
  },
  padding = { left = 1 },
  cond = conditions.check_git_workspace,
})

ins_right({
  function()
    return '▊'
  end,
  -- Sets highlighting of component
  color = {
    fg = colors.blue,
  },
  padding = { left = 1, right = 0 },
})

-- setup lualine
lualine.setup(config)
