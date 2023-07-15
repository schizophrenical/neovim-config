-- Simple (hacky) terminal.
-- TODO: Always opens a new terminal.
-- Find a way to locate previously opened ones.

local M = {}

---Launch a new terminal with an optional commands table.
---To ensure the proper sequence of commands (if more than one),
---the recommended table format is as follows:
---```lua
---{
--- {
---   [1] = {
---     step = 1 -- IMPORTANT to ensure the right sequence.
---     cmd = 'string command here, like cd /path/to/cd/to'
---   },
---   [2] = {
---     step = 2 -- IMPORTANT to ensure the right sequence.
---     cmd = './buildapp.sh or any command to be run after the 1st step'
---   }
--- }
---}
---```
---A `nil` parameter will result to an interactive shell.
---@param commands nil|table command to launch.
function M.new(commands)
  -- open a new window at the bottom
  vim.cmd('below new')
  -- expand it to the width of the editor.
  vim.cmd('wincmd J')
  -- open a terminal
  -- if there are commands, unpack it then send it to the terminal.
  -- nil means interactive terminal mode.
  if commands then
    local full_cmd = ''
    if not vim.tbl_isempty(commands) then
      -- sort the commands table to ensure proper sequence.
      table.sort(commands, function(a, b)
        return a.step < b.step
      end)
      local with = ' && '
      local first = true
      ---@diagnostic disable-next-line: unused-local
      for i, command in ipairs(commands) do
        if first then
          full_cmd = full_cmd .. ' ' .. command.cmd
          first = false
        else
          full_cmd = full_cmd .. with .. command.cmd
        end
      end
    end
    vim.cmd('term ' .. full_cmd)
  else
    vim.cmd('term')
  end
end

---Run a maven build on the current buffer's parent path.
---The `target` module will be derived from the current buffer's
---absolute path.
---Example:
---buffer is `/some/path/my_project/my_module/my_class.java`
---`Maven` build will execute at:
---`/some/path/my_project/my_module/`
---@param target string target module to run against.
function M.mvn_build(target)
  if target then
    local absolute_path = vim.fn.expand('%:p:h')
    local find = string.find
    local sub = string.sub
    local len = string.len
    -- Get base module path
    local start = find(absolute_path, target, 1, true)
    local module_path = sub(absolute_path, 1, start + len(target))
    if module_path then
      -- A pre-defined table to ensure that we get the right order of commands.
      local mvn_build = {
        -- cd to the module directory
        [1] = { step = 1, cmd = 'cd ' .. module_path },
        -- run compile command
        [2] = { step = 2, cmd = 'mvn test-compile -Dspotless.skip.check' },
      }
      -- Open a new terminal; sending the command table.
      M.new(mvn_build)
    end
  else
    print(
      'No target provided (or not within the current buffer path), nothing to do..'
    )
  end
end

return M