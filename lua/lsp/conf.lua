--- Config file for LSP Servers

local M = {}
---------------------------------------------------------------------------------------------------
--------------------------------- Java LSP config -------------------------------------------------
---------------------------------------------------------------------------------------------------
local anim = {
  '⣾',
  '⣽',
  '⣻',
  '⢿',
  '⡿',
  '⣟',
  '⣯',
  '⣷',
}
local anim_i = 1

---Progress report handler
---@param _ any any
---@param result table|nil result
---@param ctx table|nil context
function M.progress_handler(_, result, ctx)
  if not ctx then return end

  if not result then return end

  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client then return end

  if result.value then
    local message = result.value
    if message.kind then
      local title = message.title or client.name or ''
      local sub_message = message.message or 'Loading'
      local percent = message.percentage or ''
      if message.kind == 'begin' or message.kind == 'report' then
        -- NOTE: When debugging an issue with config, set boolean to true
        -- to store echoes to :messages
        vim.api.nvim_echo({
          {
            anim[anim_i] .. ' (' .. percent .. '%) ' .. string.sub(
              title,
              1,
              20
            ) .. '..' .. ' >> ' .. string.sub(sub_message, 1, 80) .. '..',
            'Constant',
          },
        }, false, {})
      elseif message.kind == 'end' then
        -- end
        -- blank echo to clear last update
        vim.api.nvim_echo({ { '', 'Constant' } }, false, {})
      end
    end
    -- little animation
    if anim_i <= 5 then
      anim_i = anim_i + 1
    else
      anim_i = 1
    end
  end
end

-- Capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Add folding range to capabilities
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

M.capabilities = capabilities
M.flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 170,
}

---------------------------------------------------------------------------------------------------
--------------------------------- Java LSP config -------------------------------------------------
---------------------------------------------------------------------------------------------------
-- Java tools path
local expand = vim.fn.expand
local java_tools = expand(expand('~/Dev/tools/java'))
-- DAP bundles (Debugger)
local debug_jars = {}
local glob = vim.fn.glob
local split = vim.split
local expr = '*.jar'
-- managed by mason
local bundles_path = vim.fn.stdpath('data') .. '/mason/packages/'
-- Decompiler bundles
-- local decompiler_path = bundles_path .. 'decompiler/'
-- vim.list_extend(bundles, split(glob(decompiler_path .. expr, true), '\n'))
-- Java Debug plugin bundle
local java_debug_path = bundles_path .. 'java-debug-adapter/'
--stylua: ignore
vim.list_extend(
  debug_jars,
  split(glob(java_debug_path .. expr, true),
  '\n')
)
-- Java Debug plugin bundle
local vscode_test_path = bundles_path .. 'java-test/'
for _, jar in pairs(split(glob(vscode_test_path .. expr, true), '\n')) do
  if not vim.endswith(jar, 'runner-jar-with-dependencies.jar') then
    table.insert(debug_jars, jar)
  end
end
---Workspace directory should be unique to every project.
---Here we get the project name.
---i.e.: dir/to/project/my_project will have workspace folder of my_project
local workspace_id = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

M.java = {
  ---Push status with different highlight group
  ---This handler is specific to JDTLS
  ---@param _ any any
  ---@param result table|nil result
  status_update_handler = function(_, result)
    if result and result.message then
      -- Language server is ready
      if result.message == 'ServiceReady' then
        vim.api.nvim_echo(
          { { '[Language Server] : ' .. '﫠 Connected', 'Directory' } },
          false,
          {}
        )
      else
        vim.api.nvim_echo({
          {
            '[Language Server] : .. ' .. string.sub(result.message, 20, 70),
            'Type',
          },
        }, false, {})
      end
    end
  end,
  ---DAP related overrides
  dap_overrides = {
    config_overrides = {
      vmArgs = '--add-modules=ALL-SYSTEM '
        .. '--add-opens java.base/java.util=ALL-UNNAMED '
        .. '--add-opens java.base/java.lang=ALL-UNNAMED '
        .. '--add-opens java.base/java.io=ALL-UNNAMED ',
    },
  },
  -- Java compiler preference file
  compiler_prefs = java_tools .. '/eclipse-compiler-prefs/compiler.prefs',
  -- Debug bundles
  bundles = debug_jars,
  -- Project exclusions
  exclusions = {},
  -- JDK installations
  jdk = {
    jdk_8 = java_tools .. '/jdk-1.8.0.331',
    jdk_11 = java_tools .. '/jdk-11.0.18',
    jdk_17 = java_tools .. '/jdk-17.0.6',
  },
  ---Language server command
  cmd = {
    'jdtls', -- managed by mason
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Xms8g',
    '-Xmx10g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    '-configuration',
    expand(expand('~/.cache/jdtls')),
    '-data',
    expand(expand('~/Dev/tools/java/workspaces')) .. '/' .. workspace_id,
  },
}

return M
