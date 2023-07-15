--- Package manager util
--- INFO: Plugin params here are names of the lua files, not the actual plugin names.

local M = {}

---Table of opts/config files.
_G.plugin_opts = {}

---Initialize opts/config table.
local function init_opts_files()
  -- WARN: Make sure to update the path in case of config refactoring.
  if vim.tbl_isempty(_G.plugin_opts) then
    local opts_dir = vim.fn.glob(vim.fn.stdpath('config') .. '/lua/plugins/setup/*.lua')
    for _, p in pairs(vim.fn.split(opts_dir, '\n')) do
      _G.plugin_opts[vim.fn.fnamemodify(p, ':t:r')] = true
    end
  end
end

---Prints a log message.
---@param plugin string plugin name.
---@param type string opts|config.
---@param hl string message highlight.
local function log(plugin, type, hl)
  vim.api.nvim_echo({
    { 'No ' .. type .. ' file found for ' .. plugin, hl }
  }, false, {})
end

---Retrieve load function for the provided plugin.
---Returns an empty table when load function file is not found.
---@param plugin string
---@return function function that defines the setup for the plugin.
function M.get_config(plugin)
  init_opts_files()
  if _G.plugin_opts[plugin] then
    -- NOTE: lazy.nvim advises to provide a function for the `config` field.
    -- https://github.com/folke/lazy.nvim/commit/7260a2b28be807c4bdc1caf23fa35c2aa33aa6ac
    return function()
      -- WARN: Make sure to update the path in case of config refactoring.
      require('plugins.setup.' .. plugin)
    end
  else
    log(plugin, 'config', 'WarningMsg')
    -- return empty function as fallback.
    return function()
      -- Hello world.
    end
  end
end

---Determine if CWD is git tracked.
---@return boolean boolean `true` if git tracked, `false` if otherwise.
function M.is_git_tracked()
  local filepath = vim.fn.getcwd()
  local gitdir = vim.fn.finddir('.git', filepath .. ';')
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end

return M